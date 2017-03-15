//
//  WGRegisterInputPhoneView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/23.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGRegisterInputPhoneView.h"
#import "NSAttributedString+Addition.h"
#import "WG_UserDefaults.h"
#import "WG_WebViewController.h"

@interface WGRegisterInputPhoneView ()
@property (nonatomic, strong) UITextField *field_phone;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIButton *button_getcode;

@property (nonatomic, strong) UIView *protocolView;
@end
@implementation WGRegisterInputPhoneView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.field_phone = [self textFieldWithText:nil leftImage:[UIImage imageNamed:@"register_phone_old"]];
        self.field_phone.placeholder = @"请输入您的手机号";
        self.field_phone.keyboardType = UIKeyboardTypePhonePad;
        
        [self addSubview:self.line];
        
        [self addSubview:self.button_getcode];
        
        [self addSubview:self.protocolView];
        
        [self.field_phone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(kLineHeight);
            make.top.mas_equalTo(self.field_phone.mas_bottom);
        }];
        
        CGFloat codeX = 12;
        [self.button_getcode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(codeX);
            make.right.mas_equalTo(-codeX);
            make.top.mas_equalTo(self.line.mas_bottom).offset(18);
            make.height.mas_equalTo(40);
        }];
        
        [self.protocolView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.button_getcode.mas_bottom);
            make.height.mas_equalTo(40);
        }];
        
        self.isRegister = YES;
        
    }
    return self;
}

- (void)setIsRegister:(BOOL)isRegister {
    _isRegister = isRegister;
    self.protocolView.hidden = !_isRegister;
}

- (UITextField *)textFieldWithText:(NSString *)text leftImage:(UIImage *)image {
    UITextField *field = [UITextField new];
    field.font = kFont(14);
    field.textColor = kColor_Black_Sub;
    field.backgroundColor = kWhiteColor;
    field.leftViewMode = UITextFieldViewModeAlways;
    UIButton *leftView = [self leftButtonWithImage:image];
    leftView.wg_height = 30;
    field.leftView = leftView;
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
#pragma mark - getter && setter
- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = kColor_Line;
    }
    return _line;
}

- (UIButton *)button_getcode {
    if (!_button_getcode) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = kFont(16);
        UIImage *backImage_nor = [[[UIImage wg_imageWithColor:kColor_Blue size:CGSizeMake(30, 30)] wg_imageWithCornerRadius:4] wg_resizedImage];
        UIImage *backImage_hig = [[[UIImage wg_imageWithColor:[kColor_Blue colorWithAlphaComponent:0.8] size:CGSizeMake(30, 30)] wg_imageWithCornerRadius:4] wg_resizedImage];
        [button setBackgroundImage:backImage_nor forState:UIControlStateNormal];
        [button setBackgroundImage:backImage_hig forState:UIControlStateHighlighted];
        [button setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [button setTitle:@"获取短信验证码" forState:UIControlStateNormal];
        __weak typeof(self) weakself = self;
        [button setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            [strongself getCodeData];
        }];
        
        _button_getcode = button;
    }
    return _button_getcode;
}
- (UIView *)protocolView {
    if (!_protocolView) {
        UIView *view = [UIView new];
        
        UILabel *label = [UILabel wg_labelWithFont:kFont(12) textColor:kColor_Black_Sub];
        label.text = @"注册即表示已阅读接受";
        label.textColor = kColor_Black_Sub;
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.centerY.mas_equalTo(0);
        }];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = label.font;
        NSString *key = @"《微工网协议》";
        NSMutableAttributedString *attStr = [[NSAttributedString wg_attStringWithString:key keyWord:key font:label.font highlightColor:kBlackColor textColor:kBlackColor] mutableCopy];
        CGFloat offset = 1;
        [attStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(offset, key.length-offset*2)];
        
        [button setAttributedTitle:attStr forState:UIControlStateNormal];
        [view addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(label.mas_right);
            make.centerY.mas_equalTo(0);
        }];
        __weak typeof(self) weakself = self;
        [button setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            if (strongself.protocolHandle) {
                strongself.protocolHandle();
            }
        }];
        _protocolView = view;
    }
    return _protocolView;
}

#pragma mark - 获取短信验证码
- (void)getCodeData {
    if (self.field_phone.text.length == 0) {
        [MBProgressHUD wg_message:@"请输入手机号"];
        [self.field_phone becomeFirstResponder];
        return;
    } else if (![self.field_phone.text wg_isPhone]) {
        [MBProgressHUD wg_message:@"请输入正确手机号"];
        [self.field_phone becomeFirstResponder];
        return;
    }
    [self endEditing:YES];
    __weak typeof(self) weakself = self;
    if (self.getCodeHandle) {
        self.getCodeHandle(weakself.field_phone.text);
    }
}

@end
