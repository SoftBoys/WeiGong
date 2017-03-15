//
//  WGUserDeedbackContactCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/1.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGUserDeedbackContactCell.h"

#define kContactTag 200
@interface WGUserDeedbackContactCell ()
@property (nonatomic, strong) UILabel *labname;
@property (nonatomic, strong) UITextField *field;
@end
@implementation WGUserDeedbackContactCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.labname];
    [self.contentView addSubview:self.field];
//    self.field.backgroundColor = kRedColor;
    
    [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
        //        make.width.mas_equalTo(80);
    }];
    
    CGFloat fieldW = kScreenWidth-60;
    [self.field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labname.mas_right);
        make.top.bottom.height.mas_equalTo(self.labname);
        make.width.mas_equalTo(fieldW);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wg_contactFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
}
- (void)wg_contactFieldDidChange:(NSNotification *)noti {
    UITextField *field = noti.object;
    //    WGLog(@"fieldTag:%@", @(field.tag));
    if (field.tag == self.item.index + kContactTag) {
        self.item.name_content = field.text;
    }
    
}
- (void)setItem:(WGUserDeedbackContactItem *)item {
    _item = item;
    if (_item) {
        
        self.field.tag = kContactTag + _item.index;
        self.labname.text = _item.name_left;
        self.field.placeholder = _item.placeholer;
        self.field.text = _item.name_content;
        
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
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

@implementation WGUserDeedbackContactItem


@end
