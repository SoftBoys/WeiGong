//
//  WG_MywalletCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/4.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_MywalletCell.h"
#import "WG_MywalletAccountItem.h"

@interface WG_MywalletCell ()
@property (nonatomic, strong) UILabel *labname;
@property (nonatomic, strong) UILabel *labdate;
@property (nonatomic, strong) UILabel *labmoney;
@end
@implementation WG_MywalletCell
- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.labname];
    [self.contentView addSubview:self.labdate];
    [self.contentView addSubview:self.labmoney];
    
    [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(5);
    }];
    
    [self.labdate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labname.mas_left);
        make.top.mas_equalTo(self.labname.mas_bottom).offset(0);
        make.bottom.mas_equalTo(self.contentView).offset(-5);
    }];
    
    [self.labmoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(-12);
        make.top.bottom.mas_equalTo(self.labdate);
    }];
}

- (void)setItem:(WG_MywalletAccountItem *)item {
    _item = item;
    
    self.labname.text = _item.accountName;
    self.labdate.text = _item.accountDateStr;
    
    if (_item.accountMoney < 0) {
        self.labmoney.textColor = kColor_Orange;
        self.labmoney.text = [NSString stringWithFormat:@"%@", @(_item.accountMoney)];
    } else {
        self.labmoney.textColor = kColor(7, 160, 53);
        self.labmoney.text = [NSString stringWithFormat:@"+%@", @(_item.accountMoney)];
    }
}
#pragma mark - getter && setter
- (UILabel *)labname {
    if (!_labname) {
        _labname = [UILabel wg_labelWithFont:kFont_15 textColor:kColor_Black ];
        _labname.numberOfLines = 0;
    }
    return _labname;
}
- (UILabel *)labdate {
    if (!_labdate) {
        _labdate = [UILabel wg_labelWithFont:kFont_13 textColor:kColor_Black_Sub ];
    }
    return _labdate;
}
- (UILabel *)labmoney {
    if (!_labmoney) {
        _labmoney = [UILabel wg_labelWithFont:kFont_15 textColor:kColor_Orange ];
    }
    return _labmoney;
}
@end
