//
//  WGWorkMessageListCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/18.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGWorkMessageListCell.h"
#import "WGWorkMessageListItem.h"

@interface WGWorkMessageListCell ()
@property (nonatomic, strong) UILabel *labdate;
@property (nonatomic, strong) UIView *contentBackView;
@property (nonatomic, strong) UILabel *labtitle;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *labcontent;
@property (nonatomic, strong) UIButton *buttonDetail;
@end
@implementation WGWorkMessageListCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    self.contentView.backgroundColor = kClearColor;
    self.backgroundColor = kClearColor;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.labdate];
    [self.contentView addSubview:self.contentBackView];
    [self.contentBackView addSubview:self.labtitle];
    [self.contentBackView addSubview:self.line];
    [self.contentBackView addSubview:self.labcontent];
    [self.contentBackView addSubview:self.buttonDetail];
    
    [self.labdate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(5);
    }];
    
    CGFloat leftBack = 12;
    [self.contentBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.labdate.mas_bottom).offset(5);
        make.left.mas_equalTo(leftBack);
        make.right.mas_equalTo(-leftBack);
        make.bottom.mas_equalTo(0);
    }];
    
    CGFloat titleLeft = 4, titleTop = 3;
    [self.labtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLeft);
        make.top.mas_equalTo(titleTop);
        make.right.mas_equalTo(-titleLeft);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.labtitle);
        make.top.mas_equalTo(self.labtitle.mas_bottom).offset(2);
        make.height.mas_equalTo(kLineHeight);
    }];
    
    [self.labcontent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.labtitle);
        make.top.mas_equalTo(self.line.mas_bottom).offset(2);
        
//        make.bottom.mas_equalTo(-titleTop);
    }];
    
    [self.buttonDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.labtitle);
        make.top.mas_equalTo(self.labcontent.mas_bottom).offset(0);
        make.height.mas_equalTo(25);
        
//        make.bottom.mas_equalTo(-titleTop).priorityLow();
    }];
    
    self.labtitle.preferredMaxLayoutWidth = kScreenWidth-(leftBack+titleLeft)*2;
    self.labcontent.preferredMaxLayoutWidth = self.labtitle.preferredMaxLayoutWidth;
    
}

- (void)setItem:(WGWorkMessageListItem *)item {
    _item = item;
    if (_item) {
        self.labdate.text = _item.createDate;
        self.labtitle.text = _item.msgTitle;
        self.labcontent.text = _item.msgContent;
        
        NSString *content = nil;
        if (_item.openFlag == 1) {
            content = @"查看详情>>";
        } else if (_item.openFlag == 2) {
            content = @"查看详情>>";
        } else if (_item.openFlag == 3) {
            content = @"电话联系>>";
        }
        self.buttonDetail.hidden = (_item.openFlag == 0);
        
        [self.buttonDetail setTitle:content forState:UIControlStateNormal];
        
//        WGLog(@"openFlag:%@",@(_item.openFlag));
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
        
    }
}
- (void)updateConstraints {
    
    [super updateConstraints];
    CGFloat titleTop = 3;
    
    if (self.buttonDetail.hidden) {
        [self.labcontent mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.labtitle);
            make.top.mas_equalTo(self.line.mas_bottom).offset(2);
            make.bottom.mas_equalTo(-titleTop);
        }];
        [self.buttonDetail mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.labtitle);
            make.top.mas_equalTo(self.labcontent.mas_bottom).offset(0);
            make.height.mas_equalTo(25);
            
        }];
    } else {
        [self.labcontent mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.labtitle);
            make.top.mas_equalTo(self.line.mas_bottom).offset(2);
        }];
        [self.buttonDetail mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.labtitle);
            make.top.mas_equalTo(self.labcontent.mas_bottom).offset(0);
            make.height.mas_equalTo(25);
            make.bottom.mas_equalTo(0);
        }];
    }
}
#pragma mark - getter && setter 
- (UIView *)contentBackView {
    if (!_contentBackView) {
        _contentBackView = [UIView new];
        _contentBackView.backgroundColor = kWhiteColor;
        _contentBackView.layer.borderColor = kColor_NavLine.CGColor;
        _contentBackView.layer.borderWidth = kLineHeight;
    }
    return _contentBackView;
}
- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = kColor_NavLine;
    }
    return _line;
}
- (UILabel *)labdate {
    if (!_labdate) {
        _labdate = [UILabel wg_labelWithFont:kFont(14) textColor:kColor_Black];
    }
    return _labdate;
}
- (UILabel *)labtitle {
    if (!_labtitle) {
        _labtitle = [UILabel wg_labelWithFont:kFont(16) textColor:kColor_Black];
        _labtitle.numberOfLines = 0;
    }
    return _labtitle;
}
- (UILabel *)labcontent {
    if (!_labcontent) {
        _labcontent = [UILabel wg_labelWithFont:kFont(14) textColor:kColor_Black_Sub];
        _labcontent.numberOfLines = 0;
    }
    return _labcontent;
}
- (UIButton *)buttonDetail {
    if (!_buttonDetail) {
        _buttonDetail = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_buttonDetail setTitle:@"查看详情>>" forState:UIControlStateNormal];
        [_buttonDetail setTitleColor:kColor_Blue forState:UIControlStateNormal];
        _buttonDetail.userInteractionEnabled = NO;
        _buttonDetail.titleLabel.font = kFont(14);
//        _buttonDetail.backgroundColor = kRedColor;
    }
    return _buttonDetail;
}

@end
