//
//  WGCheckBoxView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/10.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGCheckBoxView.h"
#import "WGCheckBoxContentView.h"

@interface WGCheckBoxView ()
@property (nonatomic, copy) WGCheckBoxHandle handle;
@property (nonatomic, copy) NSArray <WGCheckBoxItem*>*boxItems;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) WGCheckBoxContentView *contentView;
@end
@implementation WGCheckBoxView

+ (instancetype)boxViewWithTitle:(NSString *)title boxItems:(NSArray<WGCheckBoxItem *> *)boxItems completionHandle:(WGCheckBoxHandle)handle {
    UIView *window = [[UIApplication sharedApplication] keyWindow];
    WGCheckBoxView *boxView = [[WGCheckBoxView alloc] initWithFrame:window.bounds];
    boxView.contentView.title = title;
    boxView.contentView.boxItems = boxItems;
    boxView.handle = handle;
    [window addSubview:boxView];
    return boxView;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.backView];
        self.backView.frame = self.bounds;
        
        [self addSubview:self.contentView];
        CGFloat contentH = 200;
        self.contentView.frame = CGRectMake(0, self.wg_bottom, self.wg_width, contentH);
    }
    return self;
}
- (void)didMoveToSuperview {
    
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = [kBlackColor colorWithAlphaComponent:0.7];
        self.contentView.transform = CGAffineTransformMakeTranslation(0, -self.contentView.wg_height);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismissWithBoxItems:(NSArray <WGCheckBoxItem *> *)boxItems {
    
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.transform = CGAffineTransformIdentity;
        self.backView.backgroundColor = kClearColor;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (self.handle) {
            self.handle(boxItems);
        }
    }];
}


#pragma mark - getter && setter
- (UIView *)backView {
    if (!_backView) {
        _backView = [UIView new];
        _backView.backgroundColor = kClearColor;
        [_backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)]];
    }
    return _backView;
}
- (WGCheckBoxContentView *)contentView {
    if (!_contentView) {
        __weak typeof(self) weakself = self;
        WGCheckBoxContentView *contentView = [WGCheckBoxContentView new];
        contentView.backgroundColor = kWhiteColor;
        contentView.sureHandle = ^(NSArray <WGCheckBoxItem *>* boxItems) {
            __strong typeof(weakself) strongself = weakself;
            [strongself dismissWithBoxItems:boxItems];
        };
        _contentView = contentView;
    }
    return _contentView;
}
- (void)tapClick {
    [self dismissWithBoxItems:nil];
}

- (void)dealloc {
    WGLog(@"check is dealloc");
}
@end

@implementation WGCheckBoxItem


@end
