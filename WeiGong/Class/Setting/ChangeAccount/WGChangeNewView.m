//
//  WGChangeNewView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/21.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGChangeNewView.h"
#import "WGGetAuthCodeParam.h"

@interface WGChangeNewView ()
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UIView *line3;
@property (nonatomic, strong) UIButton *button_auth;
@property (nonatomic, strong) UITextField *field_name;
@property (nonatomic, strong) UITextField *field_auth;
@property (nonatomic, strong) UITextField *field_pass;
@property (nonatomic, strong) UIButton *button_submit;

@property (nonatomic, copy) NSString *keywork;
/** 是否正在倒计时 */
@property (nonatomic, assign) BOOL isTiming;
@property (nonatomic, strong) NSTimer *timer;
@end
@implementation WGChangeNewView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.field_name = [self fieldWithPlaceholder:@"请输入新手机号"];
        self.field_name.keyboardType = UIKeyboardTypePhonePad;
        self.field_name.rightViewMode = UITextFieldViewModeAlways;
        self.field_name.rightView = self.button_auth;
        self.button_auth.enabled = NO;
        
        self.field_auth = [self fieldWithPlaceholder:@"请输入短信验证码"];
        self.field_auth.keyboardType = UIKeyboardTypePhonePad;
        
        self.field_pass = [self fieldWithPlaceholder:@"请输入新密码"];
        self.field_pass.secureTextEntry = YES;
        
        [self addSubview:self.line1];
        [self addSubview:self.line2];
        [self addSubview:self.line3];
        
        [self addSubview:self.button_submit];
        
        [self makeSubViewsConstraints];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wg_textFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:nil];
        
        
    }
    return self;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)wg_textFieldDidChanged:(NSNotification *)noti {
    
    UITextField *field = noti.object;
    /** 手机号 */
    if (field == self.field_name) {
        NSString *text = field.text;
        if (text.length > 11) {
            text = [text substringToIndex:11];
        }
        field.text = text;
        
        self.button_auth.enabled = field.text.length == 11;
        if (self.isTiming) {
            self.button_auth.enabled = NO;
        }
        
    }
    
    
}
- (void)makeSubViewsConstraints {
    
    
    
    CGFloat fieldH = 40;
    [self.field_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(fieldH);
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(kLineHeight);
        make.top.mas_equalTo(self.field_name.mas_bottom);
    }];
    
    [self.field_auth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.right.mas_equalTo(self.field_name);
        make.top.mas_equalTo(self.line1.mas_bottom);
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(self.line1);
        make.top.mas_equalTo(self.field_auth.mas_bottom);
    }];
    
    [self.field_pass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.right.mas_equalTo(self.field_name);
        make.top.mas_equalTo(self.line2.mas_bottom);
    }];
    
    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(self.line1);
        make.top.mas_equalTo(self.field_pass.mas_bottom);
    }];
    
    CGFloat submitX = 12;
    [self.button_submit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(submitX);
        make.right.mas_equalTo(-submitX);
        make.top.mas_equalTo(self.line3.mas_bottom).offset(18);
        make.height.mas_equalTo(40);
    }];
    
    CGFloat authW = 100, authH = fieldH;
    self.button_auth.frame = CGRectMake(0, 0, authW, authH);
    UIImage *backImage_nor = [[[UIImage wg_imageWithColor:kColor_Blue size:CGSizeMake(20, 20)] wg_imageWithCornerRadius:4 borderWidth:10 borderColor:kClearColor] wg_resizedImage];
    UIImage *backImage_disabled = [[[UIImage wg_imageWithColor:kColor_Gray_Sub size:CGSizeMake(20, 20)] wg_imageWithCornerRadius:4 borderWidth:10 borderColor:kClearColor] wg_resizedImage];
    [self.button_auth setBackgroundImage:backImage_nor forState:UIControlStateNormal];
    [self.button_auth setBackgroundImage:backImage_disabled forState:UIControlStateDisabled];
}

- (UITextField *)fieldWithPlaceholder:(NSString *)placeholder {
    UITextField *field = [UITextField new];
    field.font = kFont(14);
    field.textColor = kColor_Black_Sub;
    field.backgroundColor = kWhiteColor;
    field.placeholder = placeholder;
    field.leftViewMode = UITextFieldViewModeAlways;
    field.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 0)];
    [self addSubview:field];
    return field;
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
- (UIView *)line3 {
    if (!_line3) {
        _line3 = [UIView new];
        _line3.backgroundColor = kColor_Line;
    }
    return _line3;
}

