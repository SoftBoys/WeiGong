//
//  WGUserFeedbackFootView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/1.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGUserFeedbackFootView.h"

@implementation WGUserFeedbackFootView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
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
            if (strongself.submitHandle) {
                strongself.submitHandle();
            }
        }];
        [self addSubview:button];
        
        CGFloat left = 13;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(left);
            make.right.mas_equalTo(-left);
            make.top.mas_equalTo(20);
            make.height.mas_equalTo(40);
        }];
        
    }
    return self;
}

@end
