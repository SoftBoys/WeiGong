//
//  WGBasicInfoMoreCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/6.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGBasicInfoMoreCell.h"

@interface WGBasicInfoMoreCell ()
@property (nonatomic, strong) UILabel *labname;
@property (nonatomic, strong) UISwitch *mySwitch;
@end
@implementation WGBasicInfoMoreCell
@synthesize cellItem = _cellItem;
- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    [self.contentView addSubview:self.labname];
    [self.contentView addSubview:self.mySwitch];

    
    [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(80);
    }];
    
    [self.mySwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.arrowView.mas_right);
        make.centerY.mas_equalTo(0);
    }];
    
}

- (void)setCellItem:(WGBasicInfoCellItem *)cellItem {
    _cellItem = cellItem;
    if (_cellItem) {
        self.labname.text = _cellItem.name_left;
        self.mySwitch.on = _cellItem.moreCellIsOn;
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
- (UISwitch *)mySwitch {
    if (!_mySwitch) {
        _mySwitch = [[UISwitch alloc] init];
        _mySwitch.onTintColor = kColor_Blue;
        __weak typeof(self) weakself = self;
        [_mySwitch setBlockForControlEvents:UIControlEventValueChanged block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            if ([strongself.delegate respondsToSelector:@selector(modifyMoreCellStatuWithItem:)]) {
                [strongself.delegate modifyMoreCellStatuWithItem:strongself.cellItem];
            }
        }];
    }
    return _mySwitch;
}
@end
