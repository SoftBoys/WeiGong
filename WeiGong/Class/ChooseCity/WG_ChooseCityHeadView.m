//
//  WG_ChooseCityHeadView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/14.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_ChooseCityHeadView.h"

@interface WG_ChooseCityHeadView ()
@property (nonatomic, strong) UILabel *labname;
@property (nonatomic, strong) UILabel *labcontent;
@end
@implementation WG_ChooseCityHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.labname];
        [self addSubview:self.labcontent];
        
        [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.centerY.mas_equalTo(self.centerY);
        }];
        [self.labcontent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.labname.right).offset(2);
            make.centerY.mas_equalTo(self.labname);
        }];
    }
    return self;
}

- (void)setCurrentCity:(NSString *)currentCity {
    _currentCity = currentCity;
    if (_currentCity) {
        self.labcontent.text = _currentCity;
    }
}

#pragma mark - getter && setter
- (UILabel *)labname {
    if (!_labname) {
        _labname = [UILabel new];
        _labname.textColor = kColor_Gray_Sub;
        _labname.font = kFont_15;
        _labname.text = @"当前城市:";
    }
    return _labname;
}
- (UILabel *)labcontent {
    if (!_labcontent) {
        _labcontent = [UILabel new];
        _labcontent.textColor = kColor_Black;
        _labcontent.font = kFont_15;
    }
    return _labcontent;
}
@end
