//
//  WG_ChooseCityCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/14.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_ChooseCityCell.h"
#import "WG_CityItem.h"

@interface WG_ChooseCityCell ()
@property (nonatomic, strong) UILabel *labname;
@end
@implementation WG_ChooseCityCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    [self.contentView addSubview:self.labname];
    [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.centerY.mas_equalTo(self.contentView.centerY);
    }];
}
#pragma mark - getter && setter
- (UILabel *)labname {
    if (!_labname) {
        _labname = [UILabel new];
        _labname.textColor = kColor_Black;
        _labname.font = kFont_16;
    }
    return _labname;
}

- (void)setItem:(WG_CityItem *)item {
    _item = item;
    if (_item) {
        self.labname.text = _item.city;
    }
}
@end
