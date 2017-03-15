//
//  WG_LoginBackView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/20.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_LoginBackView.h"

#import "WG_HomeCityButton.h"

@interface WG_LoginBackView ()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIView *fieldBackView;
@property (nonatomic, strong) UITextField *phoneField;
@property (nonatomic, strong) UIView *spaceLine;

@property (nonatomic, strong) UITextField *passField;

@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UIButton *forgetButton;

@property (nonatomic, strong) UIButton *renduoduoView;

@property (nonatomic, copy) NSString *phoneNewText;
@end
@implementation WG_LoginBackView

- (instancetype)init {
    if (self = [super init]) {
        
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageNamed:@"login_backimage"];
        
        [self addSubview:self.iconView];
        [self addSubview:self.fieldBackView];
        [self.fieldBackView addSubview:self.phoneField];
        [self.fieldBackView addSubview:self.spaceLine];
        [self.fieldBackView addSubview:self.passField];
        [self addSubview:self.loginButton];
        
        
        [self addSubview:self.registerButton];
        [self addSubview:self.forgetButton];
        [self addSubview:self.renduoduoView];
        
        [self makeSubConstraints];
        
        
    }
    return self;
}
- (void)makeSubConstraints {
    float iconW = 80;
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(iconW);
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(100);
    }];
    UIImage *image = [[UIImage imageNamed:@"icon_login"] wg_resizedImageWithNewSize:CGSizeMake(80, 80)];
    self.iconView.image = image;
    
    CGFloat leftBack = 35;
    [self.fieldBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconView.mas_bottom).offset(25);
        make.left.mas_equalTo(leftBack);
        make.right.mas_equalTo(-leftBack);
//        make
    }];
    
    float phoneH = 40;
    float phoneleftViewW = 50;
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.fieldBackView);
//        make.centerX.mas_equalTo(self);
//        make.top.mas_equalTo(self.iconView.mas_bottom).offset(30);
        make.height.mas_equalTo(phoneH);
    }];
    
    [self.spaceLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.phoneField);
        make.top.mas_equalTo(self.phoneField.mas_bottom);
        make.height.mas_equalTo(kLineHeight);
    }];
    
    [self.passField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(self.phoneField);
        make.top.mas_equalTo(self.spaceLine.mas_bottom);
        make.bottom.mas_equalTo(self.fieldBackView.mas_bottom).offset(0);
    }];
    
    
    
    float loginleft = 40;
    float loginH = 40;
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.fieldBackView.mas_bottom).offset(20);
        make.left.right.mas_equalTo(self.fieldBackView);
//        make.left.mas_equalTo(loginleft);
//        make.right.mas_equalTo(-loginleft);
        make.height.mas_equalTo(loginH);
        
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.loginButton);
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(self.loginButton.mas_bottom).offset(0);
    }];
    
    [self.forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.loginButton);
        make.height.top.mas_equalTo(self.registerButton);
        
    }];
    
    [self.renduoduoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self).offset(-40);
        make.height.mas_equalTo(30);
    }];
    
    // 设置登陆注册按钮图标
    float loginW = kScreenWidth - 2*loginleft;
    CGFloat radius = 6;
    UIColor *loginColor = kColor(50, 130, 190);
    UIImage *image_login = [[UIImage wg_imageWithColor:loginColor size:CGSizeMake(loginW, loginH)] wg_imageWithCornerRadius:radius];

    UIImage *highlightImage_login = [[UIImage wg_imageWithColor:[loginColor colorWithAlphaComponent:0.8] size:CGSizeMake(loginW, loginH)] wg_imageWithCornerRadius:radius];
    [self.loginButton setBackgroundImage:image_login forState:UIControlStateNormal];
    [self.loginButton setBackgroundImage:highlightImage_login forState:UIControlStateHighlighted];
    
    
//    self.iconView.backgroundColor = [UIColor redColor];
    self.phoneField.leftView.frame = CGRectMake(0, 0, phoneleftViewW, phoneH);
    self.passField.leftView.frame = CGRectMake(0, 0, phoneleftViewW, phoneH);
    
}

- (void)setIsLoging:(BOOL)isLoging {
    _isLoging = isLoging;
    self.loginButton.userInteractionEnabled = !_isLoging;
}

