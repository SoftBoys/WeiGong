//
//  WGAuthIdentifyFootView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/19.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGAuthIdentifyFootView.h"
#import "WGAuthIdentify.h"

@interface WGAuthIdentifyFootView ()
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, strong) UILabel *labcontent;
@end
@implementation WGAuthIdentifyFootView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = kRedColor;
        [self addSubview:self.submitBtn];
        [self addSubview:self.labcontent];
        
        CGFloat left = 15, top = 20;
        [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(top);
            make.left.mas_equalTo(left);
            make.right.mas_equalTo(-left);
        }];
        
        CGFloat contentX = 15;
        [self.labcontent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.submitBtn.mas_bottom).offset(20);
            make.left.mas_equalTo(contentX);
            make.right.mas_equalTo(-contentX);
        }];
        self.labcontent.preferredMaxLayoutWidth = kScreenWidth-contentX*2;
    }
    return self;
}
- (void)setIdentify:(WGAuthIdentify *)identify {
    _identify = identify;
    if (_identify) {
        
        self.labcontent.text = _identify.content;
        
        BOOL canPost = (_identify.checkFlag == 0||_identify.checkFlag == 3);
//        canPost = YES;
        self.submitBtn.hidden = !canPost;
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    } else {
        self.submitBtn.hidden = YES;
    }
}
- (void)updateConstraints {
    [super updateConstraints];
//    BOOL canPost = (self.identify.checkFlag == 0||self.identify.checkFlag == 3);
    CGFloat left = 15;
    [self.submitBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (self.submitBtn.hidden) {
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(0);
        } else {
            make.top.mas_equalTo(20);
            make.height.mas_equalTo(40);
        }
        
        make.left.mas_equalTo(left);
        make.right.mas_equalTo(-left);
    }];
}
#pragma mark - getter && setter
- (UIButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image_nor = [[UIImage wg_imageWithColor:kColor_Blue size:CGSizeMake(20, 20)] wg_imageWithCornerRadius:4];
        UIImage *image_hi = [[UIImage wg_imageWithColor:[kColor_Blue colorWithAlphaComponent:0.8] size:CGSizeMake(20, 20)] wg_imageWithCornerRadius:4];
        [_submitBtn setBackgroundImage:[image_nor wg_resizedImage] forState:UIControlStateNormal];
         [_submitBtn setBackgroundImage:[image_hi wg_resizedImage] forState:UIControlStateHighlighted];
        _submitBtn.titleLabel.font = kFont(16);
        [_submitBtn setTitle:@"提交认证" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        __weak typeof(self) weakself = self;
        [_submitBtn setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            if (strongself.tapHandle) {
                strongself.tapHandle();
            }
        }];
    }
    return _submitBtn;
}
- (UILabel *)labcontent {
    if (!_labcontent) {
        _labcontent = [UILabel wg_labelWithFont:kFont(14) textColor:kColor_Black_Sub];
        _labcontent.numberOfLines = 0;
    }
    return _labcontent;
}
@end
