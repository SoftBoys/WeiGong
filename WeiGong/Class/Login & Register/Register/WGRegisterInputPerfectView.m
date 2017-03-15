//
//  WGRegisterInputPerfectView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/1.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGRegisterInputPerfectView.h"
#import "WGDataTypeItem.h"
#import "WG_CityItem.h"
#import "WGBaseButton.h"
#import "WGPickerCityView.h"

@interface WGRegisterInputPerfectView ()
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UIView *line3;
@property (nonatomic, strong) UIView *whiteBackView;
@property (nonatomic, strong) UITextField *field_pass1;
@property (nonatomic, strong) UITextField *field_pass2;
@property (nonatomic, strong) UITextField *field_name;
@property (nonatomic, strong) UITextField *field_city;
@property (nonatomic, strong) UITextField *field_address;
@property (nonatomic, strong) UITextField *field_job;
@property (nonatomic, strong) WGBaseButton *button_city;
@property (nonatomic, strong) UIButton *button_job;

@property (nonatomic, strong) UIButton *button_submit;

@end

@implementation WGRegisterInputPerfectView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.field_pass1];
        [self addSubview:self.field_pass2];
        
        self.whiteBackView = [UIView new];
        self.whiteBackView.backgroundColor = kWhiteColor;
        [self addSubview:self.whiteBackView];
        
        UIView *line1 = [UIView new];
        line1.backgroundColor = kColor_Line;
        [self addSubview:line1];
        UIView *line2 = [UIView new];
        line2.backgroundColor = kColor_Line;
        [self.whiteBackView addSubview:line2];
        UIView *line3 = [UIView new];
        line3.backgroundColor = kColor_Line;
        [self.whiteBackView addSubview:line3];
        self.line1 = line1;
        self.line2 = line2;
        self.line3 = line3;
        
       
        
        [self.whiteBackView addSubview:self.field_name];
        [self.whiteBackView addSubview:self.field_city];
        [self.whiteBackView addSubview:self.field_address];
        [self.whiteBackView addSubview:self.field_job];
        [self.whiteBackView addSubview:self.button_city];
        [self.whiteBackView addSubview:self.button_job];
        
        [self addSubview:self.button_submit];
        
        [self makeSubviewConstraints];
        
    }
    return self;
}
- (void)makeSubviewConstraints {
    CGFloat fieldH = 40;
    [self.field_pass1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(fieldH);
    }];
    CGFloat lineX = 12;
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineX);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(kLineHeight);
        make.top.mas_equalTo(self.field_pass1.mas_bottom);
    }];
    
    [self.field_pass2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(self.field_pass1);
        make.top.mas_equalTo(self.field_pass1.mas_bottom);
    }];
    
    [self.whiteBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.field_pass2.mas_bottom).offset(10);
//        make.height.mas_equalTo(200);
    }];
    
    [self.field_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(self.field_pass1);

    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineX);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(kLineHeight);
        make.top.mas_equalTo(self.field_name.mas_bottom);
    }];
//    return;
    [self.field_city mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(self.field_pass1);
        make.top.mas_equalTo(self.line2.mas_bottom);
        make.width.mas_equalTo(30);
    }];
    
    
    [self.button_city mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.field_city.mas_right).offset(0);
        make.centerY.mas_equalTo(self.field_city);
    }];
    
    
    [self.field_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.field_pass1);
        make.top.mas_equalTo(self.field_city);
        make.width.mas_equalTo(150);
        make.right.mas_equalTo(-10);
    }];
    
    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineX);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(kLineHeight);
        make.top.mas_equalTo(self.field_city.mas_bottom);
    }];
    
    
    [self.field_job mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.mas_equalTo(self.field_pass1);
        make.top.mas_equalTo(self.line3.mas_bottom);
        make.bottom.mas_equalTo(0);
    }];
    
    [self.button_job mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.height.mas_equalTo(self.field_job);
//        make.top.mas_equalTo(self.field_city);
    }];
    
    CGFloat submitX = 12;
    [self.button_submit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(submitX);
        make.right.mas_equalTo(-submitX);
        make.top.mas_equalTo(self.button_job.mas_bottom).offset(18);
        make.height.mas_equalTo(40);
    }];
    
    
}

- (void)setCityItem:(WGPickerCityItem *)cityItem {
    _cityItem = cityItem;
    if (_cityItem) {
        
        NSString *title = _cityItem.city;
        WGPickerCityItem *subcityItem = [_cityItem.subItems wg_objectAtIndex:_cityItem.index_sel];
        NSString *name = subcityItem.city;
        [self.button_city setTitle:kStringAppend(title, name) forState:UIControlStateNormal];
    }
}
- (void)setTypeItemList:(NSArray<WGDataTypeItem *> *)typeItemList {
    _typeItemList = [typeItemList copy];
    if (_typeItemList.count) {
        NSMutableArray *nameList = [@[] mutableCopy];
        for (WGDataTypeItem *item in _typeItemList) {
            [nameList wg_addObject:item.name];
        }
        self.field_job.text = [nameList componentsJoinedByString:@","];
    }
}

