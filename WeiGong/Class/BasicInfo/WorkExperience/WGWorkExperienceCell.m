//
//  WGWorkExperienceCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/20.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGWorkExperienceCell.h"
#import "WGBaseButton.h"
#import "WGWorkExperienceItem.h"

@interface WGWorkExperienceCell ()
@property (nonatomic, strong) WGBaseButton *button;
@end
@implementation WGWorkExperienceCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.button];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
}
- (void)setItem:(WGWorkExperienceItem *)item {
    _item = item;
    if (_item) {
        self.button.selected = _item.validate == 1;
        [self.button setTitle:_item.name forState:UIControlStateNormal];
    }
}

#pragma mark - getter && setter 
- (WGBaseButton *)button {
    if (!_button) {
        _button = [WGBaseButton buttonWithType:UIButtonTypeCustom];
        _button.userInteractionEnabled = NO;
        _button.type = kDMBaseButtonTypeImageTitle;
        _button.spaceX = 5;
//        _button.backgroundColor = kRedColor;
        _button.titleLabel.font = kFont(15);
        [_button setTitleColor:kColor_Black forState:UIControlStateNormal];
        [_button setImage:[UIImage imageNamed:@"mine_experience_nor"] forState:UIControlStateNormal];
        [_button setImage:[UIImage imageNamed:@"mine_experience_sel"] forState:UIControlStateSelected];
    }
    return _button;
}

@end
