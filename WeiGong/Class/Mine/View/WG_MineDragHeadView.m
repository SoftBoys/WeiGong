//
//  WG_MineDragHeadView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/18.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_MineDragHeadView.h"

#import "WG_DragView.h"
#import "WG_MineUserView.h"
#import "WG_MineTranslucentView.h"

#import "WG_MineUser.h"

//UIColor *translucent = [UIColor colorWithWhite:0 alpha:0.25];
@interface WG_MineDragHeadView ()
@property (nonatomic, strong) WG_DragView *backView;
@property (nonatomic, strong) WG_MineUserView *userView;
@property (nonatomic, strong) WG_MineTranslucentView *bottomView;
@property (nonatomic, strong) UIButton *loginBtn;
@end

@implementation WG_MineDragHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backView];
        [self addSubview:self.userView];
        [self addSubview:self.bottomView];
        [self addSubview:self.loginBtn];
        
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(60);
        }];
        
        [self.userView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(self.bottomView.mas_top);
//            make.bottom.mas_equalTo(self.mas_bottom).offset(-60);
            make.top.mas_equalTo(20);
        }];
        
        float loginBtnW = 60;
        [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(loginBtnW);
            make.center.mas_equalTo(self);
        }];
        
        self.loginBtn.hidden = YES;
//        self.userView.backgroundColor = [UIColor greenColor];
    }
    return self;
}
#pragma mark - Actions
- (void)loginClick {
    if ([self.delegate respondsToSelector:@selector(tapLoginInDragView)]) {
        [self.delegate tapLoginInDragView];
    }
}
- (void)settingClick {
    if ([self.delegate respondsToSelector:@selector(tapSettingInDragView)]) {
        [self.delegate tapSettingInDragView];
    }
}
- (void)tapIcon {
    if ([self.delegate respondsToSelector:@selector(tapIconInDragView)]) {
        [self.delegate tapIconInDragView];
    }
}
- (void)wg_collction {
    if ([self.delegate respondsToSelector:@selector(tapCollectionInDragView)]) {
        [self.delegate tapCollectionInDragView];
    }
}
- (void)wg_credit {
    if ([self.delegate respondsToSelector:@selector(tapCreditInDragView)]) {
        [self.delegate tapCreditInDragView];
    }
}
- (void)wg_reject {
    if ([self.delegate respondsToSelector:@selector(tapRejectInDragView)]) {
        [self.delegate tapRejectInDragView];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backView.frame = self.bounds;
}

- (void)setUser:(WG_MineUser *)user {
    _user = user;
    
    self.loginBtn.hidden = _user != nil;
    self.userView.hidden = !self.loginBtn.hidden;
    self.bottomView.hidden = !self.loginBtn.hidden;
    
    self.userView.user = _user;
    self.bottomView.user = _user;
}

#pragma mark - getter && setter
- (WG_DragView *)backView {
    if (!_backView) {
        _backView = [WG_DragView new];
        _backView.isStretch = NO;
        _backView.backImage = [UIImage imageNamed:@"mine_back"];
    }
    return _backView;
}
- (WG_MineUserView *)userView {
    if (!_userView) {
        _userView = [WG_MineUserView new];
        [_userView.settingBtn addTarget:self action:@selector(settingClick) forControlEvents:UIControlEventTouchUpInside];
        [_userView.iconView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapIcon)]];
    }
    return _userView;
}
- (WG_MineTranslucentView *)bottomView {
    if (!_bottomView) {
        _bottomView = [WG_MineTranslucentView new];
        __weak typeof(self) weakself = self;
        [_bottomView.collectButton setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            [strongself wg_collction];
        }];
        
        [_bottomView.creditButton setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            [strongself wg_credit];
        }];
        [_bottomView.rejectButton setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            [strongself wg_reject];
        }];

    }
    return _bottomView;
}
- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setImage:[UIImage imageNamed:@"mine_placehoder"] forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}
@end


