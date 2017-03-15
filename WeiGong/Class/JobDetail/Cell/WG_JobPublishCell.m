//
//  WG_JobPublishCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/8.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_JobPublishCell.h"
#import "WG_JobDetail.h"

@interface WG_JobPublishCell ()
@property (nonatomic, strong) UILabel *labtitle;
@property (nonatomic, strong) UILabel *labcontent;
@end
@implementation WG_JobPublishCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.labtitle];
    [self.contentView  addSubview:self.labcontent];
    
    float spaceY = 8;
    [self.labtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(spaceY);
    }];
    [self.labcontent mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.labtitle.mas_right).offset(8);
        make.left.mas_equalTo(80);
        make.top.mas_equalTo(self.labtitle.mas_top);
        
        make.right.mas_lessThanOrEqualTo(self.contentView.mas_right).offset(-10);
//        make.height.mas_greaterThanOrEqualTo(40);
        make.bottom.mas_equalTo(self.contentView).offset(-spaceY);
    }];
    
}

- (void)setDetail:(WG_JobDetail *)detail {
    _detail = detail;
    if (_detail) {
        
//        _detail.enterpriseName = @"慧博个人慧博个人慧博个人慧博个人慧博个人慧博个人慧博个人慧博个人慧博个人慧博个人慧博个人慧博个人慧博个人慧博个人";
        self.labcontent.text = _detail.enterpriseName;
    }
}
- (UILabel *)labtitle {
    if (!_labtitle) {
        _labtitle = [UILabel wg_labelWithFont:kFont_15 textColor:kColor_Black ];
        _labtitle.text = @"发布商家";
    }
    return _labtitle;
}
- (UILabel *)labcontent {
    if (!_labcontent) {
        _labcontent = [UILabel wg_labelWithFont:kFont_15 textColor:kColor_Black_Sub ];
        _labcontent.numberOfLines = 0;
    }
    return _labcontent;
}
@end
