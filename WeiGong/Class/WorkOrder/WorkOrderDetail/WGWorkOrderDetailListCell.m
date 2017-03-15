//
//  WGWorkOrderDetailListCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/24.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGWorkOrderDetailListCell.h"
#import "WGWorkOrderDetail.h"
#import "WGBaseLabel.h"

@interface WGWorkOrderDetailListCell ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) WGBaseLabel *labtime;
@property (nonatomic, strong) WGBaseLabel *labaddress;
@property (nonatomic, strong) WGBaseLabel *labunit;
@property (nonatomic, strong) WGBaseLabel *labprice;
@end
@implementation WGWorkOrderDetailListCell
- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = kClearColor;
    self.contentView.backgroundColor = kClearColor;
    
    
    [self insertSubview:self.backView belowSubview:self.contentView];
    
    [self.contentView addSubview:self.labtime];
    [self.contentView addSubview:self.labaddress];
    [self.contentView addSubview:self.labunit];
    [self.contentView addSubview:self.labprice];
    
    CGFloat left = 12;
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, left, 0, left));
    }];
    
    CGFloat nameX = 24, nameY = 15;
    
    [self.labtime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameX);
        make.right.mas_equalTo(-nameX);
        make.top.mas_equalTo(nameY);
    }];
    
    [self.labaddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.labtime);
//        make.right.mas_equalTo(-nameX);
        make.top.mas_equalTo(self.labtime.mas_bottom);
    }];
    
    [self.labunit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labtime);
        make.top.mas_equalTo(self.labaddress.mas_bottom);
        make.bottom.mas_equalTo(-nameY);
    }];
    
    [self.labprice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-nameX);
        make.top.mas_equalTo(self.labunit);
    }];
    
}
- (void)setItem:(WGWorkOrderDetailListItem *)item {
    _item = item;
    if (_item) {
        NSString *timeStr = [NSString stringWithFormat:@"%@%@", @"时间：", _item.workDateV];
        self.labtime.text = timeStr;
        self.labaddress.text = kStringAppend(@"地点：", _item.address);
        NSString *unitStr = [NSString stringWithFormat:@"%@", _item.hoursV];
        self.labunit.text = unitStr;
        
        NSString *priceStr = [NSString stringWithFormat:@"%@", _item.salaryDayV];
        self.labprice.text = priceStr;
    }
}

#pragma mark - getter && setter 
- (UIView *)backView {
    if (!_backView) {
        _backView = [UIView new];
        _backView.backgroundColor = kWhiteColor;
    }
    return _backView;
}
- (WGBaseLabel *)labtime {
    if (!_labtime) {
        WGBaseLabel *label = [WGBaseLabel wg_labelWithFont:kFont(14) textColor:kColor_Black_Sub];
        label.insets = UIEdgeInsetsMake(2, 0, 2, 0);
        _labtime = label;
    }
    return _labtime;
}
- (WGBaseLabel *)labaddress {
    if (!_labaddress) {
        WGBaseLabel *label = [WGBaseLabel wg_labelWithFont:kFont(14) textColor:kColor_Black_Sub];
        label.insets = UIEdgeInsetsMake(2, 0, 2, 0);
        _labaddress = label;
    }
    return _labaddress;
}
- (WGBaseLabel *)labunit {
    if (!_labunit) {
        WGBaseLabel *label = [WGBaseLabel wg_labelWithFont:kFont(14) textColor:kColor_Black_Sub];
        label.insets = UIEdgeInsetsMake(2, 0, 2, 0);
        _labunit = label;
    }
    return _labunit;
}
- (WGBaseLabel *)labprice {
    if (!_labprice) {
        WGBaseLabel *label = [WGBaseLabel wg_labelWithFont:kFont(14) textColor:kColor_Black_Sub];
        label.insets = UIEdgeInsetsMake(2, 0, 2, 0);
        label.textColor = kColor_OrangeRed;
        _labprice = label;
    }
    return _labprice;
}

@end
