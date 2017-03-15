//
//  WG_SettingLoginoutView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/21.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_SettingLoginoutView.h"



@interface WG_SettingLoginoutView ()
@property (nonatomic, strong) UIButton *loginoutBtn;
@property (nonatomic, copy) void (^tap)();
@end
@implementation WG_SettingLoginoutView
+ (instancetype)loginoutViewWithTap:(void (^)())tap {
    WG_SettingLoginoutView *login = [WG_SettingLoginoutView new];
    login.tap = tap;
    return login;
}
- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.loginoutBtn];
        
        float left = 40;
        float buttonH = 40;
        [self.loginoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(left);
            make.right.mas_equalTo(-left);
            make.top.mas_equalTo(20);
            make.height.mas_equalTo(buttonH);
        }];
        
        float buttonW = kScreenWidth - left*2;
        UIImage *image = [[UIImage wg_imageWithColor:kColor_Blue size:CGSizeMake(buttonW, buttonH)] wg_imageWithCornerRadius:buttonH/2];
        UIImage *imageH = [[UIImage wg_imageWithColor:[kColor_Blue colorWithAlphaComponent:0.8] size:CGSizeMake(buttonW, buttonH)] wg_imageWithCornerRadius:buttonH/2];
        [self.loginoutBtn setBackgroundImage:image forState:UIControlStateNormal];
        [self.loginoutBtn setBackgroundImage:imageH forState:UIControlStateHighlighted];
    }
    return self;
}

- (void)wg_loginout {
    if (self.tap) {
        self.tap();
    }
}
#pragma mark - getter && setter
- (UIButton *)loginoutBtn {
    if (!_loginoutBtn) {
        _loginoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginoutBtn.titleLabel.font = kFont_17;
        [_loginoutBtn setTitle:@"退出当前账号" forState:UIControlStateNormal];
        [_loginoutBtn setTitleColor:kColor_White forState:UIControlStateNormal];
        [_loginoutBtn addTarget:self action:@selector(wg_loginout) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginoutBtn;
}
@end
