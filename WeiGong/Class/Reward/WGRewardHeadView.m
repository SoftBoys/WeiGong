//
//  WGRewardHeadView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/17.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGRewardHeadView.h"
#import "WGRewardShare.h"
#import "WGBaseCopyLabel.h"

@interface WGRewardHeadView ()
@property (nonatomic, strong) UILabel *labname;
@property (nonatomic, strong) UIImageView *numberBackView;
@property (nonatomic, strong) WGBaseCopyLabel *labnumber;
@property (nonatomic, strong) UILabel *labcontent;
@end

@implementation WGRewardHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kColor(250, 237, 228);
        [self addSubview:self.labname];
        [self addSubview:self.numberBackView];
        [self.numberBackView addSubview:self.labnumber];
        [self addSubview:self.labcontent];
        
        [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.centerX.mas_equalTo(0);
        }];
        
        [self.numberBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(40);
            make.centerX.mas_equalTo(self.labname);
            make.top.mas_equalTo(self.labname.mas_bottom).offset(5);
        }];
        
        [self.labnumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];

        CGFloat left = 15;
        [self.labcontent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(left);
            make.right.mas_equalTo(-left);
            make.top.mas_equalTo(self.labnumber.mas_bottom).offset(5);
        }];
        self.labcontent.preferredMaxLayoutWidth = kScreenWidth-left*2;
    }
    return self;
}

- (void)setReward:(WGReward *)reward {
    _reward = reward;
    if (_reward) {
//        self.labname.text = @"我的邀请码";
        self.labnumber.text = _reward.inviteCode;
        self.labcontent.text = _reward.inviteContent;
    }
}

#pragma mark - getter && setter 
- (UILabel *)labname {
    if (!_labname) {
        _labname = [UILabel wg_labelWithFont:kFont(15) textColor:kBlackColor];
        _labname.text = @"我的邀请码";
    }
    return _labname;
}
- (UIImageView *)numberBackView {
    if (!_numberBackView) {
        _numberBackView = [UIImageView new];
//        _numberBackView.backgroundColor = kRedColor;
        _numberBackView.image = [[UIImage imageNamed:@"reward_number"] wg_resizedImage];
    }
    return _numberBackView;
}

- (WGBaseCopyLabel *)labnumber {
    if (!_labnumber) {
        _labnumber = [WGBaseCopyLabel wg_labelWithFont:kBoldFont_PingFang(19) textColor:kWhiteColor];
        _labnumber.textAlignment = NSTextAlignmentCenter;
    }
    return _labnumber;
}
- (UILabel *)labcontent {
    if (!_labcontent) {
        _labcontent = [UILabel wg_labelWithFont:kFont(13) textColor:kColor_Title];
        _labcontent.textAlignment = NSTextAlignmentCenter;
        _labcontent.numberOfLines = 0;
    }
    return _labcontent;
}
@end
