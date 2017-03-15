//
//  WGBasicInfoAddressCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/6.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGBasicInfoAddressCell.h"
#import "WGBaseButton.h"
#import "WG_CityItem.h"

@interface WGBasicInfoAddressCell ()
@property (nonatomic, strong) WGBaseButton *button_address;
@property (nonatomic, strong) UITextField *field;
@end

@implementation WGBasicInfoAddressCell

@synthesize cellItem = _cellItem;
- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    [self.contentView addSubview:self.button_address];
    [self.contentView addSubview:self.field];
    
    [self.button_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
//        make.width.mas_equalTo(80);
    }];
    
    [self.field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(self.arrowView.mas_right);
        make.width.mas_equalTo(kScreenWidth-100);
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fieldDidChanged:) name:UITextFieldTextDidChangeNotification object:nil];;
}
- (void)fieldDidChanged:(NSNotification *)noti {
    UITextField *field = noti.object;
    if (field.tag == self.cellItem.cellType) {
        self.cellItem.name_content = field.text;
        if (self.cellItem.cellType == 8) {
            self.cellItem.info.locationName = self.cellItem.name_content;
        }
    }
}
- (void)setCellItem:(WGBasicInfoCellItem *)cellItem {
    _cellItem = cellItem;
    if (_cellItem) {
        NSString *title = _cellItem.name_left ?: @"工作区域";
        [self.button_address setTitle:title forState:UIControlStateNormal];
        self.field.text = _cellItem.name_content;
        self.field.placeholder = _cellItem.placeholder;
        self.field.tag = _cellItem.cellType;
//        self.field.userInteractionEnabled = _cellItem.canInput;
        WG_CityItem *subcityItem =  _cellItem.subcityItem;
        if (subcityItem) {
            [self.button_address setTitle:subcityItem.city forState:UIControlStateNormal];
        }
        
    }
}
#pragma mark - getter && setter
- (WGBaseButton *)button_address {
    if (!_button_address) {
//        UILabel *label = [UILabel wg_labelWithFont:kFont(15) textColor:kColor_Black];
        WGBaseButton *button = [WGBaseButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = kFont(15);
        UIImage *image = [UIImage wg_arrowImageWithColor:kColor_Black size:CGSizeMake(12, 6.5) arrowW:kLineHeight arrowType:WGArrowImageTypeBottom];
        [button setImage:image forState:UIControlStateNormal];
        [button setTitleColor:kColor_Black forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        button.type = kDMBaseButtonTypeTitleImage;
        button.spaceX = 3;
        _button_address = button;
    }
    return _button_address;
}
- (UITextField *)field {
    if (!_field) {
        _field = [[UITextField alloc] init];
        _field.textColor = kColor_Black;
        _field.font = self.button_address.titleLabel.font;
        _field.textAlignment = NSTextAlignmentRight;
    }
    return _field;
}

- (void)buttonClick {
    if ([self.delegate respondsToSelector:@selector(modifyaddressItemWithCellItem:)]) {
        [self.delegate modifyaddressItemWithCellItem:self.cellItem];
    }
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
