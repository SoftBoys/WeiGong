//
//  WGCreditStarView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/25.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGCreditStarView.h"
#import "WG_IconButton.h"
#import "WGBaseNoHightButton.h"

@interface WGCreditStarView ()
@property (nonatomic, strong) WG_IconButton *button_Icon;

@property (nonatomic, strong) NSMutableArray *starButtons;
@end
@implementation WGCreditStarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.button_Icon];
        
        [self.button_Icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
        }];
        
        self.starButtons = @[].mutableCopy;
        NSInteger count = 5;
        
        CGFloat starSpace = 1.5;
        UIView *lastView = nil;
        for (NSInteger i = 0; i < count; i++) {
            WGBaseNoHightButton *button = [self starButtonWithImage:nil];
            [self addSubview:button];
            [self.starButtons wg_addObject:button];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(0);
                if (lastView) {
                    make.left.mas_equalTo(lastView.mas_right).offset(starSpace);
                } else {
                    make.left.mas_equalTo(self.button_Icon.mas_right).offset(8);
                }
                
            }];
            lastView = button;
        }
    }
    return self;
}
- (WGBaseNoHightButton *)starButtonWithImage:(UIImage *)image {
    WGBaseNoHightButton *button = [WGBaseNoHightButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"credit_star_nor"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"credit_star_sel"] forState:UIControlStateSelected];
    return button;
}
- (void)setIcon:(UIImage *)icon {
    _icon = icon;
    if (_icon) {
        [self.button_Icon setImage:_icon forState:UIControlStateNormal];
    }
}
- (void)setTitle:(NSString *)title {
    _title = title;
    if (_title) {
        [self.button_Icon setTitle:_title forState:UIControlStateNormal];
    }
}

- (void)setStar:(NSInteger)star {
    _star = star;
    NSInteger count = self.starButtons.count;
    if (_star > count) {
        _star = count;
    } else if (_star < 0) {
        _star = 0;
    }
    
    for (NSInteger i = 0; i < count; i++) {
        WGBaseNoHightButton *button = self.starButtons[i];
        button.selected = NO;
        if (i < _star) {
            button.selected = YES;
        }
    }
    
}

#pragma mark - getter && setter
- (WG_IconButton *)button_Icon {
    if (!_button_Icon) {
        _button_Icon = [WG_IconButton buttonWithType:UIButtonTypeCustom];
        _button_Icon.userInteractionEnabled = NO;
        _button_Icon.titleLabel.font = kFont(14);
        _button_Icon.space = 3;
    }
    return _button_Icon;
}
@end
