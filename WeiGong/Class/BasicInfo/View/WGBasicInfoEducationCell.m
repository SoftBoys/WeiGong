//
//  WGBasicInfoEducationCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/6.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGBasicInfoEducationCell.h"
#import "WGBaseButton.h"
#import "WGDataTypeItem.h"

@interface WGBasicInfoEducationCell ()
@property (nonatomic, strong) WGBaseButton *button_height;
@property (nonatomic, strong) WGBaseButton *button_weight;
@property (nonatomic, strong) WGBaseButton *button_education;

@end
@implementation WGBasicInfoEducationCell
@synthesize cellItem = _cellItem;
- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    [self.contentView addSubview:self.button_height];
    [self.contentView addSubview:self.button_weight];
    [self.contentView addSubview:self.button_education];
    
    UIView *line1 = [UIView new];
    line1.backgroundColor = kColor_Line;
    [self.contentView addSubview:line1];
    
    UIView *line2 = [UIView new];
    line2.backgroundColor = line1.backgroundColor;
    [self.contentView addSubview:line2];
    
    
    [self.button_height mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.centerX.mas_equalTo(-kScreenWidth/3);
    }];
    
    [self.button_weight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.centerX.mas_equalTo(0);
    }];
    
    [self.button_education mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.centerX.mas_equalTo(kScreenWidth/3);
    }];
    
    CGFloat lineY = 5;
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenWidth/3);
        make.top.mas_equalTo(lineY);
        make.bottom.mas_equalTo(-lineY);
        make.width.mas_equalTo(kLineHeight);
    }];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(2*kScreenWidth/3);
        make.top.bottom.width.mas_equalTo(line1);
    }];
    
}
- (void)setCellItem:(WGBasicInfoCellItem *)cellItem {
    _cellItem = cellItem;
    if (_cellItem) {
//        self.labname.text = _cellItem.name_left;
        NSString *titleH = kStringAppend(kIntToStr(_cellItem.height), @"cm");
        NSString *titleW = kStringAppend(kIntToStr(_cellItem.weight), @"kg");
        if (_cellItem.height == 0) {
            titleH = @"身高";
        }
        if (_cellItem.weight == 0) {
            titleW = @"体重";
        }
        [self.button_height setTitle:titleH forState:UIControlStateNormal];
        [self.button_weight setTitle:titleW forState:UIControlStateNormal];
        
        NSString *education = _cellItem.educationItem ? _cellItem.educationItem.name:@"学历";
        [self.button_education setTitle:education forState:UIControlStateNormal];
        
    }
}


#pragma mark - getter && setter
- (WGBaseButton *)button_height {
    if (!_button_height) {
        WGBaseButton *button = [WGBaseButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = kFont(15);
        UIImage *image = [UIImage wg_arrowImageWithColor:kColor_Black size:CGSizeMake(12, 6.5) arrowW:kLineHeight arrowType:WGArrowImageTypeBottom];
        [button setImage:image forState:UIControlStateNormal];
        [button setTitleColor:kColor_Black forState:UIControlStateNormal];
        [button setTitle:@"身高" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.type = kDMBaseButtonTypeTitleImage;
        button.spaceX = 3;
        _button_height = button;
    }
    return _button_height;
}
- (WGBaseButton *)button_weight {
    if (!_button_weight) {
        WGBaseButton *button = [WGBaseButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = kFont(15);
        UIImage *image = [UIImage wg_arrowImageWithColor:kColor_Black size:CGSizeMake(12, 6.5) arrowW:kLineHeight arrowType:WGArrowImageTypeBottom];
        [button setImage:image forState:UIControlStateNormal];
        [button setTitleColor:kColor_Black forState:UIControlStateNormal];
        [button setTitle:@"体重" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.type = kDMBaseButtonTypeTitleImage;
        button.spaceX = 3;
        _button_weight = button;
    }
    return _button_weight;
}
- (WGBaseButton *)button_education {
    if (!_button_education) {
        WGBaseButton *button = [WGBaseButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = kFont(15);
        UIImage *image = [UIImage wg_arrowImageWithColor:kColor_Black size:CGSizeMake(12, 6.5) arrowW:kLineHeight arrowType:WGArrowImageTypeBottom];
        [button setImage:image forState:UIControlStateNormal];
        [button setTitleColor:kColor_Black forState:UIControlStateNormal];
        [button setTitle:@"学历" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.type = kDMBaseButtonTypeTitleImage;
        button.spaceX = 3;
        _button_education = button;
    }
    return _button_education;
}

- (void)buttonClick:(WGBaseButton *)button {
    if (button == self.button_height) {
        if ([self.delegate respondsToSelector:@selector(modifyHeightWithCellItem:)]) {
            [self.delegate modifyHeightWithCellItem:self.cellItem];
        }
    } else if (button == self.button_weight) {
        if ([self.delegate respondsToSelector:@selector(modifyWeightWithCellItem:)]) {
            [self.delegate modifyWeightWithCellItem:self.cellItem];
        }
    } else if (button == self.button_education) {
        if ([self.delegate respondsToSelector:@selector(modifyEducationWithCellItem:)]) {
            [self.delegate modifyEducationWithCellItem:self.cellItem];
        }
    }
}
@end
