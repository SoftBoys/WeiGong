//
//  WGAccountListCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/22.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGAccountListCell.h"
#import "WGAccountListItem.h"
#import "WGBaseNoHightButton.h"

@interface WGAccountListCell ()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *labtitle;
@property (nonatomic, strong) UILabel *labname;
@property (nonatomic, strong) UILabel *labaccount;
@property (nonatomic, strong) WGBaseNoHightButton *button_box;
@end
@implementation WGAccountListCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.labtitle];
    [self.contentView addSubview:self.labname];
    [self.contentView addSubview:self.labaccount];
    [self.contentView addSubview:self.button_box];
    
    [self makeSubviews];
}
- (void)makeSubviews {
    CGFloat iconX = 12, iconY = 16;
    CGFloat iconW = 40, iconH = iconW;
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconX);
        make.top.mas_equalTo(iconY);
        make.width.mas_equalTo(iconW);
        make.height.mas_equalTo(iconH);
        make.bottom.mas_equalTo(-iconY);
    }];
    
    [self.labtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconView.mas_right).offset(7);
        make.top.mas_equalTo(self.iconView);
    }];
    
    [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labtitle);
        make.bottom.mas_equalTo(self.iconView);
    }];
    
    [self.labaccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labname.mas_right).offset(7);
        make.top.bottom.mas_equalTo(self.labname);
    }];
    
    CGFloat boxW = 44;
    [self.button_box mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        make.width.height.mas_equalTo(boxW);
    }];
}

- (void)setItem:(WGAccountListItem *)item {
    _item = item;
    if (_item) {
        self.labtitle.text = _item.accountType;
        self.labname.text = _item.accountName;
        self.labaccount.text = _item.accountId;
        self.button_box.selected = _item.accountDefault == 1;
        
        [WGDownloadImageManager downloadImageWithUrl:_item.picUrl completeHandle:^(BOOL finished, UIImage *image) {
            if (image) {
                self.iconView.image = image;
            } else {
                self.iconView.image = nil;
            }
        }];
    }
}



#pragma mark - getter && setter 
- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [UIImageView new];
//        _iconView.backgroundColor = kRedColor;
    }
    return _iconView;
}
- (UILabel *)labtitle {
    if (!_labtitle) {
        _labtitle = [UILabel wg_labelWithFont:kFont(15) textColor:kColor_Black];
    }
    return _labtitle;
}
- (UILabel *)labname {
    if (!_labname) {
        // kColor_Gray_Sub
        _labname = [UILabel wg_labelWithFont:kFont(12) textColor:kColor_Black_Sub];
    }
    return _labname;
}
- (UILabel *)labaccount {
    if (!_labaccount) {
        _labaccount = [UILabel wg_labelWithFont:self.labname.font textColor:self.labname.textColor];
    }
    return _labaccount;
}
- (WGBaseNoHightButton *)button_box {
    if (!_button_box) {
        _button_box = [WGBaseNoHightButton buttonWithType:UIButtonTypeCustom];
        _button_box.adjustsImageWhenHighlighted = NO;
        [_button_box setImage:[UIImage imageNamed:@"account_box_nor"] forState:UIControlStateNormal];
        [_button_box setImage:[UIImage imageNamed:@"account_box_sel"] forState:UIControlStateSelected];
        [_button_box addTarget:self action:@selector(clickBoxBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_box;
}

- (void)clickBoxBtn {
    if ([self.delegate respondsToSelector:@selector(tapAccountBoxWithItem:)]) {
        [self.delegate tapAccountBoxWithItem:self.item];
    }
}

@end
