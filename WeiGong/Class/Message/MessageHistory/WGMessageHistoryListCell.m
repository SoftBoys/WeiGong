//
//  WGMessageHistoryListCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/27.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGMessageHistoryListCell.h"
#import "WGBaseNoHightButton.h"

@interface WGMessageHistoryListCell ()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *labname;
@property (nonatomic, strong) UILabel *labdetail;
@property (nonatomic, strong) UILabel *labtime;
@property (nonatomic, strong) WGBaseNoHightButton *button_count;

@end
@implementation WGMessageHistoryListCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.labname];
    [self.contentView addSubview:self.labdetail];
    [self.contentView addSubview:self.labtime];
    [self.contentView addSubview:self.button_count];
    
    CGFloat iconX = 8, iconY = 8;
    CGFloat iconW = 40, iconH = iconW;
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconX);
        
        make.width.mas_equalTo(iconW);
        make.height.mas_equalTo(iconH);
        make.top.mas_equalTo(iconY);
        make.bottom.mas_equalTo(-iconY);
    }];
    
    [self.labtime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iconX);
        make.right.mas_equalTo(-iconX);
        
    }];
    
    [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconView.mas_right).offset(iconX);
        make.right.mas_equalTo(self.labtime.mas_left).offset(-2);
        make.top.mas_equalTo(iconX);
        
    }];
    
    [self.labdetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labname);
        make.bottom.mas_equalTo(self.iconView);
        make.right.mas_equalTo(self.button_count.mas_left).offset(-2);
    }];
    
    CGFloat countW = 18, countH = 18;
    [self.button_count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(countW);
        make.height.mas_equalTo(countH);
        make.right.mas_equalTo(-iconX);
        make.bottom.mas_equalTo(self.iconView);
    }];
    
    UIImage *image = [[UIImage wg_imageWithColor:kColor(251, 0, 10) size:CGSizeMake(countW, countH)] wg_circleImage];
    [self.button_count setBackgroundImage:image forState:UIControlStateNormal];
    
}

- (void)setItem:(WGMessageHistoryListItem *)item {
    _item = item;
    if (_item) {
        
//        _item.name = @"标题标题标题标题标题标题标题标题标题标题标题标题标题";
//        _item.time = @"昨天15:10";
//        _item.detail = @"测试副标题测试副标题测试副标题测试副标题测试副标题";
//        _item.unreadCount = 0;
        
        self.labname.text = _item.name;
        
        UIImage *image = _item.isGroup ? [UIImage imageNamed:@"message_consult"]:[UIImage imageNamed:@"message_service"];
        self.iconView.image = image;
        self.labdetail.text = _item.detail;
        self.labtime.text = _item.time;
        NSString *count = kIntToStr(_item.unreadCount);
        [self.button_count setTitle:count forState:UIControlStateNormal];
        
        self.button_count.hidden = !_item.unreadCount;
        UIFont *countFont = kFont(13);
        if (_item.unreadCount < 9) {
            countFont = kFont(13);
        } else if (_item.unreadCount < 99) {
            countFont = kFont(11.5);
        } else {
            countFont = kFont(9.5);
        }
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
        _labname = [UILabel wg_labelWithFont:kFont(15) textColor:kColor_Black];
    }
    return _labname;
}
- (UILabel *)labdetail {
    if (!_labdetail) {
        _labdetail = [UILabel wg_labelWithFont:kFont(14) textColor:kColor_Black_Sub];
    }
    return _labdetail;
}
- (UILabel *)labtime {
    if (!_labtime) {
        _labtime = [UILabel wg_labelWithFont:kFont(14) textColor:kColor_Orange];
    }
    return _labtime;
}
- (WGBaseNoHightButton *)button_count {
    if (!_button_count) {
        _button_count = [WGBaseNoHightButton buttonWithType:UIButtonTypeCustom];
        _button_count.userInteractionEnabled = NO;
        _button_count.titleLabel.font = kFont(13);
    }
    return _button_count;
}

@end

@implementation WGMessageHistoryListItem


@end
