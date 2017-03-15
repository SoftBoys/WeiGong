//
//  WG_BaseTabBarController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/12.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_BaseTabBarController.h"
#import "WG_BaseNavViewController.h"
#import "WG_HomeViewController.h"
#import "WG_NearViewController.h"
#import "WG_MessageViewController.h"
#import "WG_TimeViewController.h"
#import "WG_MineViewController.h"
#import "WGTrainViewController.h"

#import "WG_UserDefaults.h"
#import "WGLoginTool.h"

@interface WG_BaseTabBarController () <UITabBarControllerDelegate>

@end
@implementation WG_BaseTabBarController

+ (instancetype)wg_new {
    NSMutableArray *viewControllers = @[].mutableCopy;
    [viewControllers addObject:[self navControllerWithClass:[WG_HomeViewController class]]];
    [viewControllers addObject:[self navControllerWithClass:[WG_NearViewController class]]];
    [viewControllers addObject:[self navControllerWithClass:[WGTrainViewController class]]];
    [viewControllers addObject:[self navControllerWithClass:[WG_MessageViewController class]]];
    [viewControllers addObject:[self navControllerWithClass:[WG_MineViewController class]]];
    
    NSMutableArray *tabBarItems = @[].mutableCopy;
    [tabBarItems addObject:@{CYLTabBarItemTitle:@"首页",
                             CYLTabBarItemImage:@"tabbar_main_nor",
                             CYLTabBarItemSelectedImage:@"tabbar_main_sel"}];
    [tabBarItems addObject:@{CYLTabBarItemTitle:@"搜附近",
                             CYLTabBarItemImage:@"tabbar_near_nor",
                             CYLTabBarItemSelectedImage:@"tabbar_near_sel"}];
    [tabBarItems addObject:@{CYLTabBarItemTitle:@"培训",
                             CYLTabBarItemImage:@"tabbar_train_nor",
                             CYLTabBarItemSelectedImage:@"tabbar_train_sel"}];
    [tabBarItems addObject:@{CYLTabBarItemTitle:@"消息",
                             CYLTabBarItemImage:@"tabbar_message_nor",
                             CYLTabBarItemSelectedImage:@"tabbar_message_sel"}];
    [tabBarItems addObject:@{CYLTabBarItemTitle:@"我的",
                             CYLTabBarItemImage:@"tabbar_mine_nor",
                             CYLTabBarItemSelectedImage:@"tabbar_mine_sel"}];
    
    
    WG_BaseTabBarController *tabbar = [[WG_BaseTabBarController alloc] init];
    
    tabbar.tabBarItemsAttributes = [tabBarItems copy];
    tabbar.titlePositionAdjustment = UIOffsetMake(0, -2.5);
    tabbar.viewControllers = [viewControllers copy];
    
    tabbar.tabBar.barTintColor = [UIColor whiteColor];
    tabbar.tabBar.tintColor = [UIColor blackColor];
    tabbar.tabBar.tintColor = kColor_Blue;
    
    tabbar.tabBar.shadowImage = [UIImage wg_imageWithColor:kColor_Line size:CGSizeMake(kScreenWidth, kLineHeight)];
    
    UIImage *image = [UIImage wg_resizedImageWithName:@"tabbar_background"];
    tabbar.tabBar.backgroundImage = image;
    
    if ([tabbar.tabBar respondsToSelector:@selector(unselectedItemTintColor)]) {
        tabbar.tabBar.unselectedItemTintColor = [UIColor blackColor];
    }
    
    return tabbar;
}
+ (UIViewController *)navControllerWithClass:(Class)class {
    UIViewController *viewConreoller = [class new];
    WG_BaseNavViewController *nav = [[WG_BaseNavViewController alloc] initWithRootViewController:viewConreoller];
    return nav;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.delegate = self;
}
#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    WG_BaseNavViewController *nav = (WG_BaseNavViewController *)viewController;
    if ([nav isKindOfClass:[UINavigationController class]]) {
        UIViewController *messageVC = [nav.viewControllers firstObject];
        if ([messageVC isKindOfClass:[WG_MessageViewController class]]) {
            if ([WG_UserDefaults shareInstance].isLogin == NO) {
                [WGLoginTool loginWithCompleteHandle:^(WGBaseResponse *response) {
                    if (response.statusCode == 200) {
                        [self cyl_popSelectTabBarChildViewControllerForClassType:[WG_MessageViewController class]];
                    }
                }];
                return NO;
            }
        }
    }
    
    return YES;
}

@end
