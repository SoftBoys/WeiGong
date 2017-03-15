//
//  WGApplyJobChooseCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/2.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGApplyJobChooseCell.h"

#import "WGApplyJobListItem.h"
#import "WG_JobDetail.h"
#import "WGBaseButton.h"

@interface WGApplyJobChooseCell ()
@property (nonatomic, strong) WGBaseButton *button_content;
@end
@implementation WGApplyJobChooseCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    [self.contentView addSubview:self.button_content];
    
    self.arrowView.transform = CGAffineTransformMakeRotation(M_PI_2);
    
    [self.button_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.centerY.mas_equalTo(0);
    }];
    UIImage *image = [UIImage wg_imageWithColor:kColor_Orange size:CGSizeMake(20, 20)];
    
    [self.button_content setImage:image forState:UIControlStateNormal];
}

- (void)setItem:(WGApplyJobListItem *)item {
    _item = item;
    if (_item) {
        NSString *title = nil;
        UIImage *icon = nil;
        if (_item.type == 1) {
            icon = [UIImage imageNamed:@"applyjob_address"];
            if (_item.addressItem) {
                title = _item.addressItem.jobAddress;
            } else {
                title = @"选择意向工作地点";
            }
        } else if (_item.type == 2) {
            icon = [UIImage imageNamed:@"applyjob_time"];
            if (_item.timeItem) {
                // TODO: 选择可上岗时段
                title = [NSString stringWithFormat:@"%@-%@",_item.timeItem.startTime,_item.timeItem.stopTime];
            } else {
                title = @"选择可上岗时段";
            }
        }
        [self.button_content setTitle:title forState:UIControlStateNormal];
        [self.button_content setImage:icon forState:UIControlStateNormal];
    }
}
#pragma mark - getter && setter 
- (WGBaseButton *)button_content {
    if (!_button_content) {
        WGBaseButton *button = [WGBaseButton buttonWithType:UIButtonTypeCustom];
        button.spaceX = 3;
        button.type = kDMBaseButtonTypeImageTitle;
        button.titleLabel.font = kFont(14);
        [button setTitleColor:kColor_Black forState:UIControlStateNormal];
        button.userInteractionEnabled = NO;
        _button_content = button;
    }
    return _button_content;
}

@end