- (void)wg_login {
    
    if ([self.wg_delegate respondsToSelector:@selector(wg_loginWithPhone:pass:)]) {
//        WGLog(@"%@:%@", self.phoneNewText, self.phoneField.text);
        [self.wg_delegate wg_loginWithPhone:self.phoneField.text pass:self.passField.text];
    }
}
- (void)wg_register {
    if ([self.wg_delegate respondsToSelector:@selector(wg_delegateRegister)]) {
        [self.wg_delegate wg_delegateRegister];
    }
}
- (void)wg_forget {
    if ([self.wg_delegate respondsToSelector:@selector(wg_delegateForget)]) {
        [self.wg_delegate wg_delegateForget];
    }
}
#pragma mark - getter && setter
- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [UIImageView new];
        
    }
    return _iconView;
}
- (UITextField *)phoneField {
    if (!_phoneField) {
        _phoneField = [self getFieldWithIcon:[UIImage imageNamed:@"login_user"] placeholder:@"请输入手机号"];
        _phoneField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _phoneField;
}
- (UITextField *)passField {
    if (!_passField) {
        _passField = [self getFieldWithIcon:[UIImage imageNamed:@"login_pass"] placeholder:@"请输入密码"];
        _passField.secureTextEntry = YES;
//        _passField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    }
    return _passField;
}
- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        _loginButton.titleLabel.font = kBoldFont_PingFang(17);
        [_loginButton addTarget:self action:@selector(wg_login) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}
- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_registerButton setTitleColor:[kWhiteColor colorWithAlphaComponent:0.8] forState:UIControlStateHighlighted];
        _registerButton.titleLabel.font = kFont(14);
//        [_registerButton setTitleColor:kColor_Orange forState:UIControlStateNormal];
//        [_registerButton setTitleColor:[kColor_Orange colorWithAlphaComponent:0.8] forState:UIControlStateHighlighted];
//        _registerButton.titleLabel.font = kBoldFont_PingFang(17);
        [_registerButton addTarget:self action:@selector(wg_register) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}
- (UIButton *)forgetButton {
    if (!_forgetButton) {
        _forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_forgetButton setImage:[UIImage imageNamed:@"login_forget"] forState:UIControlStateNormal];
        [_forgetButton setImage:nil forState:UIControlStateNormal];
        [_forgetButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
        _forgetButton.titleLabel.font = self.registerButton.titleLabel.font;
        [_forgetButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_forgetButton setTitleColor:[kWhiteColor colorWithAlphaComponent:0.8] forState:UIControlStateHighlighted];
//        [_forgetButton setTitleColor:kColor_Orange forState:UIControlStateNormal];
//        [_forgetButton setTitleColor:[kColor_Orange colorWithAlphaComponent:0.8] forState:UIControlStateHighlighted];
//        _forgetButton.titleLabel.font = kFont_13;
        [_forgetButton addTarget:self action:@selector(wg_forget) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetButton;
}
- (UIButton *)renduoduoView {
    if (!_renduoduoView) {
        _renduoduoView = [UIButton buttonWithType:UIButtonTypeCustom];
//        _renduoduoView.backgroundColor = kRedColor;
        UIImage *image = [UIImage imageNamed:@"renduoduo"];
        [_renduoduoView setImage:image forState:UIControlStateNormal];
        _renduoduoView.userInteractionEnabled = NO;
    }
    return _renduoduoView;
}
- (UIView *)fieldBackView {
    if (!_fieldBackView) {
        _fieldBackView = [UIView new];
        _fieldBackView.backgroundColor = [kWhiteColor colorWithAlphaComponent:0.3];
        _fieldBackView.layer.cornerRadius = 6;
        _fieldBackView.clipsToBounds = YES;
    }
    return _fieldBackView;
}
- (UIView *)spaceLine {
    if (!_spaceLine) {
        _spaceLine = [UIView new];
        _spaceLine.backgroundColor = kWhiteColor;
    }
    return _spaceLine;
}
- (UITextField *)getFieldWithIcon:(UIImage *)icon placeholder:(NSString *)placeholder {
    UITextField *field = [[UITextField alloc] init];
    
    field.placeholder = placeholder;
    field.textColor = kColor_White;
//    field.tintColor = kColor_Orange;
    
    // 1.设置提示文本颜色
//    [field setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    // 2.设置提示文本颜色
//    field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName : kColor_Gray_Sub }];
    
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    
//    field.textColor = kColor_Gray_Sub;
    
    [field addTarget:self action:@selector(fieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [field addTarget:self action:@selector(fieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [field addTarget:self action:@selector(fieldEnd:) forControlEvents:UIControlEventEditingDidEnd];
    
    field.leftViewMode = UITextFieldViewModeAlways;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.backgroundColor = [UIColor redColor];
//    button.userInteractionEnabled = NO;
    [button setImage:icon forState:UIControlStateNormal];
    [button setImage:icon forState:UIControlStateHighlighted];
    
//    float left = -10;
//    button.imageEdgeInsets = UIEdgeInsetsMake(0, -left, 0, left);
    
    field.leftView = button;
    
//    field.backgroundColor = [UIColor redColor];
    
    return field;
}
- (void)fieldChanged:(UITextField *)field {
    
    if (field == self.phoneField) {
        
        if (field.text.length) {
            if (![field.text wg_isNumber]) {
                field.text = self.phoneNewText;
                return;
            }
        }

        self.phoneNewText = field.text;
        
        // 位数不大于11
        if (self.phoneNewText.length > 11) {
            field.text = [self.phoneNewText substringToIndex:11];
            self.phoneNewText = field.text;
        }
    }
}
- (void)fieldBegin:(UITextField *)field {
//    WGLog(@"begin:%@", field.text);
}
- (void)fieldEnd:(UITextField *)field {
//    WGLog(@"end:%@", field.text);
}
@end
