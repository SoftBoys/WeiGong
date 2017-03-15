//
//  WGChatHelper.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/28.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGChatHelper.h"
#import <EMSDK.h>
#import "EaseSDKHelper.h"

#import "EMCDDeviceManager.h"
#import <UserNotifications/UserNotifications.h>

#import "WGChatCell.h"

static const CGFloat kDefaultPlaySoundInterval = 3.0;
static NSString *kMessageType = @"MessageType";
static NSString *kConversationChatter = @"ConversationChatter";

@interface WGChatHelper () <EMClientDelegate, EMChatManagerDelegate>
@property (nonatomic, strong) NSDate *lastPlaySoundDate;

@end
@implementation WGChatHelper
+ (instancetype)shareInstance {
    static WGChatHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[WGChatHelper alloc] init];
    });
    return helper;
}
- (instancetype)init {
    if (self = [super init]) {
        [[EMClient sharedClient] addDelegate:self];
        [[EMClient sharedClient].chatManager addDelegate:self];
    }
    return self;
}
- (void)dealloc {
    [[EMClient sharedClient] removeDelegate:self];
    [[EMClient sharedClient].chatManager removeDelegate:self];
}


#pragma mark - EMClientDelegate
#pragma mark - SDK连接服务器的状态变化时会接收到该回调
- (void)connectionStateDidChange:(EMConnectionState)aConnectionState {
    
}
#pragma mark - 当前登录账号在其它设备登录时会接收到此回调
- (void)userAccountDidLoginFromOtherDevice {
    [MBProgressHUD wg_message:@"你的账号已在其他地方登录"];
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
    [self.cyl_tabBarController cyl_popSelectTabBarChildViewControllerAtIndex:0];
}
#pragma mark - 当前登录账号已经被从服务器端删除时会收到该回调
- (void)userAccountDidRemoveFromServer {
    [MBProgressHUD wg_message:@"你的账号已被从服务器端移除"];
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
    [self.cyl_tabBarController cyl_popSelectTabBarChildViewControllerAtIndex:0];
}
#pragma mark - 服务被禁用
- (void)userDidForbidByServer {
    [MBProgressHUD wg_message:@"服务被禁用"];
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
    [self.cyl_tabBarController cyl_popSelectTabBarChildViewControllerAtIndex:0];
}
//#pragma mark - 当前登录账号已经被从服务器端删除时会收到该回调
//- (void)userAccountDidRemoveFromServer {
//    [MBProgressHUD wg_message:@"你的账号已被从服务器端移除"];
//    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
//}


#pragma mark - EMChatManagerDelegate

- (void)messagesDidReceive:(NSArray *)aMessages {
//    BOOL isRefreshCons = YES;
    for(EMMessage *message in aMessages){
        BOOL needShowNotification = (message.chatType != EMChatTypeChat) ? [self _needShowNotification:message.conversationId] : YES;
        
        if (needShowNotification) {
#if !TARGET_IPHONE_SIMULATOR
            UIApplicationState state = [[UIApplication sharedApplication] applicationState];
            switch (state) {
                case UIApplicationStateActive:
                    [self playSoundAndVibration];
                    break;
                case UIApplicationStateInactive:
                    [self playSoundAndVibration];
                    break;
                case UIApplicationStateBackground:
                    [self showNotificationWithMessage:message];
                    break;
                default:
                    break;
            }
#endif
        }
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:kNoti_UpdateUnreadMessageCount object:nil];
    
}


- (void)playSoundAndVibration {
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        //如果距离上次响铃和震动时间太短, 则跳过响铃
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
        return;
    }
    
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    
    // 收到消息时，播放音频
    [[EMCDDeviceManager sharedInstance] playNewMessageSound];
    // 收到消息时，震动
    [[EMCDDeviceManager sharedInstance] playVibration];
}

#pragma mark - private
- (BOOL)_needShowNotification:(NSString *)fromChatter {
    BOOL ret = YES; // getGroupsWithoutPushNotification
    NSArray *igGroupIds = [[EMClient sharedClient].groupManager getGroupsWithoutPushNotification:nil];
    for (NSString *str in igGroupIds) {
        if ([str isEqualToString:fromChatter]) {
            ret = NO;
            break;
        }
    }
    return ret;
}

- (void)showNotificationWithMessage:(EMMessage *)message {
    EMPushOptions *options = [[EMClient sharedClient] pushOptions];
    NSString *alertBody = nil;
    if (options.displayStyle == EMPushDisplayStyleMessageSummary) {
        EMMessageBody *messageBody = message.body;
        NSString *messageStr = nil;
        switch (messageBody.type) {
            case EMMessageBodyTypeText: {
                messageStr = ((EMTextMessageBody *)messageBody).text;
            }
                break;
            case EMMessageBodyTypeImage: {
                messageStr = @"图片";
            }
                break;
            case EMMessageBodyTypeLocation: {
                messageStr = @"位置";
            }
                break;
            case EMMessageBodyTypeVoice: {
                messageStr = @"音频";
            }
                break;
            case EMMessageBodyTypeVideo: {
                messageStr = @"视频";
            }
                break;
            default:
                break;
        }
        
        NSDictionary *ext = message.ext;
        NSString *title = ext[kChatNickName];
        if (title == nil) {
            title = message.from;
        }
//            if (message.chatType == EMChatTypeGroupChat) {
//                NSDictionary *ext = message.ext;
//                
//                NSArray *groupArray = [[EMClient sharedClient].groupManager getJoinedGroups];
//                for (EMGroup *group in groupArray) {
//                    if ([group.groupId isEqualToString:message.conversationId]) {
//                        title = [NSString stringWithFormat:@"%@(%@)", message.from, group.subject];
//                        break;
//                    }
//                }
//            }
        
        alertBody = [NSString stringWithFormat:@"%@:%@", title, messageStr];
    }
    else {
        alertBody = @"您有一条新消息";
    }
    
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.lastPlaySoundDate];
    BOOL playSound = NO;
    if (!self.lastPlaySoundDate || timeInterval >= kDefaultPlaySoundInterval) {
        self.lastPlaySoundDate = [NSDate date];
        playSound = YES;
    }
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[NSNumber numberWithInt:message.chatType] forKey:kMessageType];
    [userInfo setObject:message.conversationId forKey:kConversationChatter];
    
    //发送本地推送
    if (NSClassFromString(@"UNUserNotificationCenter")) {
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:0.01 repeats:NO];
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        if (playSound) {
            content.sound = [UNNotificationSound defaultSound];
        }
        content.body =alertBody;
        content.userInfo = userInfo;
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:message.messageId content:content trigger:trigger];
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:nil];
    } else {
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.fireDate = [NSDate date]; //触发通知的时间
        notification.alertBody = alertBody;
        notification.alertAction = @"打开";
        notification.timeZone = [NSTimeZone defaultTimeZone];
        if (playSound) {
            notification.soundName = UILocalNotificationDefaultSoundName;
        }
        notification.userInfo = userInfo;
        
        //发送通知
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
}

@end
