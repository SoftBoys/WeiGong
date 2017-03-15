//
//  WGBasicInfoNameCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/6.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGBasicInfoNameCell.h"

@interface WGBasicInfoNameCell ()
@property (nonatomic, strong) UILabel *labname;
@property (nonatomic, strong) UITextField *field;
@end
@implementation WGBasicInfoNameCell
@synthesize cellItem = _cellItem;
- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    [self.contentView addSubview:self.labname];
    [self.contentView addSubview:self.field];
    
    [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(80);
    }];
    
    [self.field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(self.arrowView.mas_right);
        make.left.mas_equalTo(self.labname.mas_right);
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fieldDidChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}
- (void)fieldDidChanged:(NSNotification *)noti {
    UITextField *field = noti.object;
    if (field.tag == self.cellItem.cellType) {
        self.cellItem.name_content = field.text;
        if (self.cellItem.cellType == 1) {
            self.cellItem.info.personalName = self.cellItem.name_content;
        } else if (self.cellItem.cellType == 5) {
            self.cellItem.info.school = self.cellItem.name_content;
        } else if (self.cellItem.cellType == 6) {
            self.cellItem.info.profession = self.cellItem.name_content;
        } else if (self.cellItem.cellType == 12) {
            self.cellItem.info.mobile = self.cellItem.name_content;
        } else if (self.cellItem.cellType == 13) {
            self.cellItem.info.wechatNo = self.cellItem.name_content;
        } else if (self.cellItem.cellType == 14) {
            self.cellItem.info.qqNo = self.cellItem.name_content;
        }
    }
}
- (void)setCellItem:(WGBasicInfoCellItem *)cellItem {
    _cellItem = cellItem;
    if (_cellItem) {
        self.labname.text = _cellItem.name_left;
        self.field.text = _cellItem.name_content;
        self.field.placeholder = _cellItem.placeholder;
        self.field.userInteractionEnabled = _cellItem.canInput;
        
        self.field.tag = _cellItem.cellType;
        
    }
}
#pragma mark - getter && setter 
- (UILabel *)labname {
    if (!_labname) {
        UILabel *label = [UILabel wg_labelWithFont:kFont(15) textColor:kColor_Black];
        
        _labname = label;
    }
    return _labname;
}
- (UITextField *)field {
    if (!_field) {
        _field = [[UITextField alloc] init];
        _field.textColor = kColor_Black;
        _field.font = self.labname.font;
        _field.textAlignment = NSTextAlignmentRight;
    }
    return _field;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
