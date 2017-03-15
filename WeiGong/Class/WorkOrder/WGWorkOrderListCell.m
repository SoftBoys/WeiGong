//
//  WGWorkOrderListCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/23.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGWorkOrderListCell.h"
#import "WGBaseNoHightButton.h"


@interface WGWorkOrderListCell ()
@property (nonatomic, strong) UILabel *labname;
@property (nonatomic, strong) UILabel *labprice;
@property (nonatomic, strong) WGBaseNoHightButton *button_order;
@property (nonatomic, strong) UILabel *labdate;
@end
@implementation WGWorkOrderListCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    [self.contentView addSubview:self.labname];
    [self.contentView addSubview:self.labprice];
    [self.contentView addSubview:self.button_order];
    [self.contentView addSubview:self.labdate];
    [self makeSubviewConstraints];
}
- (void)makeSubviewConstraints {
    CGFloat nameX = 15, nameY = 12;;
    [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameX);
        make.top.mas_equalTo(nameY);
    }];
    
    [self.labprice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labname);
        make.top.mas_equalTo(self.labname.mas_bottom).offset(nameY);
        make.bottom.mas_equalTo(-nameY);
        
    }];
    CGFloat buttonH = 22;
    [self.button_order mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-nameX);
        make.centerY.mas_equalTo(self.labname);
//        make.width.mas_equalTo(buttonW);
//        make.height.mas_equalTo(buttonH);
    }];
    UIImage *image_nor = [[[UIImage wg_imageWithColor:kWhiteColor size:CGSizeMake(20, buttonH)] wg_imageWithCornerRadius:buttonH/2 borderWidth:kLineHeight*2 borderColor:kColor_OrangeRed] wg_resizedImage];
    [self.button_order setBackgroundImage:image_nor forState:UIControlStateNormal];
    
    self.button_order.insets = UIEdgeInsetsMake(0, 11, 0, 11);
    
    [self.labdate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.button_order);
        make.centerY.mas_equalTo(self.labprice);
        
    }];
}
- (void)setItem:(WGWorkOrderListItem *)item {
    _item = item;
    if (_item) {
        self.labname.text = _item.jobName;
        self.labprice.text = kStringAppend(_item.realMoney, @"元");
        self.labdate.text = _item.createDate;
//        _item.orderFlagName = @"待支付";
        [self.button_order setTitle:_item.orderFlagName forState:UIControlStateNormal];
        
        self.button_order.hidden = _item.orderFlagName.length == 0;
//        self.button_order.hidden = _item.orderFlag == 0;
    }
}
#pragma mark - getter && setter 
- (UILabel *)labname {
    if (!_labname) {
        _labname = [UILabel wg_labelWithFont:kFont(15) textColor:kColor_Black];
    }
    return _labname;
}
- (UILabel *)labprice {
    if (!_labprice) {
        _labprice = [UILabel wg_labelWithFont:kFont(15) textColor:kColor_OrangeRed];
    }
    return _labprice;
}
- (UILabel *)labdate {
    if (!_labdate) {
        _labdate = [UILabel wg_labelWithFont:kFont(11) textColor:kColor_Black_Sub];
    }
    return _labdate;
}
- (WGBaseNoHightButton *)button_order {
    if (!_button_order) {
        _button_order = [WGBaseNoHightButton buttonWithType:UIButtonTypeCustom];
        [_button_order setTitleColor:kColor_OrangeRed forState:UIControlStateNormal];
        _button_order.titleLabel.font = kFont(13);
        _button_order.userInteractionEnabled = NO;
//        _button_order.backgroundColor = kGreenColor;
    }
    return _button_order;
}

@end

@implementation WGWorkOrderListItem



@end
