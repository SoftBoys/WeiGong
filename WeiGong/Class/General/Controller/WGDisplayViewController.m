//
//  WGDisplayViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/24.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGDisplayViewController.h"

@interface WGDisplayViewController ()

@end

@implementation WGDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.title = @"工作订单";
    self.isfullScreen = NO;
    
    [self setUpContentViewFrame:^(UIView *contentView) {
        contentView.frame = CGRectMake(0, kTopBarHeight, kScreenWidth, kScreenHeight-kTopBarHeight);
        contentView.backgroundColor = kWhiteColor;
    }];
    
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
    
    for (NSInteger i = 0; i < self.wg_childViewController.count; i++) {
        WG_BaseViewController *vc = self.wg_childViewController[i];
        vc.navBar.hidden = YES;
        [self addChildViewController:vc];
    }
    
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
