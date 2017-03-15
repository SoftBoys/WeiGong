//
//  WG_JobPlatformCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/7.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_JobPlatformCell.h"
#import "WG_JobDetail.h"


@interface WG_JobBoxButton : UIButton

@end
@implementation WG_JobBoxButton

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    size.width += 6;
    size.height += 0;
    return size;
}
@end

@interface WG_JobPlatformCell ()
@property (nonatomic, strong) UILabel *labdate;
@property (nonatomic, strong) UILabel *labdatecontent;
@property (nonatomic, strong) UILabel *labtime;
@property (nonatomic, strong) UILabel *labtimecontent;
@property (nonatomic, strong) UILabel *labprotocol;
@property (nonatomic, strong) UILabel *labreward;
@property (nonatomic, strong) UIImageView *protocolView;
@property (nonatomic, strong) UIImageView *rewardView;
@property (nonatomic, strong) WG_JobBoxButton *platformButton;

@property (nonatomic, strong) NSMutableArray<WG_JobBoxButton *> *welfareButtons;
@end
@implementation WG_JobPlatformCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    self.welfareButtons = @[].mutableCopy;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.labdate];
    [self.contentView addSubview:self.labdatecontent];
    [self.contentView addSubview:self.labtime];
    [self.contentView addSubview:self.labtimecontent];
    [self.contentView addSubview:self.labprotocol];
    [self.contentView addSubview:self.labreward];
    [self.contentView addSubview:self.platformButton];
    [self.contentView addSubview:self.protocolView];
    [self.contentView addSubview:self.rewardView];
    
    [self.labdate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(8);
    }];
    [self.labdatecontent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labdate.mas_right).offset(5);
        make.top.mas_equalTo(self.labdate);
    }];
    [self.labtime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labdate);
        make.top.mas_equalTo(self.labdate.mas_bottom).offset(3);
    }];
    [self.labtimecontent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labtime.mas_right).offset(5);
        make.top.mas_equalTo(self.labtime);
    }];
    
    [self.protocolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labtime.mas_left);
        make.top.mas_equalTo(self.labprotocol.mas_top).offset(4.0);
        make.size.mas_equalTo(self.protocolView.image.size);
    }];
    [self.rewardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labtime.mas_left);
        make.top.mas_equalTo(self.labreward.mas_top).offset(4.0);
        make.size.mas_equalTo(self.rewardView.image.size);
    }];
    
    [self.labprotocol mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.protocolView.mas_right).offset(3);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.top.mas_equalTo(self.labtimecontent.mas_bottom).offset(3);
    }];
    
    [self.labreward mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.rewardView.mas_right).offset(3);
        make.right.mas_equalTo(self.labprotocol.mas_right);
        make.top.mas_equalTo(self.labprotocol.mas_bottom).offset(3);
    }];
    
    CGSize platformSize = CGSizeMake(60, 25);
    [self.platformButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.size.mas_equalTo(platformSize);
        make.top.mas_equalTo(self.labreward.mas_bottom).offset(3);
    }];
    
    // cornerRadius:3 borderColor:kColor_Blue borderWidth:kLineHeight] stretchableImageWithLeftCapWidth:5 topCapHeight:5
    UIImage *backImage = [[[UIImage wg_imageWithColor:[UIColor clearColor] size:CGSizeMake(10, 10)] wg_imageWithCornerRadius:3 borderWidth:kLineHeight borderColor:kColor_Blue] wg_resizedImage];
    [self.platformButton setBackgroundImage:backImage forState:UIControlStateNormal];
}
- (void)setDetail:(WG_JobDetail *)detail {
    _detail = detail;
    if (_detail) {

        self.labdatecontent.text = [NSString stringWithFormat:@"%@~%@", _detail.dateStart, _detail.dateStop];
        self.labtimecontent.text = _detail.jobTimeStr;
        
        self.labprotocol.text = _detail.protocolFlagContent;
        self.labreward.text = _detail.platformRewardContent;
        
//        _detail.protocolFlag = 1;
//        _detail.platformReward = 1;
//        _detail.platformPay = 0;
        if (_detail.welfare.length==0) {
            _detail.welfare = nil;
        }
//        _detail.welfare = @"包吃,包住,包住,";
        NSArray *array = [[_detail.welfare stringByReplacingOccurrencesOfString:@" " withString:@""] componentsSeparatedByString:@","];
        if (array.count > self.welfareButtons.count) {
            UIImage *backImage = [[[UIImage wg_imageWithColor:[UIColor clearColor] size:CGSizeMake(10, 10)] wg_imageWithCornerRadius:3 borderWidth:kLineHeight borderColor:kColor_Orange] wg_resizedImage];
            for (NSInteger i = self.welfareButtons.count; i < array.count; i++) {
                WG_JobBoxButton *button = [WG_JobBoxButton buttonWithType:UIButtonTypeCustom];
                [button setTitleColor:kColor_Orange forState:UIControlStateNormal];
                button.titleLabel.font = kFont_13;
                button.userInteractionEnabled = NO;
                [button setBackgroundImage:backImage forState:UIControlStateNormal];
                [self.contentView addSubview:button];
                [self.welfareButtons addObject:button];
            }
        }
        
        
        
        [self setNeedsUpdateConstraints];
        
    }
}
- (void)updateConstraints {
    
    self.labprotocol.hidden = _detail.protocolFlag == 0;
    self.labreward.hidden = _detail.platformReward == 0;
    self.platformButton.hidden = _detail.platformPay == 0;
    self.protocolView.hidden = self.labprotocol.hidden;
    self.rewardView.hidden = self.labreward.hidden;
    
    [self.labprotocol mas_updateConstraints:^(MASConstraintMaker *make) {
        
        if (_detail.protocolFlag == 0) {
            make.top.mas_equalTo(self.labtimecontent.mas_bottom).offset(3).priorityLow();
        } else {
            make.top.mas_equalTo(self.labtimecontent.mas_bottom).offset(3).priorityHigh();
        }
    }];
    
    [self.labreward mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.labprotocol.mas_bottom).offset(3).priorityLow();
        make.top.mas_equalTo(self.labtimecontent.mas_bottom).offset(3).priorityLow();
        
        if (_detail.platformReward == 1) {
            if (_detail.protocolFlag == 1) {
                make.top.mas_equalTo(self.labprotocol.mas_bottom).offset(3).priorityHigh();
            } else {
                make.top.mas_equalTo(self.labtimecontent.mas_bottom).offset(3).priorityHigh();
            }
        }
        
    }];
    
    [self.platformButton mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.labreward.mas_bottom).offset(3).priorityLow();
        make.top.mas_equalTo(self.labprotocol.mas_bottom).offset(3).priorityLow();
        make.top.mas_equalTo(self.labtimecontent.mas_bottom).offset(3).priorityLow();

        if (_detail.platformPay == 1) {
            if (_detail.platformReward == 1) {
                make.top.mas_equalTo(self.labreward.mas_bottom).offset(3).priorityHigh();
            } else {
                if (_detail.protocolFlag == 1) {
                    make.top.mas_equalTo(self.labprotocol.mas_bottom).offset(3).priorityHigh();
                } else {
                    make.top.mas_equalTo(self.labtimecontent.mas_bottom).offset(3).priorityHigh();
                }
            }
            
        }

    }];
    
    NSArray *array = [[_detail.welfare stringByReplacingOccurrencesOfString:@" " withString:@""] componentsSeparatedByString:@","];
    __block UIView *lastView = nil;
    
