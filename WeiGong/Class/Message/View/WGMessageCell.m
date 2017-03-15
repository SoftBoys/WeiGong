//
//  WGMessageCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/18.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGMessageCell.h"
#import "WGMessageItem.h"

@interface WGMessageCell ()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIImageView *unreadView;
@property (nonatomic, strong) UILabel *labtitle;
@property (nonatomic, strong) UILabel *labcontent;
@property (nonatomic, strong) UILabel *labtime;
@end
@implementation WGMessageCell
- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.unreadView];
    [self.contentView addSubview:self.labtitle];
    [self.contentView addSubview:self.labcontent];
    [self.contentView addSubview:self.labtime];
    
    CGFloat left = 10, top = 10;
    CGFloat iconW = 40, iconH = iconW;
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(left);
        make.top.mas_equalTo(top);
        make.bottom.mas_equalTo(-top);
        make.width.mas_equalTo(iconW);
        make.height.mas_equalTo(iconH);
    }];
    CGFloat unreadW = 8, unreadH = unreadW;
    [self.unreadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.iconView.mas_right);
        make.centerY.mas_equalTo(self.iconView.mas_top);
        make.width.mas_equalTo(unreadW);
        make.height.mas_equalTo(unreadH);
    }];
    UIImage *image = [[UIImage wg_imageWithColor:kOrangeColor size:CGSizeMake(unreadW, unreadH)] wg_circleImage];
    self.unreadView.image = image;
    CGFloat spaceX = 8;
    [self.labtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconView);
        make.left.mas_equalTo(self.iconView.mas_right).offset(spaceX);
    }];
    
    [self.labcontent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.iconView);
        make.left.mas_equalTo(self.labtitle);
        make.right.mas_equalTo(self.labtime);
    }];
    
    [self.labtime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.labtitle);
        make.right.mas_equalTo(-12);
    }];
    
}
- (void)setItem:(WGMessageItem *)item {
    _item = item;
    if (_item) {
        if (_item.itemId == 1) {
            self.iconView.image = [UIImage imageNamed:@"message_zixun"];
        } else {
            [WGDownloadImageManager downloadImageWithUrl:_item.imageUrl completeHandle:^(BOOL finished, UIImage *image) {
                if (image) {
                    self.iconView.image = image;
                }
            }];
        }
        
        self.labtitle.text = _item.title;
        self.labcontent.text = _item.content;
        self.labtime.text = _item.time;
        if (_item.itemId == 3 && _item.workNew == 0) {
            self.unreadView.hidden = NO;
        } if (_item.itemId == 1 && _item.unreadCount > 0) {
            self.unreadView.hidden = NO;
        } else {
            self.unreadView.hidden = YES;
        }
        
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
- (UIImageView *)unreadView {
    if (!_unreadView) {
        _unreadView = [UIImageView new];
    }
    return _unreadView;
}
- (UILabel *)labtitle {
    if (!_labtitle) {
        _labtitle = [UILabel wg_labelWithFont:kFont(16) textColor:kColor_Black];
    }
    return _labtitle;
}
- (UILabel *)labcontent {
    if (!_labcontent) {
        _labcontent = [UILabel wg_labelWithFont:kFont(14) textColor:kColor_Black_Sub];
    }
    return _labcontent;
}
- (UILabel *)labtime {
    if (!_labtime) {
        _labtime = [UILabel wg_labelWithFont:kFont(14) textColor:kColor_Black_Sub];
    }
    return _labtime;
}
@end
