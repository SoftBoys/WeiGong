//
//  WG_RootTool.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/12.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_RootTool.h"

#import "WG_UserDefaults.h"
#import "GuideViewController.h"
#import "WG_BaseTabBarController.h"
#import <IQKeyboardManager.h>
#import "WGChatHelper.h"

@implementation WG_RootTool

+ (void)setRootController {
    
    /** 设置键盘的相关属性 */
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    [keyboardManager setShouldToolbarUsesTextFieldTintColor:YES];
    [keyboardManager setShouldShowTextFieldPlaceholder:NO];
    keyboardManager.toolbarDoneBarButtonItemText = @"完成";
    
    UIWindow *window = [self window];
    WG_UserDefaults *user = [WG_UserDefaults shareInstance];
    if (user.isFirstOpen) {
        NSArray *images = @[[UIImage imageNamed:@"guide_1"], [UIImage imageNamed:@"guide_2"], [UIImage imageNamed:@"guide_3"]];
        GuideViewController *guideVC = [GuideViewController guideViewWithImages:images complete:^{
            user.isFirstOpen = NO;
            [WG_RootTool setRootController];
        }];
        window.rootViewController = guideVC;
    } else {
        WG_BaseTabBarController *tab = [WG_BaseTabBarController wg_new];
        window.rootViewController = tab;
        
        [WGChatHelper shareInstance].mainVC = tab;
        [WGChatHelper shareInstance].messageVC = [[[tab.viewControllers wg_objectAtIndex:3] viewControllers] firstObject];
        
    }
    
}
+ (UIWindow *)window {
    return [UIApplication sharedApplication].keyWindow;
}

+ (UIViewController *)rootController {
    return [self window].rootViewController;
}
@end
