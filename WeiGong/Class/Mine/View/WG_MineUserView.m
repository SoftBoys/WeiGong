//
//  WG_MineUserView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/18.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_MineUserView.h"
#import "WG_MineUser.h"
#import <UIImageView+WebCache.h>


@interface WG_MineUserView ()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *labname;
@property (nonatomic, strong) UILabel *labphone;
@property (nonatomic, strong) UIButton *settingBtn;

@end
@implementation WG_MineUserView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self.iconView];
        [self addSubview:self.labname];
        [self addSubview:self.labphone];
        [self addSubview:self.settingBtn];
        
        float iconH = 60;
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(iconH, iconH));
        }];
        
        [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconView.mas_right).offset(10);
            make.top.mas_equalTo(self.iconView).offset(0);
            make.height.mas_equalTo(iconH/2.0);
        }];
        
        [self.labphone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.labname);
            make.top.mas_equalTo(self.labname.mas_bottom).offset(0);
            make.height.mas_equalTo(self.labname);
        }];
        
        float buttonW = 45;
        [self.settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(buttonW);
            make.right.mas_equalTo(self);
            make.top.mas_equalTo(self.iconView).offset(-5);
        }];
        
//        self.iconView.backgroundColor = [UIColor redColor];
//        self.labname.text = @"果果";
//        self.labphone.text = @"18510060862";
        
    }
    return self;
}

- (void)setUser:(WG_MineUser *)user {
    _user = user;
    if (_user) {
//        [self.iconView sd_setImageWithURL:[NSURL URLWithString:_user.iconUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            self.iconView.image = [image wg_circleImage];
//        }];
        [WGDownloadImageManager downloadImageWithUrl:_user.iconUrl completeHandle:^(BOOL finished, UIImage *image) {
            if (image) {
                self.iconView.image = [image wg_circleImage];
            }
        }];
        
        self.labname.text = _user.personalName;
        self.labphone.text = _user.mobile;
        
    }
}

#pragma mark - getter && setter
- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.userInteractionEnabled = YES;
    }
    return _iconView;
}
- (UILabel *)labname {
    if (!_labname) {
        _labname = [UILabel wg_labelWithFont:kFont_16 textColor:kColor_White ];
    }
    return _labname;
}
- (UILabel *)labphone {
    if (!_labphone) {
        _labphone = [UILabel wg_labelWithFont:kFont_15 textColor:kColor_White ];
    }
    return _labphone;
}
- (UIButton *)settingBtn {
    if (!_settingBtn) {
        _settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_settingBtn setImage:[UIImage imageNamed:@"mine_setting"] forState:UIControlStateNormal];
    }
    return _settingBtn;
}
@end
