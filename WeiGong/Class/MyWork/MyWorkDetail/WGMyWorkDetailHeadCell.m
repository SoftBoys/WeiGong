//
//  WGMyWorkDetailHeadCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/25.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGMyWorkDetailHeadCell.h"
#import "WGMyWorkDetail.h"
#import "NSAttributedString+Addition.h"

@interface WGMyWorkDetailHeadCell ()
@property (nonatomic, strong) UILabel *labname;
@property (nonatomic, strong) UILabel *labjobName;
@property (nonatomic, strong) UILabel *labcontanctName;
@property (nonatomic, strong) UILabel *labcontanctPhone;
@end
@implementation WGMyWorkDetailHeadCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.labname];
    [self.contentView addSubview:self.labjobName];
    [self.contentView addSubview:self.labcontanctName];
    [self.contentView addSubview:self.labcontanctPhone];
    
    self.labcontanctPhone.userInteractionEnabled = YES;
    [self.labcontanctPhone addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPhone)]];
    
    CGFloat nameX = 12, nameY = 15;
    [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameX);
        make.top.mas_equalTo(nameY);
    }];
    
    [self.labjobName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameX);
        make.top.mas_equalTo(self.labname.mas_bottom);
    }];
    
    [self.labcontanctName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameX);
        make.top.mas_equalTo(self.labjobName.mas_bottom);
    }];
    
    [self.labcontanctPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameX);
        make.top.mas_equalTo(self.labcontanctName.mas_bottom);
        make.bottom.mas_equalTo(-nameY);
    }];
    
}

- (void)tapPhone {
    if ([[UIDevice wg_platformString] hasPrefix:@"iPhone"]) {
        if (_workDetail.contactMobile) {
            
        }
        NSString *phone = _workDetail.contactMobile ?: _workDetail.contactPhone;
        if (phone) {
            [UIDevice wg_phoneWithNumber:_workDetail.contactMobile];
        }
    } else {
        [UIAlertController wg_alertWithTitle:@"提示" message:@"该设备不可打电话" completion:^(UIAlertController *alert, NSInteger buttonIndex) {
            
        } cancel:nil sure:@"确定"];
    }
}

- (void)setWorkDetail:(WGMyWorkDetail *)workDetail {
    _workDetail = workDetail;
    if (_workDetail) {
        NSString *name1 = @"商家：", *name2 = @"职位：", *name3 = @"联系人：", *name4 = @"联系电话：";
        NSAttributedString *attName = [NSAttributedString wg_attStringWithString:kStringAppend(name1, _workDetail.enterpriseName) keyWord:name1 font:kFont(15) highlightColor:kColor_Black_Sub textColor:kColor_Black];
        self.labname.attributedText = attName;
        
        NSAttributedString *attJobName = [NSAttributedString wg_attStringWithString:kStringAppend(name2, _workDetail.jobName) keyWord:name2 font:kFont(15) highlightColor:kColor_Black_Sub textColor:kColor_Black];
        self.labjobName.attributedText = attJobName;
        
        NSAttributedString *attcontactName = [NSAttributedString wg_attStringWithString:kStringAppend(name3, _workDetail.contactName) keyWord:name3 font:kFont(15) highlightColor:kColor_Black_Sub textColor:kColor_Black];
        self.labcontanctName.attributedText = attcontactName;
        
        NSAttributedString *attcontactPhone = [NSAttributedString wg_attStringWithString:kStringAppend(name4, _workDetail.contactMobile) keyWord:name4 font:kFont(15) highlightColor:kColor_Black_Sub textColor:kColor_OrangeRed];
        self.labcontanctPhone.attributedText = attcontactPhone;
    }
}
#pragma mark - getter && setter 
- (UILabel *)labname {
    if (!_labname) {
        _labname = [UILabel wg_labelWithFont:nil];
    }
    return _labname;
}
- (UILabel *)labjobName {
    if (!_labjobName) {
        _labjobName = [UILabel wg_labelWithFont:nil];
    }
    return _labjobName;
}
- (UILabel *)labcontanctName {
    if (!_labcontanctName) {
        _labcontanctName = [UILabel wg_labelWithFont:nil];
    }
    return _labcontanctName;
}
- (UILabel *)labcontanctPhone {
    if (!_labcontanctPhone) {
        _labcontanctPhone = [UILabel wg_labelWithFont:nil];
    }
    return _labcontanctPhone;
}

@end
