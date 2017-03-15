//
//  DMLoginTool.m
//  DMPartTime
//
//  Created by dfhb@rdd on 17/2/13.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGLoginTool.h"

#import "WG_LoginViewController.h"
#import "WG_BaseNavViewController.h"
#import "NSObject+Addition.h"
#import "WG_UserDefaults.h"

@implementation WGLoginTool

+ (void)loginWithCompleteHandle:(void (^)(WGBaseResponse *))handle {
    /** 判断是否为登录状态 */
    if ([[WG_UserDefaults shareInstance] isLogin]) return;
    WG_LoginViewController *loginVC = [WG_LoginViewController new];
    loginVC.loginSuccessHandle = handle;
    WG_BaseViewController *topVC = (WG_BaseViewController *)[self wg_topViewController];
    
    WG_BaseNavViewController *nav = [[WG_BaseNavViewController alloc] initWithRootViewController:loginVC];
    [topVC wg_presentVC:nav];
}

@end
