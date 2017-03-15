//
//  WG_BaseViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/12.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_BaseViewController.h"
#import <UINavigationController+FDFullscreenPopGesture.h>
#import <objc/runtime.h>
#import "WGRequestManager.h"


@interface WG_BaseViewController ()
@end

@implementation WG_BaseViewController
- (void)setHiddenStatusBar:(BOOL)hiddenStatusBar {
    _hiddenStatusBar = hiddenStatusBar;
    [self setNeedsStatusBarAppearanceUpdate];
}
- (BOOL)prefersStatusBarHidden {
    return self.hiddenStatusBar;
}
- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    if (_statusBarStyle == statusBarStyle) return;
    _statusBarStyle = statusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.statusBarStyle;
}
- (instancetype)init {
    if (self = [super init]) {
        self.fd_prefersNavigationBarHidden = YES;
        if (self.fd_prefersNavigationBarHidden) {            
            // 监听标题的改变
            [self.navigationItem addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
        }
    }
    return self;
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [WGRequestManager cancelTaskWithUrl:self.requestUrl];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self wg_setNavBar];

    [self wg_loadData];
}
#pragma mark - NavigationController
- (void)wg_pushVC:(UIViewController *)viewController {
    if (![viewController isKindOfClass:[UIViewController class]]) return;
    if (!self.navigationController) return;
    if (viewController.hidesBottomBarWhenPushed == NO) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [self.navigationController pushViewController:viewController animated:YES];
}
- (void)wg_pop {
    if (!self.navigationController) return;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)wg_popToVC:(UIViewController *)viewController {
    if (![viewController isKindOfClass:[UIViewController class]]) return;
    if (!self.navigationController) return;
    [self.navigationController popToViewController:viewController animated:YES];
}
- (void)wg_popToRootVC {
    if (!self.navigationController) return;
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark - ModelViewController
- (void)wg_presentVC:(UIViewController *)viewController {
    [self wg_presentVC:viewController completion:nil];
}
- (void)wg_presentVC:(UIViewController *)viewController completion:(void(^)(void))completion {
    if (![viewController isKindOfClass:[UIViewController class]]) return;
    [self presentViewController:viewController animated:YES completion:completion];
}
- (void)wg_dismiss {
    [self wg_dismissWithCompletion:nil];
}
- (void)wg_dismissWithCompletion:(void (^)(void))completion {
    [self dismissViewControllerAnimated:YES completion:completion];
}
#pragma mark - ChildViewController
- (void)wg_addChildVC:(UIViewController *)chileVC {
    if (![chileVC isKindOfClass:[UIViewController class]]) return;
    [chileVC willMoveToParentViewController:self];
    [self addChildViewController:chileVC];
    [self.view addSubview:chileVC.view];
    chileVC.view.frame = self.view.frame;
    
}
- (void)wg_removeChildVC:(UIViewController *)chileVC {
    if (![chileVC isKindOfClass:[UIViewController class]]) return;
    [chileVC.view removeFromSuperview];
    [chileVC willMoveToParentViewController:self];
    [chileVC removeFromParentViewController];
}

#pragma mark - CheckNetwork
- (BOOL)isNetworkReachable {
    // 网络是否可用
    return YES;
}
- (void)wg_loadData {
    
}
- (NSString *)requestUrl {
    return @"";
}


@end


static char kNavBarKey, kNavBackButtonKey, kNavTitleKey, kNavbarLineKey;
@implementation WG_BaseViewController (NavBar)

- (void)wg_setNavBar {
    
    [self.view addSubview:[self navBar]];
    
    //    NSInteger count = self.navigationController.viewControllers.count;
    //    DMLog(@"viewControllers:%@", self.navigationController.viewControllers);
    //    [self backButton].hidden = count <= 1;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSInteger count = self.navigationController.viewControllers.count;
    [self backButton].hidden = count <= 1;
    //    DMLog(@"will_viewControllers:%@", self.navigationController.viewControllers);
}

- (UIColor *)navbarBackgroundColor {
    return kColor_Navbar;
}
- (UIColor *)navbarTitleColor {
    return kBlackColor;
}
- (UIColor *)navbarLineColor {
    return [UIColor wg_colorWithHexString:@"#cccccc"];
    return kColor_NavLine;
}
- (BOOL)navbarLineHidden {
    return NO;
}
- (void)updateNavBar {
    [self navBar].backgroundColor = [self navbarBackgroundColor];
    [self navbarLine].backgroundColor = [self navbarLineColor];
    [self navbarLine].hidden = [self navbarLineHidden];
    [self labTitle].textColor = [self navbarTitleColor];
}
#pragma mark - 自定义视图
- (UIView *)navBar {
    UIView *navBar = objc_getAssociatedObject(self, &kNavBarKey);
    if (navBar == nil) {
        navBar = [UIView new];
        
        navBar.backgroundColor = [self navbarBackgroundColor];
        navBar.frame = CGRectMake(0, 0, kScreenWidth, kTopBarHeight);
        [navBar addSubview:[self backButton]];
        [navBar addSubview:[self labTitle]];
        [navBar addSubview:[self navbarLine]];
        objc_setAssociatedObject(self, &kNavBarKey, navBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return navBar;
}
- (UIButton *)backButton {
    UIButton *backButton = objc_getAssociatedObject(self, &kNavBackButtonKey);
    if (backButton == nil) {
        backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //        backButton.backgroundColor = kRedColor;
        backButton.frame = CGRectMake(10, kStatusBarHeight , 50, kTopBarHeight-kStatusBarHeight);
        // btn_back_normal btn_back_selected
        UIImage *image_nor = [UIImage imageNamed:@"btn_back_normal"];
        UIImage *image_hig = image_nor;
        [backButton setImage:image_nor forState:UIControlStateNormal];
        [backButton setImage:image_hig forState:UIControlStateHighlighted];
        float offset = -13;
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, offset, 0, -offset);
        [backButton addTarget:self action:@selector(dm_backAction) forControlEvents:UIControlEventTouchUpInside];
        objc_setAssociatedObject(self, &kNavBackButtonKey, backButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return backButton;
}
- (UILabel *)labTitle {
    UILabel *labTitle = objc_getAssociatedObject(self, &kNavTitleKey);
    if (labTitle == nil) {
        labTitle = [UILabel new];
        labTitle.font = kFont(17);
        labTitle.textColor = [self navbarTitleColor];
        labTitle.textAlignment = NSTextAlignmentCenter;
        float labX = CGRectGetMaxX([self backButton].frame);
        labTitle.frame = CGRectMake(labX, kStatusBarHeight, kScreenWidth-labX*2, kTopBarHeight-kStatusBarHeight);
        objc_setAssociatedObject(self, &kNavTitleKey, labTitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return labTitle;
}
- (UIView *)navbarLine {
    UIView *navbarLine = objc_getAssociatedObject(self, &kNavbarLineKey);
    if (navbarLine == nil) {
        navbarLine = [UILabel new];
        CGFloat lineH = 1.0/[UIScreen mainScreen].scale;
        navbarLine.frame = CGRectMake(0, kTopBarHeight-lineH, kScreenWidth, lineH);
        navbarLine.backgroundColor = [self navbarLineColor];
        navbarLine.hidden = [self navbarLineHidden];
        objc_setAssociatedObject(self, &kNavbarLineKey, navbarLine, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return navbarLine;
}

- (void)dm_backAction {
    [self wg_pop];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"title"]) {
        NSString *title = change[NSKeyValueChangeNewKey];
        [self labTitle].text = title;
    }
}

- (void)dealloc {
    
    if (self.fd_prefersNavigationBarHidden) {
        [self.navigationItem removeObserver:self forKeyPath:@"title"];
    }
    DMLog(@"dealloc:[%@]", NSStringFromClass(self.class));
    [WGRequestManager cancelTaskWithUrl:self.requestUrl];
}

@end
