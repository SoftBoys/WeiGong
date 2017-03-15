//
//  WGChangeConfirmPassView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/23.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGChangeConfirmPassView.h"

@interface WGChangeConfirmPassView ()
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UITextField *field_pass1;
@property (nonatomic, strong) UITextField *field_pass2;
@property (nonatomic, strong) UIButton *button_submit;

@end
@implementation WGChangeConfirmPassView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.field_pass1 = [self fieldWithPlaceholder:@"设置新密码"];
        self.field_pass1.secureTextEntry = YES;
        [self addSubview:self.field_pass1];
        
        self.field_pass2 = [self fieldWithPlaceholder:@"确认新密码"];
        self.field_pass2.secureTextEntry = YES;
        [self addSubview:self.field_pass2];
        
        [self addSubview:self.line1];
        [self addSubview:self.line2];
        [self addSubview:self.button_submit];
        
        [self makeSubViewsConstraints];
    }
    return self;
}

- (void)makeSubViewsConstraints {
    
    CGFloat fieldH = 40;
    [self.field_pass1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(fieldH);
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(kLineHeight);
        make.top.mas_equalTo(self.field_pass1.mas_bottom);
    }];
    
    [self.field_pass2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.right.mas_equalTo(self.field_pass1);
        make.top.mas_equalTo(self.line1.mas_bottom);
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(self.line1);
        make.top.mas_equalTo(self.field_pass2.mas_bottom);
    }];

    CGFloat submitX = 12;
    [self.button_submit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(submitX);
        make.right.mas_equalTo(-submitX);
        make.top.mas_equalTo(self.line2.mas_bottom).offset(18);
        make.height.mas_equalTo(40);
    }];
}

- (UITextField *)fieldWithPlaceholder:(NSString *)placeholder {
    UITextField *field = [UITextField new];
    field.font = kFont(14);
    field.textColor = kColor_Black_Sub;
    field.backgroundColor = kWhiteColor;
    field.placeholder = placeholder;
    field.leftViewMode = UITextFieldViewModeAlways;
    UIButton *leftView = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftView setImage:[UIImage imageNamed:@"register_pass"] forState:UIControlStateNormal];
    leftView.wg_width = 34;
    CGFloat left = 3;
    leftView.imageEdgeInsets = UIEdgeInsetsMake(0, left, 0, -left);
    leftView.wg_height = 30;
    field.leftView = leftView;
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

#pragma mark - 提交
- (void)submitData {
    
    if (self.field_pass1.text.length == 0) {
        [MBProgressHUD wg_message:@"请输入新密码"];
        [self.field_pass1 becomeFirstResponder];
        return;
    }
    if (self.field_pass2.text.length == 0) {
        [MBProgressHUD wg_message:@"请输入确认密码"];
        [self.field_pass2 becomeFirstResponder];
        return;
    }
    if (self.field_pass2.text != self.field_pass1.text) {
        [MBProgressHUD wg_message:@"两次密码不一致"];
        [self.field_pass2 becomeFirstResponder];
        return;
    }
    [self endEditing:YES];
    __weak typeof(self) weakself = self;
    if (self.handle) {
        self.handle(weakself.field_pass1.text, weakself.field_pass2.text);
    }
}

@end
