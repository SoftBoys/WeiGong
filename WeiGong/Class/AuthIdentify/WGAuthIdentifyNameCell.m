//
//  WGAuthIdentifyNameCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/19.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGAuthIdentifyNameCell.h"

@interface WGAuthIdentifyNameCell ()
@property (nonatomic, strong) UILabel *labname;
@property (nonatomic, strong) UITextField *textField;

@end
@implementation WGAuthIdentifyNameCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.labname];
    [self.contentView addSubview:self.textField];
    
    CGFloat nameX = 10, nameH = 40;
    [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameX);
        make.top.bottom.mas_equalTo(0);
        make.height.mas_equalTo(nameH);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.labname);
        make.right.mas_equalTo(-nameX);
        make.width.mas_equalTo(kScreenWidth-120);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fieldDidChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    
}
- (void)setItem:(WGAuthIdentifyNameItem *)item {
    _item = item;
    if (_item) {
        self.labname.text = _item.text_left;
        self.textField.text = _item.text_right;
        self.textField.userInteractionEnabled = _item.canInput;
        self.textField.tag = _item.index + 100;
        self.textField.keyboardType = _item.index == 1 ? UIKeyboardTypeNumbersAndPunctuation:  UIKeyboardTypeDefault;
//        self.textField.userInteractionEnabled = YES;
    }
}
- (void)fieldDidChanged:(NSNotification *)noti {
    UITextField *field = [noti object];
    
    if (field.tag == 100 && _item.index == 0) { // 名字
        _item.text_right = field.text;
    } else if (field.tag == 101 && _item.index == 1) { // 身份证
        _item.text_right = field.text;
    }
//    WGLog(@"tag:%@", @(field.tag));
}
#pragma mark - getter && setter 
- (UILabel *)labname {
    if (!_labname) {
        _labname = [UILabel wg_labelWithFont:kFont_15 textColor:kColor_Black];
    }
    return _labname;
}
- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField new];
        _textField.font = kFont_15;
        _textField.textColor = kColor_Black_Sub;
        _textField.textAlignment = NSTextAlignmentRight;
//        _textField.backgroundColor = kRedColor;
    }
    return _textField;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

@implementation WGAuthIdentifyNameItem


@end
