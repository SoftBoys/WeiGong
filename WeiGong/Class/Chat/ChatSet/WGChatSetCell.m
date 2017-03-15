//
//  WGChatSetCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/28.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGChatSetCell.h"

@interface WGChatSetCell ()
@property (nonatomic, strong) UILabel *labname;
@property (nonatomic, strong) UISwitch *mySwitch;
@end
@implementation WGChatSetCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    [self.contentView addSubview:self.labname];
    [self.contentView addSubview:self.mySwitch];
    
    [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.bottom.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.mySwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-10);
    }];
}

- (void)setItem:(WGChatSetItem *)item {
    _item = item;
    if (_item) {
        self.labname.text = _item.title;
        self.mySwitch.hidden = !_item.showSwitch;
        self.mySwitch.on = _item.isBlocked;
    }
}

- (UILabel *)labname {
    if (!_labname) {
        _labname = [UILabel wg_labelWithFont:kFont(16) textColor:kColor_Black];
    }
    return _labname;
}
- (UISwitch *)mySwitch {
    if (!_mySwitch) {
        _mySwitch = [UISwitch new];
        __weak typeof(self) weakself = self;
        [_mySwitch setBlockForControlEvents:UIControlEventValueChanged block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            if (strongself.changeSwitchHandle) {
                strongself.changeSwitchHandle(strongself.mySwitch);
            }
        }];
    }
    return _mySwitch;
}
@end

@implementation WGChatSetItem



@end
