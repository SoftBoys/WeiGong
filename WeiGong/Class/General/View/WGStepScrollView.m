//
//  WGStepScrollView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/21.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGStepScrollView.h"

@implementation WGStepScrollView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.alwaysBounceHorizontal = NO;
        self.alwaysBounceVertical = NO;
        self.pagingEnabled = YES;
        self.scrollEnabled = NO;
    }
    return self;
}
- (void)setContentViews:(NSArray<UIView *> *)contentViews {
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    _contentViews = contentViews;
    for (NSInteger i = 0; i < _contentViews.count; i++) {
        UIView *subView = _contentViews[i];
        [self addSubview:subView];
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    NSInteger count = self.contentViews.count;
//    if (count < 1) {
//        count = 1;
//    }
    
    for (NSInteger i = 0; i < count; i++) {
        UIView *subview = self.contentViews[i];
        subview.wg_size = self.wg_size;
        subview.wg_top = 0;
        subview.wg_left = self.wg_width * i;
    }
    self.contentSize = CGSizeMake(self.wg_width*count, self.wg_height);
}
- (void)stepToPage:(NSInteger)page {
    [self stepToPage:page animated:NO];
}
- (void)stepToPage:(NSInteger)page animated:(BOOL)animated {
    [self stepToPage:page animated:animated completion:nil];
}
- (void)stepToPage:(NSInteger)page animated:(BOOL)animated completion:(void (^)())completion {
    if (self.contentViews.count == 0) return;
    if (page < self.contentViews.count && page >= 0) {
//        UIView *subview = self.contentViews[page];
        NSTimeInterval duration = 0;
        if (animated) {
            duration = 0.25;
        }
        CGPoint contentOffset = self.contentOffset;
        contentOffset.x = self.wg_width * page;
        [UIView animateWithDuration:duration animations:^{
//            subview.wg_left = self.wg_width * page;
            self.contentOffset = contentOffset;
        } completion:^(BOOL finished) {
            if (completion) {
                completion();
            }
        }];
    } else {
        WGLog(@"跳转页面越界");
    }
    
}

@end
