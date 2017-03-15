//
//  WGBasicInfoFootView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/6.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGBasicInfoFootView.h"

@interface WGBasicInfoFootView ()
@property (nonatomic, strong) UIButton *button_save;
@property (nonatomic, copy) void (^handle)();
@end
@implementation WGBasicInfoFootView

+ (instancetype)footViewWithHandle:(void (^)())handle {
    WGBasicInfoFootView *foot = [WGBasicInfoFootView new];
    foot.handle = handle;
    return foot;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.button_save];
        CGFloat left = 13;
        [self.button_save mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(left);
            make.right.mas_equalTo(-left);
            make.top.mas_equalTo(20);
            make.height.mas_equalTo(40);
        }];
    }
    return self;
}

- (UIButton *)button_save {
    if (!_button_save) {
        
        UIImage *image_nor = [[[UIImage wg_imageWithColor:kColor_Blue size:CGSizeMake(20, 20)] wg_imageWithCornerRadius:5] wg_resizedImage];
        UIImage *image_hig = [[[UIImage wg_imageWithColor:[kColor_Blue colorWithAlphaComponent:0.8] size:CGSizeMake(20, 20)] wg_imageWithCornerRadius:5] wg_resizedImage];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = kFont(16);
        [button setTitle:@"保存" forState:UIControlStateNormal];
        [button setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [button setBackgroundImage:image_nor forState:UIControlStateNormal];
        [button setBackgroundImage:image_hig forState:UIControlStateHighlighted];
        __weak typeof(self) weakself = self;
        [button setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            if (strongself.handle) {
                strongself.handle();
            }
        }];
        
        _button_save = button;
        
    }
    return _button_save;
}

@end
