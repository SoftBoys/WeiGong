//
//  WG_BaseNavViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/12.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_BaseNavViewController.h"

@interface WG_BaseNavViewController () <UIGestureRecognizerDelegate>

@end

@implementation WG_BaseNavViewController

+ (void)initialize {
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    /** 设置为不透明 */
    navBar.translucent = NO;
    /** 设置背景色 */
    navBar.barTintColor = [UIColor colorWithRed:0.86f green:0.85f blue:0.80f alpha:1.00f];
    navBar.barTintColor = kColor_Navbar;
    
    /** 去除导航分割线 */
    [navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [navBar setShadowImage:[UIImage new]];
    [navBar setShadowImage:[UIImage wg_imageWithColor:[UIColor wg_colorWithHexString:@"#cccccc"] size:CGSizeMake(kScreenWidth, kLineHeight)]];
    
    /** 标题字体大小和颜色 */
    
    NSDictionary *colors = @{NSForegroundColorAttributeName : kBlackColor,
                             NSFontAttributeName : kFont(17)};
    
    navBar.titleTextAttributes = colors;
    
//    /** 设置左右ButtonItem整体字体颜色和大小 */
//    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
//    /** 系统自带Item(image)颜色 */
//    barButtonItem.tintColor = [UIColor redColor];
//    
//    /** 系统自带Item标题字体大小和颜色 */
//    NSDictionary *itemColors = @{NSForegroundColorAttributeName : kMagentaColor,
//                                 NSFontAttributeName : kFont(16.0f)};
//    [barButtonItem setTitleTextAttributes:itemColors forState:UIControlStateNormal];
//    /** 设置系统自带Item标题的偏移量 */
//    [barButtonItem setTitlePositionAdjustment:UIOffsetMake(0, 0) forBarMetrics:UIBarMetricsDefault];
    
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.interactivePopGestureRecognizer.delegate = self;
    }
    return self;
}
#pragma mark - UIGestureRecognizerDelegate
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    if (self.viewControllers.count <= 1) {
//        return NO;
//    } else {
//        return YES;
//    }
//}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self.topViewController.view endEditing:YES];
    
    viewController.hidesBottomBarWhenPushed = self.viewControllers.count > 0;
    [super pushViewController:viewController animated:animated];
}
- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    [self.topViewController.view endEditing:YES];
    return [super popViewControllerAnimated:animated];
}


/** 当调用 setNeedsStatusBarAppearanceUpdate 方法的时候 默认会调用 UINavigationController 的 preferredStatusBarStyle 方法 */
/** 重写该方法的目的是在 ViewController 中可以调用 preferredStatusBarStyle */
- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}
- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.topViewController;
}
@end
