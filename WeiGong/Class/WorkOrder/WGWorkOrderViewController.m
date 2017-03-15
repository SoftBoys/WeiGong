//
//  WGWorkOrderViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/23.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGWorkOrderViewController.h"
#import "WGWorkOrderListViewController.h"

@interface WGWorkOrderViewController ()

@end

@implementation WGWorkOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"工作订单";
    self.isfullScreen = NO;
    
    [self setUpContentViewFrame:^(UIView *contentView) {
        contentView.frame = CGRectMake(0, kTopBarHeight, kScreenWidth, kScreenHeight-kTopBarHeight);
        contentView.backgroundColor = kWhiteColor;
    }];
    
//    [self setUpCoverEffect:^(UIColor *__autoreleasing *coverColor, CGFloat *coverCornerRadius) {
//        *coverColor = kWhiteColor;
//    }];
    
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight, CGFloat *titleWidth) {
        *titleScrollViewColor = kWhiteColor;
        *norColor = kColor_Black_Sub;
        *selColor = kColor_Blue;
        *titleFont = kFont(14);
        *titleHeight = 35;
        
    }];
    
    [self setUpUnderLineEffect:^(BOOL *isUnderLineDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor, BOOL *isUnderLineEqualTitleWidth) {
        *underLineH = 1;
        *underLineColor = kColor_Blue;
        *isUnderLineEqualTitleWidth = YES;
    }];
    
    UIView *titleView = [self valueForKey:@"titleScrollView"];
    if (titleView) {
        CGFloat lineY = 35 - kLineHeight;
        UIView *line = [UIView new];
        line.backgroundColor = kColor_Line;
        line.frame = CGRectMake(0,lineY , kScreenWidth, kLineHeight);
        [titleView addSubview:line];
    }
    
    WGWorkOrderListViewController *vc1 = [self childViewControllerWithTitle:@"全部"];
    vc1.orderFlag = 0;
    [self addChildViewController:vc1];
    
    WGWorkOrderListViewController *vc2 = [self childViewControllerWithTitle:@"待支付"];
    vc2.orderFlag = 1;
    [self addChildViewController:vc2];
    
    WGWorkOrderListViewController *vc3 = [self childViewControllerWithTitle:@"待确认"];
    vc3.orderFlag = 2;
    [self addChildViewController:vc3];
    
    WGWorkOrderListViewController *vc4 = [self childViewControllerWithTitle:@"已确认"];
    vc4.orderFlag = 3;
    [self addChildViewController:vc4];
    
}

- (WGWorkOrderListViewController *)childViewControllerWithTitle:(NSString *)title {
    WGWorkOrderListViewController *childVC = [WGWorkOrderListViewController new];
    childVC.navBar.hidden = YES;
    childVC.title = title;
    return childVC;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
