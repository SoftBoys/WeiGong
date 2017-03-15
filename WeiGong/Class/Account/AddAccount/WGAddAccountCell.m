//
//  WGAddAccountCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/23.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGAddAccountCell.h"

#define kFieldDefaultTag 100

@interface WGAddAccountCell ()
@property (nonatomic, strong) UILabel *labname;
@property (nonatomic, strong) UITextField *field;
@property (nonatomic, strong) UIButton *button;
@end
@implementation WGAddAccountCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.labname];
    [self.contentView addSubview:self.field];
    [self.contentView addSubview:self.button];
    
    [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
//        make.width.mas_equalTo(80);
    }];
    
    CGFloat fieldX = 90;
    [self.field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(fieldX);
        make.top.bottom.height.mas_equalTo(self.labname);
        make.width.mas_equalTo(210);
    }];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.field);
        make.top.bottom.height.mas_equalTo(self.field);
        make.width.mas_equalTo(self.field);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wg_accountFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
}
- (void)wg_accountFieldDidChange:(NSNotification *)noti {
    UITextField *field = noti.object;
//    WGLog(@"fieldTag:%@", @(field.tag));
    if (field.tag == self.item.index + kFieldDefaultTag) {
        self.item.name_content = field.text;
    }
    
}
- (void)setItem:(WGAddAccountItem *)item {
    _item = item;
    if (_item) {
        self.field.tag = kFieldDefaultTag + _item.index;
        self.labname.text = _item.name_left;
        self.field.placeholder = _item.placeholer;
        self.field.text = _item.name_content;
        self.field.userInteractionEnabled = _item.canInput;
        self.button.hidden = self.field.userInteractionEnabled;
    }
}

#pragma mark - getter && setter 
- (UILabel *)labname {
    if (!_labname) {
        _labname = [UILabel wg_labelWithFont:kFont(14) textColor:kColor_Black];
    }
    return _labname;
}
- (UITextField *)field {
    if (!_field) {
        _field = [UITextField new];
        _field.font = kFont(14);
//        _field.backgroundColor = kRedColor;
    }
    return _field;
}
- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = kClearColor;
        __weak typeof(self) weakself = self;
        [_button setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            if ([strongself.delegate respondsToSelector:@selector(chooseBankWithItem:)]) {
                [strongself.delegate chooseBankWithItem:strongself.item];
            }
        }];
    }
    return _button;
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

@implementation WGAddAccountItem



@end
