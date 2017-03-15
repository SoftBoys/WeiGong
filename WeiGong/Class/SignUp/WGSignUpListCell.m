//
//  WGSignUpListCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/26.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGSignUpListCell.h"
#import "WGSignUpDetail.h"

@interface WGSignUpListCell ()
@property (nonatomic, strong) UILabel *labname;
@property (nonatomic, strong) UILabel *labtime;
@property (nonatomic, strong) UILabel *labaddress;
@property (nonatomic, strong) UILabel *labsignup;
@property (nonatomic, strong) UILabel *labsigndown;
@end
@implementation WGSignUpListCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.labname = [UILabel wg_labelWithFont:kFont(16) textColor:kColor_Black];
    self.labname.numberOfLines = 0;
    [self.contentView addSubview:self.labname];
    
    self.labtime = [UILabel wg_labelWithFont:kFont(14) textColor:kColor_Black_Sub];
    [self.contentView addSubview:self.labtime];
    
    self.labaddress = [UILabel wg_labelWithFont:self.labtime.font textColor:self.labtime.textColor];
    [self.contentView addSubview:self.labaddress];
    
    self.labsignup = [UILabel wg_labelWithFont:self.labtime.font textColor:self.labtime.textColor];
    [self.contentView addSubview:self.labsignup];
    
    self.labsigndown = [UILabel wg_labelWithFont:self.labtime.font textColor:self.labtime.textColor];
    [self.contentView addSubview:self.labsigndown];
    
    [self makeSubviewsConstraints];
    
}
- (void)makeSubviewsConstraints {
    
    CGFloat nameX = 12, nameY = 12;
    
    [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameX);
        make.top.mas_equalTo(nameY);
        make.right.mas_equalTo(-nameX);
        
        //        make.height.mas_equalTo(nameSize.height);
    }];
    CGFloat spaceY = 0;
    [self.labtime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labname);
        make.top.mas_equalTo(self.labname.mas_bottom).offset(spaceY);
    }];
    
    [self.labaddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labtime);
        make.top.mas_equalTo(self.labtime.mas_bottom);
    }];
    
    [self.labsignup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labtime);
        make.top.mas_equalTo(self.labaddress.mas_bottom);
        
    }];
    
    [self.labsigndown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labtime);
        make.top.mas_equalTo(self.labsignup.mas_bottom);
        make.bottom.mas_equalTo(-nameY);
    }];
    
    CGFloat nameMaxW = kScreenWidth - nameX*2;
    self.labname.preferredMaxLayoutWidth = nameMaxW;
    
    
}


- (void)setItem:(WGSignUpListItem *)item {
    _item = item;
    if (_item) {
        
        self.labname.text = _item.jobName;
        NSString *time = [NSString stringWithFormat:@"%@-%@", _item.startTime, _item.stopTime];
        self.labtime.text = kStringAppend(@"时间：", time);
        NSString *address = _item.address ?: kEmptyStr;
        self.labaddress.text = kStringAppend(@"地点：", address);
        NSMutableString *signup = @"签到：".mutableCopy;
        if (_item.startDate) {
            [signup appendFormat:@"%@   ", _item.startDate];
        }
        [signup appendFormat:@"%@米", @(_item.startDistance)];
        self.labsignup.text = nil;
        if (_item.startFlag == 1) {
            self.labsignup.text = signup;
        }
        
        NSMutableString *signdown = @"签退：".mutableCopy;
        if (_item.stopDate) {
            [signdown appendFormat:@"%@   ",_item.stopDate];
        }
        [signdown appendFormat:@"%@米", @(_item.stopDistance)];

        self.labsigndown.text = nil;
        if (_item.stopFlag == 1) {
            self.labsigndown.text = signdown;
        }
        
        self.labsignup.hidden = _item.startFlag != 1;
        self.labsigndown.hidden = _item.stopFlag != 1;
        
//        [self setNeedsUpdateConstraints];
//        [self updateConstraintsIfNeeded];
    }
}

- (void)updateConstraints {
    [super updateConstraints];
//    for (UIView *subview in self.contentView.subviews) {
//        if ([subview isKindOfClass:[UILabel class]]) {
//            [subview mas_updateConstraints:^(MASConstraintMaker *make) {
//                
//            }];
//        }
//    }
}

@end
