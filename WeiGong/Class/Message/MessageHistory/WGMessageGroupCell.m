//
//  WGMessageGroupCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/26.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGMessageGroupCell.h"

@interface WGMessageGroupCell ()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *labname;
@end
@implementation WGMessageGroupCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.labname];
    
    CGFloat iconX = 8, iconY = 8;
    CGFloat iconW = 38, iconH = iconW;
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconX);
        
        make.width.mas_equalTo(iconW);
        make.height.mas_equalTo(iconH);
        make.centerY.mas_equalTo(0);
        
        make.top.mas_equalTo(iconY);
        make.bottom.mas_equalTo(-iconY);
    }];
    
    [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconView.mas_right).offset(iconX);
        make.right.mas_offset(-iconX);
        make.top.bottom.mas_equalTo(0);
//        make.height.mas_greaterThanOrEqualTo(44);
    }];

//    self.labname.preferredMaxLayoutWidth = kScreenWidth-iconX*3-iconW;
}

- (void)setItem:(WGMessageGroupItem *)item {
    _item = item;
    if (_item) {
        
//        _item.groupname = @"测试职位测试职位测试职位测试职位测试职位测试职位测试职位测试职位测试职位测试职位测试职位测试职位测试职位测试职位测试职位测试职位测试职位测试职位测试职位";
        self.labname.text = _item.groupname;

        BOOL isGroup = item.flag == 2;
        UIImage *image = isGroup ? [UIImage imageNamed:@"message_consult"]:[UIImage imageNamed:@"message_service"];
        self.iconView.image = image;
    }
}

#pragma mark - getter && setter 
- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [UIImageView new];
    }
    return _iconView;
}
- (UILabel *)labname {
    if (!_labname) {
        _labname = [UILabel wg_labelWithFont:kFont(16) textColor:kColor_Black];
//        _labname.numberOfLines = 0;
//        _labname.backgroundColor = kRedColor;
    }
    return _labname;
}

@end

@implementation WGMessageGroupItem


@end
