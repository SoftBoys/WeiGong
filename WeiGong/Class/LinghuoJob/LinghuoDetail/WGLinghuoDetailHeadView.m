//
//  WGLinghuoDetailHeadView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/26.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGLinghuoDetailHeadView.h"
#import "WGLinghuoDetail.h"
#import "WG_IconButton.h"

@interface WGLinghuoDetailHeadView ()
@property (nonatomic, strong) WG_IconButton *alldaysButton;
@property (nonatomic, strong) WG_IconButton *allmoneyButton;
@end
@implementation WGLinghuoDetailHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kWhiteColor;
        
        UIView *line_center = [UIView new];
        line_center.backgroundColor = kColor_Line;
        [self addSubview:line_center];
        
        UIView *line_bottom = [UIView new];
        line_bottom.backgroundColor = kColor_Line;
        [self addSubview:line_bottom];
        
        [self addSubview:self.alldaysButton];
        [self addSubview:self.allmoneyButton];
        
        [line_center mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(kLineHeight);
            make.centerX.mas_equalTo(0);
        }];
        [line_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(kLineHeight);
        }];
        
        [self.alldaysButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.centerX.mas_equalTo(-kScreenWidth/4);
        }];
        
        [self.allmoneyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.centerX.mas_equalTo(kScreenWidth/4);
        }];
        
        
    }
    return self;
}

- (void)setDetail:(WGLinghuoDetail *)detail {
    _detail = detail;
    if (_detail) {
        
        NSString *days = kStringAppend(@(_detail.totalDay), @"天");
        [self.alldaysButton setTitle:days forState:UIControlStateNormal];
        
        NSString *money = kStringAppend(_detail.totalMoney, @"元");
        [self.allmoneyButton setTitle:money forState:UIControlStateNormal];
    }
}
#pragma mark - getter && setter
- (WG_IconButton *)alldaysButton {
    if (!_alldaysButton) {
        WG_IconButton *iconButton = [WG_IconButton buttonWithType:UIButtonTypeCustom];
        iconButton.userInteractionEnabled = NO;
        iconButton.titleLabel.font = kFont(15);
        iconButton.backgroundColor = kWhiteColor;
        iconButton.space = 4;
        [iconButton setTitleColor:kColor_Black forState:UIControlStateNormal];
        [iconButton setImage:[UIImage imageNamed:@"alldays"] forState:UIControlStateNormal];
        _alldaysButton = iconButton;
    }
    return _alldaysButton;
}
- (WG_IconButton *)allmoneyButton {
    if (!_allmoneyButton) {
        WG_IconButton *iconButton = [WG_IconButton buttonWithType:UIButtonTypeCustom];
        iconButton.userInteractionEnabled = NO;
        iconButton.titleLabel.font = self.alldaysButton.titleLabel.font;
        iconButton.space = 4;
        [iconButton setTitleColor:kColor_Black forState:UIControlStateNormal];
        [iconButton setImage:[UIImage imageNamed:@"allmoney"] forState:UIControlStateNormal];
        iconButton.backgroundColor = kWhiteColor;
        _allmoneyButton = iconButton;
    }
    return _allmoneyButton;
}

@end
