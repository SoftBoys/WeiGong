//
//  WGRewardCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/15.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGRewardCell.h"
#import "WGRewardItem.h"
#import "WGBaseButton.h"

@interface WGRewardCell ()
@property (nonatomic, strong) WGBaseButton *button;
@property (nonatomic, strong) UIImageView *scanImageView;
@end
@implementation WGRewardCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    self.button = [self getButton];
    [self.contentView addSubview:self.button];
    [self.contentView addSubview:self.scanImageView];
    
    CGFloat left = 10,top = 8;
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(left);
        make.top.mas_equalTo(top);
//        make.bottom.mas_equalTo(-top);
        make.height.mas_equalTo(28);
    }];
    
    CGFloat scanT = 8, scanH = 150, scanW = scanH;
    [self.scanImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(scanT);
//        make.bottom.mas_equalTo(-scanT);
        make.size.mas_equalTo(CGSizeMake(scanW, scanH));
    }];
}

- (WGBaseButton *)getButton {
    WGBaseButton *button = [WGBaseButton buttonWithType:UIButtonTypeCustom];
    button.userInteractionEnabled = NO;
    button.type = kDMBaseButtonTypeImageTitle;
    button.spaceX = 6;
    [button setTitleColor:kBlackColor forState:UIControlStateNormal];
    button.titleLabel.font = kFont(15);
//    button.backgroundColor = kRedColor;
    return button;
}

- (void)setItem:(WGRewardItem *)item {
    _item = item;
    if (_item) {
        
        self.arrowView.hidden = !_item.canClick;
        self.selectionStyle = !_item.canClick ? UITableViewCellSelectionStyleNone:UITableViewCellSelectionStyleDefault;
        
        [self.button setImage:_item.icon forState:UIControlStateNormal];
        [self.button setTitle:_item.title forState:UIControlStateNormal];
        
        self.scanImageView.hidden = !_item.isScan;
        self.button.hidden = !self.scanImageView.hidden;
        
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    }
}
- (void)setScanUrl:(NSString *)scanUrl {
    _scanUrl = scanUrl;
    if (_scanUrl) {
        CGFloat width = 150;
        UIImage *image = [UIImage wg_imageWithQRString:scanUrl size:CGSizeMake(width, width)];
        self.scanImageView.image = image;
    }
}
- (void)updateConstraints {
    [super updateConstraints];
    
    if (self.item.isScan) {
        [self.scanImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-8).priorityHigh();
        }];
        [self.button mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-8).priorityLow();
        }];
    } else {
        [self.scanImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-8).priorityLow();
        }];
        [self.button mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-8).priorityHigh();
        }];
    }
    
}
- (UIImageView *)scanImageView {
    if (!_scanImageView) {
        _scanImageView = [UIImageView new];
//        _scanImageView.backgroundColor = kRedColor;
    }
    return _scanImageView;
}

@end
