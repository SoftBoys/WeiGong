//
//  WGRegisterInputAuthView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/23.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGRegisterInputAuthView.h"
#import "NSAttributedString+Addition.h"
#import "NSTimer+Addition.h"

@interface WGRegisterInputAuthView ()
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UITextField *field_name;
@property (nonatomic, strong) UITextField *field_pass;
@property (nonatomic, strong) UIButton *button_auth;
@property (nonatomic, strong) UIButton *button_sendCode;

@property (nonatomic, strong) NSTimer *timer;

@end
@implementation WGRegisterInputAuthView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.field_name = [self textFieldWithText:nil leftImage:nil];
        self.field_name.userInteractionEnabled = NO;
        self.field_name.backgroundColor = kClearColor;
        
        self.field_pass = [self textFieldWithText:nil leftImage:[UIImage imageNamed:@"register_code_old"]];
        self.field_pass.placeholder = @"输入短信中的验证码";
//        self.field_pass.secureTextEntry = YES;
        
        [self addSubview:self.line1];
        [self addSubview:self.line2];
        
        [self addSubview:self.button_auth];
        [self addSubview:self.button_sendCode];
        
        [self.field_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        
        [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(kLineHeight);
            make.top.mas_equalTo(self.field_name.mas_bottom);
        }];
        
        [self.field_pass mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.height.right.mas_equalTo(self.field_name);
            make.top.mas_equalTo(self.line1.mas_bottom);
        }];
        
        [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.mas_equalTo(self.line1);
            make.top.mas_equalTo(self.field_pass.mas_bottom);
        }];
        
        CGFloat authX = 12;
        [self.button_auth mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(authX);
            make.right.mas_equalTo(-authX);
            make.top.mas_equalTo(self.line2.mas_bottom).offset(18);
            make.height.mas_equalTo(40);
        }];
        
        [self.button_sendCode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.mas_equalTo(self.button_auth);
            make.top.mas_equalTo(self.button_auth.mas_bottom).offset(18);
        }];
        
        
    }
    return self;
}

- (void)startTiming {
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    static NSTimeInterval second = 59;
    __block NSString *title = [NSString stringWithFormat:@"%.2d%@",(int)second, @"秒后可重发"];
    __block BOOL enabled = NO;
    self.button_sendCode.enabled = enabled;
    [self.button_sendCode setTitle:title forState:UIControlStateNormal];
    
    __weak typeof(self) weakself = self;
    self.timer = [NSTimer wg_timerWithTimeInterval:1 block:^{
        
        __strong typeof(weakself) strongself = weakself;
        second -- ;
        enabled = NO;
        title = [NSString stringWithFormat:@"%.2d%@",(int)second, @"秒后可重发"];
        if (second <= 0) {
            second = 59;
            enabled = YES;
            [strongself.timer invalidate];
            strongself.timer = nil;
            title = @"重新获取验证码";
        }
        strongself.button_sendCode.enabled = enabled;
        [strongself.button_sendCode setTitle:title forState:UIControlStateNormal];
    } repeats:YES];
    
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:self.timer forMode:NSRunLoopCommonModes];

    
}

- (void)setPhone:(NSString *)phone {
    _phone = phone;
    if (_phone) {
        
        NSString *name_1 = @"已向你的手机";
        NSString *name_2 = @"发送了验证码";
        
        NSString *name = [NSString stringWithFormat:@"%@ %@ %@", name_1, _phone, name_2];
        self.field_name.attributedText = [NSAttributedString wg_attStringWithString:name keyWord:_phone font:self.field_name.font highlightColor:kColor_Blue textColor:self.field_name.textColor];
        
    }
}

- (UITextField *)textFieldWithText:(NSString *)text leftImage:(UIImage *)image {
    UITextField *field = [UITextField new];
    field.font = kFont(14);
    field.textColor = kColor_Black_Sub;
    field.backgroundColor = kWhiteColor;
    field.leftViewMode = UITextFieldViewModeAlways;
    if (image == nil) {
        UIView *leftView = [UIView new];
        leftView.wg_width = 12;
        field.leftView = leftView;
    } else {
        UIButton *leftView = [self leftButtonWithImage:image];
        leftView.wg_height = 30;
        leftView.wg_width = 40;
        field.leftView = leftView;
    }
    
    [self addSubview:field];
    return field;
}
- (UIButton *)leftButtonWithImage:(UIImage *)image {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.userInteractionEnabled = NO;
    [button setImage:image forState:UIControlStateNormal];
    button.wg_width = 30;
    //    button.backgroundColor = kRedColor;
    return button;
}
- (UIButton *)buttonWithNorBackColor:(UIColor *)backColor_nor disabledBackColor:(UIColor *)backColor_dis {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = kFont(16);
    UIImage *backImage_nor = [[[UIImage wg_imageWithColor:backColor_nor size:CGSizeMake(30, 30)] wg_imageWithCornerRadius:4] wg_resizedImage];
    UIImage *backImage_hig = [[[UIImage wg_imageWithColor:[backColor_nor colorWithAlphaComponent:0.8] size:CGSizeMake(30, 30)] wg_imageWithCornerRadius:4] wg_resizedImage];
    UIImage *backImage_dis = [[[UIImage wg_imageWithColor:backColor_dis size:CGSizeMake(30, 30)] wg_imageWithCornerRadius:4] wg_resizedImage];
    [button setBackgroundImage:backImage_nor forState:UIControlStateNormal];
    [button setBackgroundImage:backImage_hig forState:UIControlStateHighlighted];
    [button setBackgroundImage:backImage_dis forState:UIControlStateDisabled];
    [button setTitleColor:kWhiteColor forState:UIControlStateNormal];
    return button;
}
#pragma mark - getter && setter
- (UIView *)line1 {
    if (!_line1) {
        _line1 = [UIView new];
        _line1.backgroundColor = kColor_Line;
    }
    return _line1;
}
- (UIView *)line2 {
    if (!_line2) {
        _line2 = [UIView new];
        _line2.backgroundColor = kColor_Line;
    }
    return _line2;
}
- (UIButton *)button_auth {
    if (!_button_auth) {
        _button_auth = [self buttonWithNorBackColor:kColor_Blue disabledBackColor:nil];
        [_button_auth setTitle:@"验证" forState:UIControlStateNormal];
        __weak typeof(self) weakself = self;
        [_button_auth setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            [strongself authData];
        }];
    }
    return _button_auth;
}
- (UIButton *)button_sendCode {
    if (!_button_sendCode) {
        _button_sendCode = [self buttonWithNorBackColor:kColor_Blue disabledBackColor:kColor_PlaceHolder];
        [_button_sendCode setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        __weak typeof(self) weakself = self;
        [_button_sendCode setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
//            [strongself startTiming];
            if (strongself.getCodeHandle) {
                strongself.getCodeHandle(strongself.phone);
            }
        }];
    }
    return _button_sendCode;
}

#pragma mark - 验证
- (void)authData {
    if (self.field_pass.text.length == 0) {
        [MBProgressHUD wg_message:@"请输入验证码"];
        [self.field_pass becomeFirstResponder];
        return;
    }
    [self endEditing:YES];
    __weak typeof(self) weakself = self;
    if (self.authHandle) {
        self.authHandle(weakself.phone, weakself.field_pass.text);
    }
}

@end