- (UIButton *)button_auth {
    if (!_button_auth) {
        _button_auth = [UIButton buttonWithType:UIButtonTypeCustom];
//        _button_auth.backgroundColor = kRedColor;
        _button_auth.titleLabel.font = kFont(14);
        _button_auth.adjustsImageWhenHighlighted = NO;
        [_button_auth setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_button_auth setTitle:@"获取验证码" forState:UIControlStateNormal];
        __weak typeof(self) weakself = self;
        [_button_auth setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            if (![strongself.field_name.text wg_isPhone]) {
                [strongself.field_name becomeFirstResponder];
                [MBProgressHUD wg_message:@"请输入正确手机号"];
                return ;
            }
            [strongself sendAuthCode];
        }];
    }
    return _button_auth;
}
- (UIButton *)button_submit {
    if (!_button_submit) {
        _button_submit = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_submit.titleLabel.font = kFont(16);
        UIImage *backImage_nor = [[[UIImage wg_imageWithColor:kColor_Blue size:CGSizeMake(30, 30)] wg_imageWithCornerRadius:4] wg_resizedImage];
        UIImage *backImage_hig = [[[UIImage wg_imageWithColor:[kColor_Blue colorWithAlphaComponent:0.8] size:CGSizeMake(30, 30)] wg_imageWithCornerRadius:4] wg_resizedImage];
        [_button_submit setBackgroundImage:backImage_nor forState:UIControlStateNormal];
        [_button_submit setBackgroundImage:backImage_hig forState:UIControlStateHighlighted];
        [_button_submit setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_button_submit setTitle:@"提交" forState:UIControlStateNormal];
        __weak typeof(self) weakself = self;
        [_button_submit setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            [strongself submitData];
        }];
    }
    return _button_submit;
}
- (NSString *)authCodeUrl {
    return @"/linggb-ws/ws/0.1/regcode/getcode";
}
- (void)wg_repead:(NSTimer *)timer {
    static NSTimeInterval seconds = 60;
    seconds --;
    NSString *auth = [NSString stringWithFormat:@"%.2d 秒后重发", (int)seconds];
    [self.button_auth setTitle:auth forState:UIControlStateNormal];
    self.button_auth.enabled = NO;
    
    if (seconds <= 0) {
        self.isTiming = NO;
    }
    if (self.isTiming == NO) {
    
        seconds = 60;
        [timer invalidate];
        self.button_auth.enabled = YES;
        
        auth = @"获取验证码";
        [self.button_auth setTitle:auth forState:UIControlStateNormal];
    }
}
#pragma mark - 获取验证码
- (void)sendAuthCode {
    
    self.isTiming = YES;
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(wg_repead:) userInfo:nil repeats:YES];
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
    
    
    // 发送请求
    WGGetAuthCodeParam *param = [WGGetAuthCodeParam new];
    param.phoneNum = self.field_name.text;
    param.tag = 4;
    
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:[self authCodeUrl]];
    request.wg_parameters = [param wg_keyValues];
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        if (response.statusCode != 200) {
            self.isTiming = NO;
            
        }
        if ([response.responseJSON isKindOfClass:[NSDictionary class]]) {
            NSInteger commen = [response.responseJSON[@"common"] integerValue];
            NSString *content = response.responseJSON[@"content"];
            if (commen == 1) {
                [self.field_auth becomeFirstResponder];
            } else {
                if (content) {
                    [MBProgressHUD wg_message:content];
                }
            }
        }
    }];
}
#pragma mark - 提交
- (void)submitData {
    if (![self.field_name.text wg_isPhone]) {
        [MBProgressHUD wg_message:@"请输入正确手机号"];
        [self.field_name becomeFirstResponder];
        return;
    }
    if (self.field_auth.text.length == 0) {
        [MBProgressHUD wg_message:@"请输入验证码"];
        [self.field_auth becomeFirstResponder];
        return;
    }
    if (self.field_pass.text.length == 0) {
        [MBProgressHUD wg_message:@"请输入新密码"];
        [self.field_pass becomeFirstResponder];
        return;
    }
    [self endEditing:YES];
    __weak typeof(self) weakself = self;
    if (self.accountHandle) {
        self.accountHandle(weakself.field_name.text, weakself.field_auth.text, weakself.field_pass.text);
    }
}


@end
