//
//  WGSignUpLocationView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/26.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGSignUpLocationView.h"

@interface WGSignUpLocationView ()
@property (nonatomic, strong) UILabel *labname;
@property (nonatomic, strong) UIButton *button_location;
@end
@implementation WGSignUpLocationView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kWhiteColor;
        
        UIView *line = [UIView new];
        line.backgroundColor = kColor_Line;
        [self addSubview:line];
        [self addSubview:self.labname];
        [self addSubview:self.button_location];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(kLineHeight);
        }];
        
        [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.centerY.mas_equalTo(0);
        }];
        
        [self.button_location mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-12);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
    }
    return self;
}
- (void)setAddress:(NSString *)address {
    _address = address;
    self.labname.text = _address;
}
- (UILabel *)labname {
    if (!_labname) {
        _labname = [UILabel wg_labelWithFont:kFont(13) textColor:kColor_Black];
    }
    return _labname;
}
- (UIButton *)button_location {
    if (!_button_location) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.backgroundColor = kRedColor;
        [button setImage:[UIImage imageNamed:@"signup_location"] forState:UIControlStateNormal];
        _button_location = button;
    }
    return _button_location;
}

@end
