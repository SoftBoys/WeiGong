//
//  WGBasicInfoIdentifyCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/6.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGBasicInfoIdentifyCell.h"
#import "WGBaseNoHightButton.h"

@interface WGBasicInfoIdentifyCell ()
@property (nonatomic, strong) UILabel *labname;
@property (nonatomic, strong) WGBaseNoHightButton *button_man;
@property (nonatomic, strong) WGBaseNoHightButton *button_student;
@end
@implementation WGBasicInfoIdentifyCell
@synthesize cellItem = _cellItem;
- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    [self.contentView addSubview:self.labname];
    [self.contentView addSubview:self.button_man];
    [self.contentView addSubview:self.button_student];
    
    [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(80);
    }];
    
    [self.button_student mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(0);
//        make.height.mas_equalTo(40);
//        make.width.mas_equalTo(80);
    }];
    
    [self.button_man mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.button_student.mas_left).offset(-10);
        make.centerY.mas_equalTo(0);
        //        make.height.mas_equalTo(40);
        //        make.width.mas_equalTo(80);
    }];
}
- (void)setCellItem:(WGBasicInfoCellItem *)cellItem {
    _cellItem = cellItem;
    if (_cellItem) {
        self.labname.text = _cellItem.name_left;
        
        self.button_student.selected = _cellItem.identFlag == 1;
        self.button_man.selected = _cellItem.identFlag == 2;
        
        
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
- (WGBaseNoHightButton *)button_man {
    if (!_button_man) {
        __weak typeof(self) weakself = self;
        _button_man = [self buttonWithTitle:@"社会成员"];
        [_button_man setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            if (strongself.cellItem.identFlag == 2) return ;
            if ([strongself.delegate respondsToSelector:@selector(modifyIdentifyWithCellItem:)]) {
                [strongself.delegate modifyIdentifyWithCellItem:strongself.cellItem];
            }
        }];
        
    }
    return _button_man;
}
- (WGBaseNoHightButton *)button_student {
    if (!_button_student) {
        __weak typeof(self) weakself = self;
        _button_student = [self buttonWithTitle:@"在校学生"];
        [_button_student setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            if (strongself.cellItem.identFlag == 1) return ;

            if ([strongself.delegate respondsToSelector:@selector(modifyIdentifyWithCellItem:)]) {
                [strongself.delegate modifyIdentifyWithCellItem:strongself.cellItem];
            }
        }];
    }
    return _button_student;
}
- (WGBaseNoHightButton *)buttonWithTitle:(NSString *)title {
    WGBaseNoHightButton *button = [WGBaseNoHightButton buttonWithType:UIButtonTypeCustom];
    UIImage *image_nor = [[[UIImage wg_imageWithColor:kWhiteColor size:CGSizeMake(10, 10)] wg_imageWithCornerRadius:3 borderWidth:kLineHeight borderColor:kColor_Gray_Sub] wg_resizedImage];
    UIImage *image_sel = [[[UIImage wg_imageWithColor:kWhiteColor size:CGSizeMake(10, 10)] wg_imageWithCornerRadius:3 borderWidth:kLineHeight borderColor:kColor_Orange] wg_resizedImage];
    [button setTitleColor:kColor_Gray_Sub forState:UIControlStateNormal];
    [button setTitleColor:kColor_Orange forState:UIControlStateSelected];
    [button setBackgroundImage:image_nor forState:UIControlStateNormal];
    [button setBackgroundImage:image_sel forState:UIControlStateSelected];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = kFont(14);
    CGFloat left = 4, top = 3;
    button.insets = UIEdgeInsetsMake(top, left, top, left);
    
    return button;
}
@end
