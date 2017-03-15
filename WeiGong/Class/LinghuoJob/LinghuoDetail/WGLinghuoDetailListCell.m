//
//  WGLinghuoDetailListCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/25.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGLinghuoDetailListCell.h"
#import "WGLinghuoDetail.h"

@interface WGLinghuoDetailListCell ()
@property (nonatomic, strong) UILabel *labname_left;
@property (nonatomic, strong) UILabel *labjobName_left;
@property (nonatomic, strong) UILabel *labname;
@property (nonatomic, strong) UILabel *labjobName;
@property (nonatomic, strong) UILabel *labdate;
@property (nonatomic, strong) UILabel *labflag;
@end

@implementation WGLinghuoDetailListCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.labname_left];
    [self.contentView addSubview:self.labjobName_left];
    [self.contentView addSubview:self.labname];
    [self.contentView addSubview:self.labjobName];
    [self.contentView addSubview:self.labdate];
    [self.contentView addSubview:self.labflag];
    
    [self makeSubviewsConstraints];
}
- (void)makeSubviewsConstraints {
    
    CGFloat nameX = 12, nameY = 15;
    
    [self.labname_left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameX);
        make.top.mas_equalTo(nameY);
        //        make.height.mas_equalTo(nameSize.height);
    }];
    
    [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labname_left.mas_right);
//        make.right.mas_equalTo(-nameX);
        make.top.mas_equalTo(self.labname_left.mas_top);
    }];
    
    [self.labjobName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labjobName_left.mas_right);
        make.top.mas_equalTo(self.labname.mas_bottom);
    }];
    
    [self.labjobName_left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameX);
        make.top.mas_equalTo(self.labjobName);
        //        make.height.mas_equalTo(nameSize.height);
    }];
    
    [self.labdate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labname_left.mas_left);
        make.top.mas_equalTo(self.labjobName.mas_bottom);
        make.bottom.mas_equalTo(-nameY);
    }];
    
    [self.labflag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-nameX);
        make.bottom.mas_equalTo(self.labdate.mas_bottom);
    }];
    
    CGSize nameSize = [self.labname_left systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    CGFloat nameMaxW = kScreenWidth - nameX*2 - nameSize.width;
    self.labname.preferredMaxLayoutWidth = nameMaxW;
    
    CGFloat jobnameW = [self.labjobName_left systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].width;
    CGFloat jobnameMaxW = kScreenWidth - nameX*2 - jobnameW;
    self.labjobName.preferredMaxLayoutWidth = jobnameMaxW;
    
}

- (void)setItem:(WGLinghuoDetailListItem *)item {
    _item = item;
    if (_item) {
        
        NSString *name = _item.enterpriseName ?: @"测试";
        NSString *jobname = _item.jobName ?: @"测试";
        
        self.labname.text = name;
        self.labjobName.text = jobname;
        
        self.labdate.text = kStringAppend(@"时间：", _item.workDate);
        self.labflag.text = kStringAppend(@"",_item.checkFlag);
        
        self.labname.hidden = _item.enterpriseName == nil;
        self.labjobName.hidden = _item.jobName == nil;
    }
}
#pragma mark - getter && setter 
- (UILabel *)labname_left {
    if (!_labname_left) {
        UILabel *label = [UILabel wg_labelWithFont:kFont(15) textColor:kColor_Black];
        label.text = @"单位：";
        _labname_left = label;
    }
    return _labname_left;
}
- (UILabel *)labname {
    if (!_labname) {
        UILabel *label = [UILabel wg_labelWithFont:self.labname_left.font textColor:self.labname_left.textColor];
        label.numberOfLines = 0;
        _labname = label;
    }
    return _labname;
}
- (UILabel *)labjobName_left {
    if (!_labjobName_left) {
        UILabel *label = [UILabel wg_labelWithFont:kFont(15) textColor:kColor_Black];
        label.text = @"岗位：";
        _labjobName_left = label;
    }
    return _labjobName_left;
}
- (UILabel *)labjobName {
    if (!_labjobName) {
        UILabel *label = [UILabel wg_labelWithFont:self.labname_left.font textColor:self.labname_left.textColor];
        label.numberOfLines = 0;
        _labjobName = label;
    }
    return _labjobName;
}

- (UILabel *)labdate {
    if (!_labdate) {
        UILabel *label = [UILabel wg_labelWithFont:self.labname_left.font textColor:self.labname_left.textColor];
//        label.text = @"单位：";
        _labdate = label;
    }
    return _labdate;
}
- (UILabel *)labflag {
    if (!_labflag) {
        UILabel *label = [UILabel wg_labelWithFont:self.labname_left.font textColor:kColor_Orange];
        _labflag = label;
    }
    return _labflag;
}

@end
