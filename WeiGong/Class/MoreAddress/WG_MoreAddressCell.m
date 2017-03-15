//
//  WG_MoreAddressCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/11.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_MoreAddressCell.h"
#import "WG_JobDetail.h"

@interface WG_MoreAddressCell ()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *labtitle;
@property (nonatomic, strong) UILabel *labcontent;
@end

@implementation WG_MoreAddressCell
- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.labtitle];
    [self.contentView addSubview:self.labcontent];
    
    UIImage *image = [UIImage imageNamed:@"location"];
    self.iconView.image = image;
    CGSize size = image.size;
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(size);
//        make.height.mas_equalTo(45);
    }];
    float spaceY = 4;
    [self.labtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconView.mas_right).offset(5);
        make.top.mas_equalTo(spaceY);
    }];
    [self.labcontent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labtitle);
        make.top.mas_equalTo(self.labtitle.mas_bottom).offset(0);
        make.bottom.mas_equalTo(self.contentView).offset(-spaceY);
    }];
}

- (void)setItem:(WG_JobAddressItem *)item {
    _item = item;
    if (_item) {
        self.labtitle.text = _item.locationName;
        self.labcontent.text = _item.jobAddress;
    }
}

#pragma mark - getter && setter
- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [UIImageView new];
    }
    return _iconView;
}
- (UILabel *)labtitle {
    if (!_labtitle) {
        _labtitle = [UILabel wg_labelWithFont:kFont_15 textColor:kColor_Black];
    }
    return _labtitle;
}
- (UILabel *)labcontent {
    if (!_labcontent) {
        _labcontent = [UILabel wg_labelWithFont:kFont_15 textColor:kColor_Black_Sub ];
    }
    return _labcontent;
}
@end
