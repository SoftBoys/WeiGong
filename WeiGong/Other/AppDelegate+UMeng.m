//
//  AppDelegate+UMeng.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/17.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "AppDelegate+UMeng.h"
#import "AppDelegate+Chat.h"
#import <UMMobClick/MobClick.h>
#import "UMessage.h"
#import <EMSDK.h>
#import <UserNotifications/UserNotifications.h>

#import "WG_UserDefaults.h"

#import "WG_UpdateTokenNetTool.h"

@implementation WG_UserInfo
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"info_id":@"id"};
}
@end

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate (UMeng) 

- (void)setUMeng {
    
    [MobClick setAppVersion:XcodeAppVersion];
    
    UMConfigInstance.appKey = @"557e687b67e58e7a080002c3";
    UMConfigInstance.secret = nil;
    [MobClick startWithConfigure:UMConfigInstance];
    
#ifdef DEBUG
    [MobClick setLogEnabled:YES];
#else
    [MobClick setLogEnabled:NO];
#endif

}

- (void)setUMessageWithOptions:(NSDictionary *)launchOptions {
    
    [UMessage startWithAppkey:@"557e687b67e58e7a080002c3" launchOptions:launchOptions];
    [UMessage setAutoAlert:NO];
    [UMessage registerForRemoteNotifications];
    
#if DEBUG
    [UMessage setLogEnabled:YES];
#else
    [UMessage setLogEnabled:NO];
#endif
    // 有推送消息
    if (launchOptions) {
        NSDictionary *userInfo = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
        [self receiveNotification:userInfo];
    }
//#warning 测试推送
//    [self testAPNS];
}
- (void)testAPNS {
    NSDictionary *userInfo = @{@"data":@{@"content":@"content",@"title":@"title",@"id":@"1"}};
    [self receiveNotification:userInfo];
}
- (void)receiveNotification:(NSDictionary *)userInfo {
    if (userInfo == nil) {
        return;
    }
    NSDictionary *info = [self localUserInfoWithUserInfo:userInfo];
    
    if (info) {
        WG_UserInfo *userInfo = [WG_UserInfo mj_objectWithKeyValues:info];
        UIApplicationState state = [UIApplication sharedApplication].applicationState;
        if (state == UIApplicationStateActive) {
            NSString *title = userInfo.title;
            NSString *message = userInfo.content;
            if (title == nil) {
                title = @"";
            }
            if (message == nil) {
                message = @"";
            }
            [UIAlertController wg_alertWithTitle:title message:message completion:^(UIAlertController *alert, NSInteger buttonIndex) {
                if (buttonIndex) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNoti_ReceiveNoti object:@{kReceiveNotiKey:userInfo}];
                }
            } cancel:@"取消" sure:@"查看"];
        } else {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kNoti_ReceiveNoti object:@{kReceiveNotiKey:userInfo}];
            
        }
    }
}
- (NSDictionary *)localUserInfoWithUserInfo:(NSDictionary *)userInfo {
    //获取json字符串
    id data = userInfo[@"data"];
    
    if ([data isKindOfClass:[NSDictionary class]]) {
        return data;
    } else if ([data isKindOfClass:[NSString class]]) {
        //json解析
        NSData *data1 = [[NSData alloc]initWithData:[(NSString *)data dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSError *error = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            WGLog(@"解析推送消息失败");
            return nil;
        } else {
            return dict;
        }
    }
    return nil;
}

#pragma mark - UIApplicationDelegate
#pragma mark - 推送消息
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    [UMessage registerDeviceToken:deviceToken];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[EMClient sharedClient] bindDeviceToken:deviceToken];
    });
    // 更新token信息
    [WG_UpdateTokenNetTool wg_toolWithDeviceToken:[self stringTokenWithDataToken:deviceToken]];
}
// 收到远程推送
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo {
    //关闭友盟自带的弹出框
    [UMessage setAutoAlert:NO];
    [UMessage didReceiveRemoteNotification:userInfo];
    // 处理推送消息
    [self receiveNotification:userInfo];
    
    [self easemobApplication:application didReceiveRemoteNotification:userInfo];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [UMessage didReceiveRemoteNotification:userInfo];
    // 处理推送消息
    [self receiveNotification:userInfo];
    
    [self easemobApplication:application didReceiveRemoteNotification:userInfo];
}
// 本地推送
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
}
// ios10 处理前台收到通知的代理方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    
    NSDictionary *userInfo = notification.request.content.userInfo;
    
    if ([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [UMessage didReceiveRemoteNotification:userInfo];
    }
//    [UMessage didReceiveRemoteNotification:userInfo];
    // 处理推送消息
    [self receiveNotification:userInfo];
    
    [self easemobApplication:[UIApplication sharedApplication] didReceiveRemoteNotification:userInfo];
}
// ios10 的 处理后台点击通知的代理方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    
    if ([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [UMessage didReceiveRemoteNotification:userInfo];
    }
}


- (NSString *)stringTokenWithDataToken:(NSData *)deviceToken {
    NSString *strToken = [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""] stringByReplacingOccurrencesOfString: @">" withString: @""]
                          stringByReplacingOccurrencesOfString: @" " withString: @""];
    return strToken;
}




@end
