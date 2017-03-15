//
//  WGSignUpOrDownCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/26.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGSignUpOrDownCell.h"
#import "WGSignUpDetail.h"
#import "WGBaseNoHightButton.h"

@interface WGSignUpOrDownCell ()
@property (nonatomic, strong) UILabel *labdistance;
@property (nonatomic, strong) WGBaseNoHightButton *button_sign;
@end
@implementation WGSignUpOrDownCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.labdistance];
    [self.contentView addSubview:self.button_sign];
    // [UIColor wg_colorWithHexString:@"#f4f4f4"]
    self.backgroundColor = kColor_Gray_Back;
    
    CGFloat nameX = 12;
    [self.labdistance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameX);
        make.centerY.mas_equalTo(0);
    }];
    
    CGFloat spaceY = 5;
    [self.button_sign mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-nameX);
        make.top.mas_equalTo(spaceY);
        make.bottom.mas_equalTo(-spaceY);
        make.height.mas_equalTo(30);
//        make.width.mas_equalTo(80);
    }];
    
}

- (void)setItem:(WGSignUpListItem *)item {
    _item = item;
    if (_item) {
        
        self.labdistance.text = [NSString stringWithFormat:@"距工作地：%@米", @(_item.distance)];
        
        NSString *title = _item.startFlag != 1 ? @"立即签到":@"立即签退";
        [self.button_sign setTitle:title forState:UIControlStateNormal];
    }
}
#pragma mark - getter && setter 
- (UILabel *)labdistance {
    if (!_labdistance) {
        _labdistance = [UILabel wg_labelWithFont:kFont(14) textColor:kColor_Black_Sub];
    }
    return _labdistance;
}
- (WGBaseNoHightButton *)button_sign {
    if (!_button_sign) {
        WGBaseNoHightButton *button = [WGBaseNoHightButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = kFont(15);
        CGFloat left = 5;
        button.insets = UIEdgeInsetsMake(0, left, 0, left);
        [button setTitleColor:kColor_Orange forState:UIControlStateNormal];
        UIImage *imageBack = [[[UIImage wg_imageWithColor:kWhiteColor size:CGSizeMake(10, 15)] wg_imageWithCornerRadius:4 borderWidth:kLineHeight*2 borderColor:kColor_Orange] wg_resizedImage];
        [button setBackgroundImage:imageBack forState:UIControlStateNormal];
        __weak typeof(self) weakself = self;
        [button setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            if ([strongself.delegate respondsToSelector:@selector(signUpOrDownWithItem:)]) {
                [strongself.delegate signUpOrDownWithItem:strongself.item];
            };
            
        }];
        _button_sign = button;
    }
    return _button_sign;
}
@end
