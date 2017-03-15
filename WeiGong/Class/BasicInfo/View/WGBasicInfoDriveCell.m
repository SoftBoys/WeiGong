//
//  WGBasicInfoDriveCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/6.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGBasicInfoDriveCell.h"
#import "WGBaseNoHightButton.h"

@interface WGBasicInfoDriveCell ()
@property (nonatomic, strong) UILabel *labname;
@property (nonatomic, strong) WGBaseNoHightButton *button_health;
@property (nonatomic, strong) WGBaseNoHightButton *button_drive;
@end
@implementation WGBasicInfoDriveCell
@synthesize cellItem = _cellItem;
- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    
    [self.contentView addSubview:self.labname];
    [self.contentView addSubview:self.button_health];
    [self.contentView addSubview:self.button_drive];
    
    [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(80);
    }];
    
    [self.button_drive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(0);
        //        make.height.mas_equalTo(40);
        //        make.width.mas_equalTo(80);
    }];
    
    [self.button_health mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.button_drive.mas_left).offset(-10);
        make.centerY.mas_equalTo(0);
        //        make.height.mas_equalTo(40);
        //        make.width.mas_equalTo(80);
    }];
}
- (void)setCellItem:(WGBasicInfoCellItem *)cellItem {
    _cellItem = cellItem;
    if (_cellItem) {
        self.labname.text = _cellItem.name_left;
        
        self.button_health.selected = _cellItem.healthCard;
        self.button_drive.selected = _cellItem.driveLicense;
        
        _cellItem.info.healthCard = _cellItem.healthCard;
        _cellItem.info.driveLicense = _cellItem.driveLicense;
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
- (WGBaseNoHightButton *)button_health {
    if (!_button_health) {
        __weak typeof(self) weakself = self;
        _button_health = [self buttonWithTitle:@"健康证"];
        [_button_health setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            NSInteger healthCard = strongself.cellItem.healthCard ? 0:1;
            strongself.cellItem.healthCard = healthCard;
            strongself.cellItem = strongself.cellItem;
            
        }];
        
    }
    return _button_health;
}
- (WGBaseNoHightButton *)button_drive {
    if (!_button_drive) {
        __weak typeof(self) weakself = self;
        _button_drive = [self buttonWithTitle:@"驾照"];
        [_button_drive setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            NSInteger driveLicense = strongself.cellItem.driveLicense ? 0:1;
            strongself.cellItem.driveLicense = driveLicense;
            strongself.cellItem = strongself.cellItem;

        }];
    }
    return _button_drive;
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
