//
//  WGChangePassAuthView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/23.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGChangePassAuthView.h"

#import "WG_UserDefaults.h"
#import "NSAttributedString+Addition.h"

@interface WGChangePassAuthView ()
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UITextField *field_name;
@property (nonatomic, strong) UITextField *field_pass;
@property (nonatomic, strong) UIButton *button_auth;

@property (nonatomic, copy) NSString *keywork;
@end
@implementation WGChangePassAuthView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        NSString *name_1 = @"请输入 ";
        self.keywork = [WG_UserDefaults shareInstance].loginPhoneNum;
        NSString *name_2 = @" 的当前密码,完成验证";
        NSString *name = [NSString stringWithFormat:@"%@%@%@", name_1, self.keywork, name_2];
        self.field_name = [self textFieldWithText:name];
        self.field_name.userInteractionEnabled = NO;
        self.field_name.attributedText = [NSAttributedString wg_attStringWithString:name keyWord:self.keywork font:self.field_name.font highlightColor:kColor_Blue textColor:self.field_name.textColor];
        
        
        self.field_pass = [self textFieldWithText:name];
        self.field_pass.placeholder = @"请输入旧密码";
        self.field_pass.secureTextEntry = YES;
        UIButton *leftView = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftView setImage:[UIImage imageNamed:@"register_pass"] forState:UIControlStateNormal];
        leftView.wg_width = 34;
        CGFloat left = 3;
        leftView.imageEdgeInsets = UIEdgeInsetsMake(0, left, 0, -left);
        leftView.wg_height = 30;
        self.field_pass.leftView = leftView;
        
        [self addSubview:self.line1];
        [self addSubview:self.line2];
        
        [self addSubview:self.button_auth];
        
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
        
        
        
    }
    return self;
}


- (UITextField *)textFieldWithText:(NSString *)text {
    UITextField *field = [UITextField new];
    field.font = kFont(14);
    field.textColor = kColor_Black_Sub;
    field.backgroundColor = kWhiteColor;
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
- (UIButton *)button_auth {
    if (!_button_auth) {
        _button_auth = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_auth.titleLabel.font = kFont(16);
        UIImage *backImage_nor = [[[UIImage wg_imageWithColor:kColor_Blue size:CGSizeMake(30, 30)] wg_imageWithCornerRadius:4] wg_resizedImage];
        UIImage *backImage_hig = [[[UIImage wg_imageWithColor:[kColor_Blue colorWithAlphaComponent:0.8] size:CGSizeMake(30, 30)] wg_imageWithCornerRadius:4] wg_resizedImage];
        [_button_auth setBackgroundImage:backImage_nor forState:UIControlStateNormal];
        [_button_auth setBackgroundImage:backImage_hig forState:UIControlStateHighlighted];
        [_button_auth setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_button_auth setTitle:@"验证" forState:UIControlStateNormal];
        __weak typeof(self) weakself = self;
        [_button_auth setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            [strongself authData];
        }];
    }
    return _button_auth;
}

#pragma mark - 验证
- (void)authData {
    if (self.field_pass.text.length == 0) {
        [MBProgressHUD wg_message:@"请输入旧密码"];
        [self.field_pass becomeFirstResponder];
        return;
    }
    [self endEditing:YES];
    __weak typeof(self) weakself = self;
    if (self.authHandle) {
        self.authHandle(weakself.field_pass.text);
    }
}
@end
