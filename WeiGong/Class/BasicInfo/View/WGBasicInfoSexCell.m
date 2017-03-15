//
//  WGBasicInfoSexCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/6.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGBasicInfoSexCell.h"

@interface WGBasicInfoSexCell ()
@property (nonatomic, strong) UILabel *labname;
@property (nonatomic, strong) UITextField *field;
@property (nonatomic, strong) UIButton *button;
@end

@implementation WGBasicInfoSexCell

@synthesize cellItem = _cellItem;
- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    [self.contentView addSubview:self.labname];
    [self.contentView addSubview:self.field];
    [self.contentView addSubview:self.button];
    
    self.arrowView.hidden = NO;
    self.arrowView.transform = CGAffineTransformMakeRotation(M_PI_2);
    
    [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(80);
    }];
    
    [self.field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(self.arrowView.mas_left).offset(-8);
//        make.left.mas_equalTo(self.labname.mas_right);
        make.width.mas_equalTo(kScreenWidth-80-50);
    }];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(self.arrowView.mas_right);
        make.width.mas_equalTo(60);
    }];
}
- (void)setCellItem:(WGBasicInfoCellItem *)cellItem {
    _cellItem = cellItem;
    if (_cellItem) {
        self.labname.text = _cellItem.name_left;
        self.field.text = _cellItem.name_content;
        self.field.placeholder = _cellItem.placeholder;
        
        if (_cellItem.cellType == 2) {
            WGBasicInfoSexItem *sexItem = _cellItem.sexItem;
            self.field.text = sexItem.name;
        } else if (_cellItem.cellType == 3) {
            WGBasicInfoBirthItem *birthItem = _cellItem.birthItem;
            self.field.text = birthItem.dateStr;
        }
        
        self.button.userInteractionEnabled = _cellItem.canInput;
        
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
        _field.userInteractionEnabled = NO;
    }
    return _field;
}
- (UIButton *)button {
    if (!_button) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        __weak typeof(self) weakself = self;
        [button setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            if ([strongself.delegate respondsToSelector:@selector(actionSheetWithItem:)]) {
                [strongself.delegate actionSheetWithItem:strongself.cellItem];
            }
        }];
        _button = button;
    }
    return _button;
}

@end
