//
//  WG_SettingCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/21.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_SettingCell.h"

@interface WG_SettingCell ()
@property (nonatomic, strong) UILabel *labname;
@property (nonatomic, strong) UILabel *labcache;
@property (nonatomic, strong) UISwitch *workSwitch;
@end

@implementation WG_SettingCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    
    [self.contentView addSubview:self.labname];
    [self.contentView addSubview:self.labcache];
    [self.contentView addSubview:self.workSwitch];
    
    [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.bottom.mas_equalTo(0);
    }];
    
    [self.labcache mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(self.arrowView.mas_left).offset(0);
    }];
    
    [self.workSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(self.arrowView.mas_left).offset(0);
    }];
}

- (void)setItem:(WG_SettingItem *)item {
    _item = item;
    if (_item) {
        self.labname.text = _item.name;
        self.labcache.hidden = !_item.isCache;
        self.labcache.text = _item.cache;
        
        self.arrowView.hidden = _item.isSwitch;
        self.workSwitch.hidden = !_item.isSwitch;
        
        self.workSwitch.on = _item.status == 2;
        
        self.selectionStyle = self.arrowView.hidden ? UITableViewCellSelectionStyleNone:UITableViewCellSelectionStyleDefault;
        
    }
}

- (UILabel *)labname {
    if (!_labname) {
        _labname = [UILabel wg_labelWithFont:kFont_16 textColor:kColor_Black_Sub];
    }
    return _labname;
}
- (UILabel *)labcache {
    if (!_labcache) {
        _labcache = [UILabel wg_labelWithFont:kFont_16 textColor:kColor_Black_Sub];
    }
    return _labcache;
}
- (UISwitch *)workSwitch {
    if (!_workSwitch) {
        _workSwitch = [[UISwitch alloc] init];
        _workSwitch.tintColor = kColor_Blue;
        _workSwitch.onTintColor = kColor_Blue;
        __weak typeof(self) weakself = self;
        [_workSwitch setBlockForControlEvents:UIControlEventValueChanged block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            [strongself changeWorkState];
        }];
    }
    return _workSwitch;
}

- (void)changeWorkState {
    
    NSInteger status = self.workSwitch.isOn ? 2:1;
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:[self changeStateUrl] isPost:YES];
    request.wg_parameters = @{@"status":@(status)};
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        if ([response.responseJSON isKindOfClass:[NSDictionary class]]) {
            NSString *content = response.responseJSON[@"content"];
            [MBProgressHUD wg_message:content];
        }
    }];
    
}

- (NSString *)changeStateUrl {
    return @"/linggb-ws/ws/0.1/person/updStatus";
}

@end
