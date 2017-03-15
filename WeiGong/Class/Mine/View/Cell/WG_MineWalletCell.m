//
//  WG_MineWalletCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/21.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_MineWalletCell.h"

@interface WG_MineWalletCell ()
@property (nonatomic, strong) UIButton *walletBtn;
@property (nonatomic, strong) UIButton *rewardsBtn;
@end
@implementation WG_MineWalletCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    self.walletBtn = [self buttonWithTitle:@"我的钱包" image:[UIImage imageNamed:@"mine_wallet"]];
    [self.contentView addSubview:self.walletBtn];
    
    self.rewardsBtn = [self buttonWithTitle:@"推荐奖励" image:[UIImage imageNamed:@"mine_rewards"]];
    [self.contentView addSubview:self.rewardsBtn];
    
    self.contentView.backgroundColor = kColor_Line;
    
    float walletW = (kScreenWidth - kLineHeight)/2.0;
    [self.walletBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(walletW);
        make.height.mas_equalTo(45);
    }];
    
    [self.rewardsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(0);
        make.width.mas_equalTo(walletW);
    }];
}

- (void)wg_buttonClick:(UIButton *)button {
    if (button == self.walletBtn) {
        if ([self.delegate respondsToSelector:@selector(wg_tapWallet)]) {
            [self.delegate wg_tapWallet];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(wg_tapRewards)]) {
            [self.delegate wg_tapRewards];
        }
    }
}
- (UIButton *)buttonWithTitle:(NSString *)title image:(UIImage *)image {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = kFont_15;
    button.backgroundColor = [UIColor whiteColor];
    [button setTitleColor:kColor_Black_Sub forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(wg_buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    float imageOffsetX = 4;
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -imageOffsetX, 0, imageOffsetX);
    return button;
}
@end
