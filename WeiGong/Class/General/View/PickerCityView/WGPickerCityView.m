//
//  WGPickerCityView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/10.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGPickerCityView.h"
#import "WGPickerCityContentView.h"

@interface WGPickerCityView ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) WGPickerCityContentView *contentView;
@property (nonatomic, copy) WGPickerCityHandle handle;
@end
@implementation WGPickerCityView

+ (instancetype)pickerWithCityItems:(NSArray<WGPickerCityItem *> *)items currentCityItem:(WGPickerCityItem *)currentCityItem completionHandle:(WGPickerCityHandle)handle {
    UIView *window = [[UIApplication sharedApplication] keyWindow];
    WGPickerCityView *picker = [[WGPickerCityView alloc] initWithFrame:window.bounds];
    picker.contentView.currentCityItem = currentCityItem;
    picker.contentView.cityItems = items;
    picker.handle = handle;
    [window addSubview:picker];
    return picker;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.backView];
        self.backView.frame = self.bounds;
        
        self.contentView = [WGPickerCityContentView new];
        self.contentView.backgroundColor = kWhiteColor;
        __weak typeof(self) weakself = self;
        self.contentView.sureHandle = ^(WGPickerCityItem *item) {
            __strong typeof(weakself) strongself = weakself;
            [strongself dismissWithItem:item];
        };
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

- (void)dismissWithItem:(WGPickerCityItem *)item {
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.transform = CGAffineTransformIdentity;
        self.backView.backgroundColor = kClearColor;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (self.handle) {
            self.handle(item);
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
- (void)tapClick {
    [self dismissWithItem:nil];
}

- (void)dealloc {
    WGLog(@"CityView is dealloc ... ");
}
@end

@implementation WGPickerCityItem
+ (NSDictionary *)wg_dictWithModelReplacedKey {
    return @{@"cityCode":@"id",
             @"city":@"name",
             @"subItems":@"item"};
}
+ (NSDictionary *)wg_dictWithModelClassInArray {
    return @{@"subItems":[WGPickerCityItem class]};
}

@end
