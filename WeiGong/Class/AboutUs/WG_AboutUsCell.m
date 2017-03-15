//
//  WG_AboutUsCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/24.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_AboutUsCell.h"
#import "WG_AboutUsItem.h"

@interface WG_AboutUsCell ()
@property (nonatomic, strong) UILabel *labname;
@property (nonatomic, strong) UILabel *labcontent;
@end
@implementation WG_AboutUsCell
- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    
    [self.contentView addSubview:self.labname];
    [self.contentView addSubview:self.labcontent];
    
    [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.bottom.mas_equalTo(0);
        make.height.mas_equalTo(45);
    }];
    
    [self.labcontent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.centerX).offset(-80);
        make.top.bottom.mas_equalTo(0);
    }];
    
}


- (void)setItem:(WG_AboutUsItem *)item {
    _item = item;
    if (_item) {
        self.labname.text = _item.name_left;
        self.labcontent.text = _item.name_right;
    }
    
}
#pragma mark - getter && setter
- (UILabel *)labname {
    if (!_labname) {
        _labname = [UILabel wg_labelWithFont:kFont_16 textColor:kColor_Black_Sub ];
    }
    return _labname;
}
- (UILabel *)labcontent {
    if (!_labcontent) {
        _labcontent = [UILabel wg_labelWithFont:kFont_16 textColor:kColor_Blue ];
    }
    return _labcontent;
}
@end
