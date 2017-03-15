//
//  WG_AboutUsHeadView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/25.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_AboutUsHeadView.h"

@interface WG_AboutUsHeadView ()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *labname;
@end
@implementation WG_AboutUsHeadView

- (instancetype)init {
    if (self = [super init]) {
        
        [self addSubview:self.iconView];
        [self addSubview:self.labname];
        
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(100);
            make.center.mas_equalTo(self).centerOffset(CGPointMake(0, -20));
        }];
        
        [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.iconView.mas_bottom).offset(20);
            make.centerX.mas_equalTo(self);
        }];
        
        self.labname.text = [NSString stringWithFormat:@"微工 v%@", kAppVersion];
//        self.iconView.backgroundColor = [UIColor redColor];
        
        UIImage *image = [[UIImage imageNamed:@"icon_login"] wg_resizedImageWithNewSize:CGSizeMake(100, 100)];
        self.iconView.image = image;
    }
    return self;
}

#pragma mark - getter && setter
- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [UIImageView new];
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconView;
}
- (UILabel *)labname {
    if (!_labname) {
        _labname = [UILabel wg_labelWithFont:kFont_16 textColor:kColor_Black];
    }
    return _labname;
}
@end
