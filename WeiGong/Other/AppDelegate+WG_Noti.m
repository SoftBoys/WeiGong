//
//  AppDelegate+WG_Noti.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/19.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "AppDelegate+WG_Noti.h"
#import "WG_LoginViewController.h"
#import "WG_BaseNavViewController.h"

#import "AppDelegate+UMeng.h"

#import <RealReachability/RealReachability.h>
#import "MBProgressHUD+WG_Extension.h"
#import "WG_RealReachability.h"
#import "WGRequestManager.h"

#import "WG_UserDefaults.h"
#import <EMSDK.h>

#import "WG_BaseTabBarController.h"
#import "WGMessageHistoryViewController.h"
#import "WG_JobDetailViewController.h"
#import "EaseSDKHelper.h"
#import "WGChatHelper.h"

@implementation AppDelegate (WG_Noti)

- (void)wg_addNoti {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wg_receiveNoti:) name:kNoti_ReceiveNoti object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wg_reachabilityStatus:) name:kRealReachabilityChangedNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wg_updateUnreadMessageCount) name:kNoti_UpdateUnreadMessageCount object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wg_loginout) name:kNoti_LoginIsOutDate object:nil];
    
    [WG_RealReachability wg_startNotifier];
    
}
- (void)wg_loginout {
    [[WG_UserDefaults shareInstance] loginOut];
}
- (void)wg_reachabilityStatus:(NSNotification *)noti {
    RealReachability *reach = noti.object;
    ReachabilityStatus status_now = [reach currentReachabilityStatus];
    ReachabilityStatus status_pre = [reach previousReachabilityStatus];
    if (status_now == RealStatusNotReachable) {
//        [MBProgressHUD wg_message:@"当前网络不可用"];
        [WGRequestManager cancelAllTask];
    }
    WGLog(@"pre:%@---now:%@", @(status_pre), @(status_now));
//    WGLog(@"Status:%@", reach.currentReachabilityString);
//    WGLog(@"Status:%@", reach.currentReachabilityFlags);
}
#pragma mark - 更新未读消息
- (void)wg_updateUnreadMessageCount {
    
    if (![WG_UserDefaults shareInstance].isLogin) {
        return;
    }
    if (self.cyl_tabBarController == nil) {
        return;
    }
    
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        if (conversation.conversationId.length) {
            unreadCount += conversation.unreadMessagesCount;
        }
    }
    
    WG_MessageViewController *messageVC = [WGChatHelper shareInstance].messageVC;
    
    if (unreadCount > 0) {
        messageVC.navigationController.tabBarItem.badgeValue = kIntToStr(unreadCount);
    } else {
        messageVC.navigationController.tabBarItem.badgeValue = nil;
    }
    
    if ([[self wg_topViewController] isKindOfClass:[WGMessageHistoryViewController class]]) {
        WGMessageHistoryViewController *topVC = (WGMessageHistoryViewController *)[self wg_topViewController];
        [topVC wg_loadData];
    }
    
//    WGLog(@"消息角标：%@  unreadCount:%@",messageVC.tabBarItem.badgeValue, @(unreadCount));
    UIApplication *application = [UIApplication sharedApplication];
    [application setApplicationIconBadgeNumber:unreadCount];
    
}

#pragma mark - 接受到远程推送
- (void)wg_receiveNoti:(NSNotification *)noti {
    WG_UserInfo *user = noti.object[kReceiveNotiKey];
    
    UIViewController *rootViewController = [self.window rootViewController];
    
    // 第一次启动
    if (![rootViewController isKindOfClass:[UITabBarController class]]) return;
    
    UIViewController *topViewController = [self wg_topViewController];
    if (user.info_id == 3) { // 首页
//        [topViewController.navigationController popToRootViewControllerAnimated:NO];
//        [(UITabBarController *)rootViewController setSelectedIndex:0];
        
        [[self cyl_tabBarController] cyl_popSelectTabBarChildViewControllerAtIndex:0];
        
    } else if (user.info_id == 5) { // 消息
//        [topViewController.navigationController popToRootViewControllerAnimated:NO];
//        [(UITabBarController *)rootViewController setSelectedIndex:3];
        [[self cyl_tabBarController] cyl_popSelectTabBarChildViewControllerAtIndex:3];
    } else if (user.info_id == 8) { // 详情页
        NSString *jobId = user.jobId;
        if (jobId) {
            WG_JobDetailViewController *jobdetailVC = [WG_JobDetailViewController new];
            jobdetailVC.jobId = jobId;
            if ([topViewController isKindOfClass:[WG_BaseViewController class]]) {
                [(WG_BaseViewController *)topViewController wg_pushVC:jobdetailVC];
            }
        }
        
    } else if (user.info_id == 9) { // 网页
        NSString *sendUrl = user.sendUrl;
        if (sendUrl) {
            WG_WebViewController *webVC = [WG_WebViewController new];
            webVC.webUrl = sendUrl;
            webVC.title = user.webTitle;
            if ([topViewController isKindOfClass:[WG_BaseViewController class]]) {
                [(WG_BaseViewController *)topViewController wg_pushVC:webVC];
            }
        }
    }
 
    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
