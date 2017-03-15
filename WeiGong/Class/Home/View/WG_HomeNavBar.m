//
//  WG_HomeNavBar.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/14.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WG_HomeNavBar.h"
#import "WGBaseButton.h"

@interface WG_HomeNavBar ()
@property (nonatomic, strong) WGBaseButton *cityButton;
@end
@implementation WG_HomeNavBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.cityButton];
        
        [self.cityButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.bottom.mas_equalTo(0);
        }];
    }
    return self;
}
- (void)setType:(WGHomeCityType)type {
    if (_type == type) return;
    _type = type;
    UIImage *image = nil;
    UIColor *titleColor = nil;
    if (_type == WGHomeCityTypeWhite) {
        image = [UIImage imageNamed:@"ico_downlin_white"];
        titleColor = kWhiteColor;
    } else if (_type == WGHomeCityTypeLightGray) {
        image = [UIImage imageNamed:@"ico_downlin_normal"];
        titleColor = kGrayColor;
        titleColor = [UIColor wg_red:64 green:64 blue:64];
    }
    
    [self.cityButton setImage:image forState:UIControlStateNormal];
    [self.cityButton setTitleColor:titleColor forState:UIControlStateNormal];
}
- (void)setCity:(NSString *)city {
    _city = city;
    if (_city) {
        [self.cityButton setTitle:_city forState:UIControlStateNormal];
    }
}
#pragma mark - getter && setter 
- (WGBaseButton *)cityButton {
    if (!_cityButton) {
        UIImage *image = [UIImage imageNamed:@"ico_downlin_white"];
        _cityButton = [WGBaseButton wg_buttonWithImage:image hightImage:nil backImage:nil touchBlock:^(UIButton *button) {
            
            if ([self.delegate respondsToSelector:@selector(didClickCityButton)]) {
                [self.delegate didClickCityButton];
            }
        }];
        [_cityButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _cityButton.spaceX = 5;
        _cityButton.type = kDMBaseButtonTypeTitleImage;
        _cityButton.titleLabel.font = kFont(16);
    }
    return _cityButton;
}
@end
