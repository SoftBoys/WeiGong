//
//  UIViewController+Loading.m
//  WGKitDemo
//
//  Created by dfhb@rdd on 16/11/28.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "UIViewController+Loading.h"
#import <objc/runtime.h>
#import "WGCategory.h"


@interface UIViewControllerLoadingView : UIView
@property (nonatomic, weak) UIActivityIndicatorView *indicatorView;
@property (nonatomic, weak) UILabel *labtext;
@end
@implementation UIViewControllerLoadingView

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:indicatorView];
        _indicatorView = indicatorView;
    }
    return _indicatorView;
}
- (UILabel *)labtext {
    if (!_labtext) {
        UILabel *labtext = [[UILabel alloc] init];
        labtext.font = kFont(13);
        labtext.textColor = [UIColor wg_colorWithHexString:@"#565656"];
        labtext.text = kLoadingText;
        [labtext sizeToFit];
        [self addSubview:labtext];
        _labtext = labtext;
    }
    return _labtext;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.indicatorView.wg_width = 40;
    self.indicatorView.wg_height = 40;
    self.indicatorView.wg_top = (self.wg_height-self.indicatorView.wg_height)/2;
    self.indicatorView.wg_centerX = self.wg_centerX-20;
    
    self.labtext.wg_top = self.indicatorView.wg_top;
    self.labtext.wg_height = self.indicatorView.wg_height;
    self.labtext.wg_left = self.indicatorView.wg_right;
    
}

- (void)wg_startLoading {
    [self.indicatorView startAnimating];
}
@end

static const void *kLoadingViewKey;
@implementation UIViewController (Loading)
- (UIView *)wg_loadingView {
    return objc_getAssociatedObject(self, &kLoadingViewKey);
}
- (void)setWg_loadingView:(UIView *)wg_loadingView {
    objc_setAssociatedObject(self, &kLoadingViewKey, wg_loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)wg_showLoadingView {
    [self wg_showLoadingViewWithFrame:CGRectMake(0, 0, kScreenWidth, kNavigationBarHeight)];
}
- (void)wg_showLoadingViewWithFrame:(CGRect)frame {
    if (self.wg_loadingView == nil) {
        UIViewControllerLoadingView *loadingView = [UIViewControllerLoadingView new];
        loadingView.frame = frame;
        loadingView.center = self.view.center;
        loadingView.wg_centerY = self.view.wg_centerY - 40;
        [self.view addSubview:loadingView];
        self.wg_loadingView = loadingView;
        [loadingView wg_startLoading];
        self.wg_loadingView.userInteractionEnabled = NO;
    }
}

- (void)wg_hideLoadingView {
    [self.wg_loadingView removeFromSuperview];
    self.wg_loadingView = nil;
    self.wg_loadingView.userInteractionEnabled = YES;
}
@end
