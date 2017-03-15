//
//  WGBasicInfoExperienceCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/6.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGBasicInfoExperienceCell.h"

@interface WGBasicInfoExperienceCell ()
@property (nonatomic, strong) UILabel *labname;
@property (nonatomic, strong) UITextField *field;
@end
@implementation WGBasicInfoExperienceCell
@synthesize cellItem = _cellItem;
- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    [self.contentView addSubview:self.labname];
    [self.contentView addSubview:self.field];
    self.arrowView.hidden = NO;
    
    [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(80);
    }];
    
    [self.field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(self.arrowView.mas_left).offset(-3);
        make.width.mas_equalTo(kScreenWidth-80-50);
    }];
}
- (void)setCellItem:(WGBasicInfoCellItem *)cellItem {
    _cellItem = cellItem;
    if (_cellItem) {
        self.labname.text = _cellItem.name_left;
        self.field.text = _cellItem.name_content;
        self.field.userInteractionEnabled = _cellItem.canInput;
        self.field.placeholder = _cellItem.placeholder;
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

@end
