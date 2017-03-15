//
//  WGMyWorkArrangeListCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/24.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGMyWorkArrangeListCell.h"
#import "WGMyWorkApplyListItem.h"

#import "WGBaseNoHightButton.h"
@interface WGMyWorkArrangeListCell ()
@property (nonatomic, strong) UILabel *labname;
@property (nonatomic, strong) UILabel *labdate;
@property (nonatomic, strong) WGBaseNoHightButton *button_phone; // 招聘
@end
@implementation WGMyWorkArrangeListCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    
    [self.contentView addSubview:self.labname];
    [self.contentView addSubview:self.labdate];
    
    self.button_phone = [self buttonWithTitle:nil];
    [self.contentView addSubview:self.button_phone];
    
    
    CGFloat nameX = 10, nameY = 10;
    [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameX);
        make.right.mas_equalTo(-nameX);
        make.top.mas_equalTo(nameY);
    }];
    
    
    [self.labdate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labname.mas_left).offset(0);
        make.top.mas_equalTo(self.labname.mas_bottom).offset(8);
        make.bottom.mas_equalTo(-nameY);
    }];
    
    [self.button_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.arrowView.mas_left).offset(-10);
        make.centerY.mas_equalTo(self.labdate);
    }];
}

- (WGBaseNoHightButton *)buttonWithTitle:(NSString *)title {
    WGBaseNoHightButton *button = [WGBaseNoHightButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = kFont(12);
    button.insets = UIEdgeInsetsMake(3, 5, 3, 5);
    [button setTitleColor:kColor_OrangeRed forState:UIControlStateNormal];
    //    button.backgroundColor = kColor_Black_Sub;
    UIImage *backImage = [[[UIImage wg_imageWithColor:kWhiteColor size:CGSizeMake(15, 14)] wg_imageWithCornerRadius:4 borderWidth:kLineHeight*2 borderColor:kColor_OrangeRed] wg_resizedImage];
    [button setBackgroundImage:backImage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(phoneClick) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
- (void)phoneClick {
    if ([[UIDevice wg_platformString] hasPrefix:@"iPhone"]) {
        [UIDevice wg_phoneWithNumber:_item.contactMobile];
    } else {
        [UIAlertController wg_alertWithTitle:@"提示" message:@"该设备不可打电话" completion:^(UIAlertController *alert, NSInteger buttonIndex) {
            
        } cancel:nil sure:@"确定"];
    }
}
- (void)setItem:(WGMyWorkArrangeListItem *)item {
    _item = item;
    if (_item) {
        self.labname.text = _item.jobName;
        
        NSString *workDate = [[NSDate wg_dateWithDateString:_item.workDate dateFormat:@"yyyyMMdd"] wg_stringWithDateFormat:@"yyyy-MM-dd"];
        NSString *dateText = [NSString stringWithFormat:@"%@ %@-%@",workDate , _item.startTime, _item.stopTime];
        self.labdate.text = dateText;
        
        [self.button_phone setTitle:_item.contactName forState:UIControlStateNormal];
    }
}

#pragma mark - getter && setter
- (UILabel *)labname {
    if (!_labname) {
        _labname = [UILabel wg_labelWithFont:kFont(15) textColor:kColor_Black];
    }
    return _labname;
}
- (UILabel *)labdate {
    if (!_labdate) {
        _labdate = [UILabel wg_labelWithFont:kFont(12) textColor:kColor_Black_Sub];
    }
    return _labdate;
}

@end
