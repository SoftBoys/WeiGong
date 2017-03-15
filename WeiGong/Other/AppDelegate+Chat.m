//
//  AppDelegate+Chat.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/27.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "AppDelegate+Chat.h"

#import "EaseSDKHelper.h"
#import "WGChatHelper.h"
#import <CYLTabBarController.h>
#import "WG_UserDefaults.h"


@implementation AppDelegate (Chat)
- (void)easemobApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //注册登录状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:KNOTIFICATION_LOGINCHANGE
                                               object:nil];
    
    NSString *appKey = @"vhtk#weigong";
    NSString *certName = @"";
#if DEBUG
    certName = @"weigongDev";
#else
    certName = @"weigongDis";
#endif
    NSDictionary *otherConfig = @{kSDKConfigEnableConsoleLogger:@(YES)};
    [[EaseSDKHelper shareHelper] hyphenateApplication:application
                        didFinishLaunchingWithOptions:launchOptions
                                               appkey:appKey
                                         apnsCertName:certName
                                          otherConfig:otherConfig];
    
    BOOL isAutoLogin = [EMClient sharedClient].isAutoLogin;
    if (isAutoLogin){
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
    }
}
- (void)easemobApplication:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [[EaseSDKHelper shareHelper] hyphenateApplication:application didReceiveRemoteNotification:userInfo];
}
- (void)loginStateChange:(NSNotification *)noti {
    
    BOOL loginSuccess = [noti.object boolValue];
    
    if (loginSuccess) {//登陆成功加载主窗口控制器
        WGLog(@"环信登陆");
        [[NSNotificationCenter defaultCenter] postNotificationName:kNoti_UpdateUnreadMessageCount object:nil];
    } else {//登陆失败加载登陆页面控制器
//        [[NSNotificationCenter defaultCenter] postNotificationName:kNoti_UpdateUnreadMessageCount object:@(0)];
        WGLog(@"环信退出");
        [WGChatHelper shareInstance].messageVC.tabBarItem.badgeValue = nil;
        [[WG_UserDefaults shareInstance] loginOut];
//        self.cyl_tabBarController.selectedIndex = 0;
        
    }
}
@end
