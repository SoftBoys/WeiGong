//
//  WG_BaseViewController.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/12.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WG_BaseViewController : UIViewController
/** 隐藏StatusBar */
@property (nonatomic, assign, getter=isHiddenStatusBar) BOOL hiddenStatusBar;
/** StatusBar风格 (不起作用的话在 UINavigationController 中重写 childViewControllerForStatusBarStyle 方法) */
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;
@end

#pragma mark - 导航栏的跳转
@interface WG_BaseViewController (NavigationController)
- (void)wg_pushVC:(UIViewController *)viewController;
- (void)wg_pop;
- (void)wg_popToVC:(UIViewController *)viewController;
- (void)wg_popToRootVC;
@end

#pragma mark - Mode形式
@interface WG_BaseViewController (ModelViewController)
- (void)wg_presentVC:(UIViewController *)viewController;
- (void)wg_presentVC:(UIViewController *)viewController completion:(void(^)(void))completion;
- (void)wg_dismiss;
- (void)wg_dismissWithCompletion:(void(^)(void))completion;
@end
@interface WG_BaseViewController (ChildViewController)
- (void)wg_addChildVC:(UIViewController *)viewController;
- (void)wg_removeChildVC:(UIViewController *)viewController;
@end

#pragma mark - 网络的检测与数据的加载
@interface WG_BaseViewController (CheckNetwork)
/** 检测网络是否可用 */
@property (nonatomic, assign, readonly) BOOL isNetworkReachable;
/** 请求数据（交给子类去实现） */
- (void)wg_loadData;
/** 请求的Url */
@property (nonatomic, copy, readonly) NSString *requestUrl;
@end

@interface WG_BaseViewController (NavBar)
/** 自定义导航栏 */
- (void)wg_setNavBar;
/** 自定义navBar */
@property (nonatomic, strong, readonly) UIView *navBar;
@property (nonatomic, strong, readonly) UIButton *backButton;
/** 设置导航栏背景色 (子类中重新) */
- (UIColor *)navbarBackgroundColor;
/** 设置导航栏标题颜色 (子类中重新) */
- (UIColor *)navbarTitleColor;
/** 设置导航栏线条的颜色 (子类中重新) */
- (UIColor *)navbarLineColor;
/** 设置导航栏线条的隐藏 */
- (BOOL)navbarLineHidden;
/** 更新 navBar */
- (void)updateNavBar;

@end