//    [self layoutIfNeeded];
//    WGLog(@"frame:%@", NSStringFromCGRect(self.platformButton.frame));
    
    [self.welfareButtons enumerateObjectsUsingBlock:^(WG_JobBoxButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < array.count) {
            obj.hidden = NO;
            [obj setTitle:array[idx] forState:UIControlStateNormal];
            
            CGSize size = CGSizeMake(55, 25);
//            float laseViewR = 15 + idx*(size.width+8);
//            __block float objX = 15 + idx*(size.width+8);
            if (lastView) {
                [obj mas_updateConstraints:^(MASConstraintMaker *make) {
//                    if (objX + size.width + 8 <= right2) {
//                        make.top.mas_equalTo(self.platformButton.mas_top);
//                    } else {
//                        objX = 15;
//                        make.top.mas_equalTo(lastView.mas_bottom).offset(3);
//                    }
                    make.top.mas_equalTo(self.platformButton.mas_top);
                    make.left.mas_equalTo(lastView.mas_right).offset(8);
//                    make.left.mas_equalTo(objX);
                    make.size.mas_equalTo(lastView);
                    make.right.mas_lessThanOrEqualTo(self.platformButton.mas_left).offset(-2);
                    
                }];
            } else {
                [obj mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.platformButton.mas_top);
                    make.left.mas_equalTo(self.contentView.mas_left).offset(15);
//                    make.left.mas_equalTo(objX);
                    make.size.mas_equalTo(size);
                }];
            }
            
            lastView = obj;
        } else {
            obj.hidden = YES;
            [obj mas_remakeConstraints:^(MASConstraintMaker *make) {
                
            }];
        }
    }];
    
    UIView *bottomView = self.labtimecontent;
    if (_detail.protocolFlag) {
        bottomView = self.labprotocol;
    }
    if (_detail.platformReward) {
        bottomView = self.labreward;
    }
    if (_detail.platformPay) {
        bottomView = self.platformButton;
    }
    
    if (lastView) {
        bottomView = lastView;
    }
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-8);
    }];
    [super updateConstraints];
}
#pragma mark - getter && setter
- (UILabel *)labdate {
    if (!_labdate) {
        _labdate = [UILabel wg_labelWithFont:kFont_15 textColor:kColor_Black_Sub];
        _labdate.text = @"日期";
    }
    return _labdate;
}
- (UILabel *)labdatecontent {
    if (!_labdatecontent) {
        _labdatecontent = [UILabel wg_labelWithFont:self.labdate.font textColor:kColor_Black];
    }
    return _labdatecontent;
}
- (UILabel *)labtime {
    if (!_labtime) {
        _labtime = [UILabel wg_labelWithFont:self.labdate.font textColor:self.labdate.textColor ];
        _labtime.text = @"时段";
    }
    return _labtime;
}
- (UILabel *)labtimecontent {
    if (!_labtimecontent) {
        _labtimecontent = [UILabel wg_labelWithFont:self.labdate.font textColor:self.labdatecontent.textColor ];
        _labtimecontent.numberOfLines = 0;
    }
    return _labtimecontent;
}
- (UILabel *)labprotocol {
    if (!_labprotocol) {
        _labprotocol = [UILabel wg_labelWithFont:self.labdate.font textColor:self.labdatecontent.textColor ];
        _labprotocol.numberOfLines = 0;
    }
    return _labprotocol;
}
- (UILabel *)labreward {
    if (!_labreward) {
        _labreward = [UILabel wg_labelWithFont:self.labdate.font textColor:self.labdatecontent.textColor ];
        _labreward.numberOfLines = 0;
    }
    return _labreward;
}
- (UIImageView *)protocolView {
    if (!_protocolView) {
        _protocolView = [UIImageView new];
        _protocolView.image = [UIImage imageNamed:@"vip"];
    }
    return _protocolView;
}
- (UIImageView *)rewardView {
    if (!_rewardView) {
        _rewardView = [UIImageView new];
        _rewardView.image = [UIImage imageNamed:@"reward"];
    }
    return _rewardView;
}
- (WG_JobBoxButton *)platformButton {
    if (!_platformButton) {
        _platformButton = [WG_JobBoxButton buttonWithType:UIButtonTypeCustom];
        [_platformButton setTitleColor:kColor_Blue forState:UIControlStateNormal];
        _platformButton.titleLabel.font = kFont_13;
        _platformButton.userInteractionEnabled = NO;
        [_platformButton setTitle:@"平台结算" forState:UIControlStateNormal];
    }
    return _platformButton;
}
@end