- (UITextField *)fieldWithPlaceholder:(NSString *)placeholder leftImage:(UIImage *)image {
    UITextField *field = [UITextField new];
    field.font = kFont(14);
    field.textColor = kColor_Black_Sub;
    field.placeholder = placeholder;
    field.backgroundColor = kWhiteColor;
    field.leftViewMode = UITextFieldViewModeAlways;
    UIButton *leftView = [self leftButtonWithImage:image];
    leftView.wg_height = 30;
    field.leftView = leftView;
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
- (UITextField *)field_pass1 {
    if (!_field_pass1) {
        _field_pass1 = [self fieldWithPlaceholder:@"设置密码" leftImage:[UIImage imageNamed:@"register_pass"]];
        _field_pass1.secureTextEntry = YES;
    }
    return _field_pass1;
}

- (UITextField *)field_pass2 {
    if (!_field_pass2) {
        _field_pass2 = [self fieldWithPlaceholder:@"确认密码" leftImage:[UIImage imageNamed:@"register_pass"]];
        _field_pass2.secureTextEntry = YES;
    }
    return _field_pass2;
}
- (UITextField *)field_name {
    if (!_field_name) {
        _field_name = [self fieldWithPlaceholder:@"姓名" leftImage:[UIImage imageNamed:@"register_user"]];
    }
    return _field_name;
}
- (UITextField *)field_city {
    if (!_field_city) {
        _field_city = [self fieldWithPlaceholder:nil leftImage:[UIImage imageNamed:@"register_location"]];
        _field_city.userInteractionEnabled = NO;
    }
    return _field_city;
}

- (UITextField *)field_address {
    if (!_field_address) {
        _field_address = [self fieldWithPlaceholder:@"工作地点(选填)" leftImage:nil];
        _field_address.textAlignment = NSTextAlignmentRight;
        _field_address.leftView = nil;
        _field_address.leftViewMode = UITextFieldViewModeNever;
    }
    return _field_address;
}
- (UITextField *)field_job {
    if (!_field_job) {
        _field_job = [self fieldWithPlaceholder:nil leftImage:[UIImage imageNamed:@"register_job"]];
        _field_job.userInteractionEnabled = NO;
        _field_job.text = @"工作岗位";
    }
    return _field_job;
}
- (WGBaseButton *)button_city {
    if (!_button_city) {
        _button_city = [WGBaseButton buttonWithType:UIButtonTypeCustom];
        _button_city.titleLabel.font = self.field_name.font;
        [_button_city setTitleColor:self.field_name.textColor forState:UIControlStateNormal];
        _button_city.type = kDMBaseButtonTypeTitleImage;
        _button_city.spaceX = 4;
//        _button_city.backgroundColor = kGreenColor;
        [_button_city setTitle:@"工作地区" forState:UIControlStateNormal];
        
        CGSize arrowSize = CGSizeMake(12, 6);
        UIImage *image = [UIImage wg_arrowImageWithColor:kColor_Black_Sub size:arrowSize arrowW:1 arrowType:WGArrowImageTypeBottom];
        [_button_city setImage:image forState:UIControlStateNormal];
        
        __weak typeof(self) weakself = self;
        [_button_city setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
//            WGLog(@"工作地区");
            if (strongself.cityHandle) {
                strongself.cityHandle(strongself.cityItem);
            }
        }];
    }
    return _button_city;
}
- (UIButton *)button_job {
    if (!_button_job) {
        _button_job = [UIButton buttonWithType:UIButtonTypeCustom];
        __weak typeof(self) weakself = self;
        [_button_job setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
//            WGLog(@"工作岗位");
            if (strongself.typeHandle) {
                strongself.typeHandle(strongself.typeItemList);
            }
        }];
    }
    return _button_job;
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
        [_button_submit setTitle:@"确认提交" forState:UIControlStateNormal];
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
        [MBProgressHUD wg_message:@"请输入密码"];
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
    if (self.field_name.text.length == 0) {
        [MBProgressHUD wg_message:@"请输入姓名"];
        [self.field_name becomeFirstResponder];
        return;
    }
    if (self.cityItem == nil) {
        [MBProgressHUD wg_message:@"请选择工作地区"];
        return;
    }
    if (self.typeItemList == nil || self.typeItemList.count == 0) {
        [MBProgressHUD wg_message:@"请选择工作岗位"];
        return;
    }
    
    
    [self endEditing:YES];
    __weak typeof(self) weakself = self;
    if (self.submitHandle) {
        self.submitHandle(weakself.field_pass1.text, weakself.field_name.text, weakself.cityItem, weakself.typeItemList, weakself.field_address.text);
    }
}
@end
