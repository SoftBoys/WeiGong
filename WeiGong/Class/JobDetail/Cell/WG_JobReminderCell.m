//
//  WG_ JobReminderCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/8.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_JobReminderCell.h"

@interface WG_JobReminderCell ()
@property (nonatomic, strong) UILabel *labtitle;
@property (nonatomic, strong) UILabel *labcontent;
@property (nonatomic, strong) UILabel *labmobile;
@end
@implementation WG_JobReminderCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.labtitle];
    [self.contentView  addSubview:self.labcontent];
    [self.contentView  addSubview:self.labmobile];
    
    float spaceY = 5;
    [self.labtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(spaceY);
    }];
    [self.labcontent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labtitle.mas_left);
        make.top.mas_equalTo(self.labtitle.mas_bottom).offset(2);
        
        make.right.mas_lessThanOrEqualTo(self.contentView.mas_right).offset(-10);
//        make.bottom.mas_equalTo(self.contentView).offset(-spaceY);
    }];
    [self.labmobile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labcontent);
        make.top.mas_equalTo(self.labcontent.mas_bottom).offset(1);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-spaceY);
    }];
    
}

- (UILabel *)labtitle {
    if (!_labtitle) {
        _labtitle = [UILabel wg_labelWithFont:kFont_15 textColor:kColor_Black ];
        _labtitle.text = @"微工提示";
    }
    return _labtitle;
}
- (UILabel *)labcontent {
    if (!_labcontent) {
        _labcontent = [UILabel wg_labelWithFont:kFont_15 textColor:kColor_Black_Sub ];
        _labcontent.numberOfLines = 0;
        _labcontent.text = @"平台所有商家不会向用户收取任何费用，如果商家向您收费请勿缴费，并向我们举报。";
    }
    return _labcontent;
}
- (UILabel *)labmobile {
    if (!_labmobile) {
        _labmobile = [UILabel wg_labelWithFont:kFont_15 textColor:kColor_Black_Sub ];
        _labmobile.text = @"投诉电话：400-7060-150";
    }
    return _labmobile;
}
@end
