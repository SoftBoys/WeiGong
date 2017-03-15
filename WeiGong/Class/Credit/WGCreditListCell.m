//
//  WGCreditListCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/25.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGCreditListCell.h"
#import "WGCreditListItem.h"
#import "WGCreditStarView.h"


@interface WGCreditListCell ()
@property (nonatomic, strong) UILabel *labname;
@property (nonatomic, strong) UILabel *labstate;  // 好评
@property (nonatomic, strong) UILabel *labdate;  // 日期
@property (nonatomic, strong) UILabel *labevaluate; // 评价
@property (nonatomic, strong) UILabel *labevaluateContent; // 评价内容
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) WGCreditStarView *starView1;
@property (nonatomic, strong) WGCreditStarView *starView2;
@property (nonatomic, strong) WGCreditStarView *starView3;
@end
@implementation WGCreditListCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.labname];
    [self.contentView addSubview:self.line1];
    [self.contentView addSubview:self.starView1];
    [self.contentView addSubview:self.starView2];
    [self.contentView addSubview:self.starView3];
    [self.contentView addSubview:self.labstate];
    [self.contentView addSubview:self.labdate];
    [self.contentView addSubview:self.line2];
    [self.contentView addSubview:self.labevaluate];
    [self.contentView addSubview:self.labevaluateContent];
    
    [self makeSubviewConstraints];
    
}
- (void)makeSubviewConstraints {
    CGFloat nameX = 12, nameY = 16;
    [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameX);
        make.right.mas_equalTo(-nameX);
        make.top.mas_equalTo(nameY);
    }];
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.labname);
        make.top.mas_equalTo(self.labname.mas_bottom).offset(4);
        make.height.mas_equalTo(kLineHeight);
    }];
    [self.starView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labname);
        make.top.mas_equalTo(self.line1.mas_bottom).offset(2);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(30);
    }];
    [self.starView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.mas_equalTo(self.starView1);
        make.top.mas_equalTo(self.starView1.mas_bottom).offset(0);
    }];
    [self.starView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.mas_equalTo(self.starView1);
        make.top.mas_equalTo(self.starView2.mas_bottom).offset(0);
    }];
    
    
    [self.labdate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.line1);
        make.centerY.mas_equalTo(self.starView3);
    }];
    
    [self.labstate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.labdate);
//        make.width.mas_equalTo(120);
        make.centerY.mas_equalTo(self.starView2);
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(self.line1);
        make.top.mas_equalTo(self.starView3.mas_bottom).offset(2);
    }];
    
    [self.labevaluate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labname);
        make.top.mas_equalTo(self.line2.mas_bottom).offset(4);
    }];
    
    [self.labevaluateContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labevaluate.mas_right);
//        make.right.mas_equalTo(self.labname);
        make.top.mas_equalTo(self.labevaluate);
        make.bottom.mas_equalTo(-12);
    }];
    
    self.labname.preferredMaxLayoutWidth = kScreenWidth-nameX*2;
    CGFloat evaW = [self.labevaluate systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].width;
    self.labevaluateContent.preferredMaxLayoutWidth = kScreenWidth-nameX*2-evaW;
}

- (void)setItem:(WGCreditListItem *)item {
    _item = item;
    if (_item) {
//        _item.jobName = @"我的信誉我的信誉我的信誉我的信誉我的信誉我的信誉我的信誉我的信誉我的信誉";
        self.labname.text = _item.jobName;
        
        UIImage *icon1 = [UIImage imageNamed:@"credit_jineng"];
        UIImage *icon2 = [UIImage imageNamed:@"credit_jieguo"];
        UIImage *icon3 = [UIImage imageNamed:@"credit_taidu"];
        self.starView1.icon = icon1;
        self.starView1.title = @"技能";
        self.starView2.icon = icon2;
        self.starView2.title = @"结果";
        self.starView3.icon = icon3;
        self.starView3.title = @"态度";
        
        self.starView1.star = _item.evalTarget1;
        self.starView2.star = _item.evalTarget2;
        self.starView3.star = _item.evalTarget3;
        
        self.labdate.text = _item.createDate;
        NSString *stateText = nil;
        if (_item.evalSum == 3) {
            stateText = @"好评";
        } else if (_item.evalSum == 2) {
            stateText = @"中评";
        } else if (_item.evalSum == 1) {
            stateText = @"差评";
        }
        self.labstate.text = stateText;
        
//        _item.evalDesc = @"";
        
//        _item.evalDesc = @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试";
        NSString *content = _item.evalDesc.length == 0 ? @"测试":_item.evalDesc;
        self.labevaluateContent.hidden = _item.evalDesc.length == 0;
        self.labevaluateContent.text = content;
        
    }
}

#pragma mark - getter && setter  
- (UILabel *)labname {
    if (!_labname) {
        _labname = [UILabel wg_labelWithFont:kFont(16) textColor:kColor_Black];
        _labname.numberOfLines = 0;
    }
    return _labname;
}
- (UIView *)line1 {
    if (!_line1) {
        _line1 = [UIView new];
        _line1.backgroundColor = kColor_Line;
    }
    return _line1;
}
- (UIView *)line2 {
    if (!_line2) {
        _line2 = [UIView new];
        _line2.backgroundColor = self.line1.backgroundColor;
    }
    return _line2;
}
- (WGCreditStarView *)starView1 {
    if (!_starView1) {
        _starView1 = [WGCreditStarView new];
    }
    return _starView1;
}
- (WGCreditStarView *)starView2 {
    if (!_starView2) {
        _starView2 = [WGCreditStarView new];
    }
    return _starView2;
}
- (WGCreditStarView *)starView3 {
    if (!_starView3) {
        _starView3 = [WGCreditStarView new];
    }
    return _starView3;
}
- (UILabel *)labstate {
    if (!_labstate) {
        _labstate = [UILabel wg_labelWithFont:kFont(24) textColor:kColor_Orange];
        _labstate.textAlignment = NSTextAlignmentCenter;
    }
    return _labstate;
}
- (UILabel *)labdate {
    if (!_labdate) {
        _labdate = [UILabel wg_labelWithFont:kFont(12) textColor:kColor_Black_Sub];
    }
    return _labdate;
}
- (UILabel *)labevaluate {
    if (!_labevaluate) {
        _labevaluate = [UILabel wg_labelWithFont:kFont(13) textColor:kColor_Black];
        _labevaluate.text = @"评价：";
    }
    return _labevaluate;
}
- (UILabel *)labevaluateContent {
    if (!_labevaluateContent) {
        _labevaluateContent = [UILabel wg_labelWithFont:self.labevaluate.font textColor:kColor_Black];
        _labevaluateContent.numberOfLines = 0;
//        _labevaluateContent.backgroundColor = kRedColor;
    }
    return _labevaluateContent;
}
@end
