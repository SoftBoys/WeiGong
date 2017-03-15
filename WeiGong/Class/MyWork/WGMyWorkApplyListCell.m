//
//  WGMyWorkApplyListCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/24.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGMyWorkApplyListCell.h"
#import "WGMyWorkApplyListItem.h"

#import "WGBaseNoHightButton.h"

@interface WGMyWorkApplyListCell ()
@property (nonatomic, strong) UILabel *labname;
@property (nonatomic, strong) UILabel *labdate;
@property (nonatomic, strong) WGBaseNoHightButton *button_recruit; // 招聘
@property (nonatomic, strong) WGBaseNoHightButton *button_apply; // 应聘
@property (nonatomic, strong) WGBaseNoHightButton *button_admit; // 录取
@end
@implementation WGMyWorkApplyListCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    [self.contentView addSubview:self.labname];
    [self.contentView addSubview:self.labdate];
    
    self.button_recruit = [self buttonWithTitle:nil];
    [self.contentView addSubview:self.button_recruit];
    
    self.button_apply = [self buttonWithTitle:nil];
    [self.contentView addSubview:self.button_apply];
    
    self.button_admit = [self buttonWithTitle:nil];
    [self.contentView addSubview:self.button_admit];
    
    CGFloat nameX = 10, nameY = 10;
    [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameX);
        make.right.mas_equalTo(-nameX);
        make.top.mas_equalTo(nameY);
    }];
//    self.labname.preferredMaxLayoutWidth = kScreenWidth-nameX*2;
    
    CGFloat space = 8, buttonH = 18;
    [self.button_recruit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labname.mas_left).offset(0);
        make.top.mas_equalTo(self.labname.mas_bottom).offset(nameY);
        make.height.mas_equalTo(buttonH);
        make.bottom.mas_equalTo(-nameY);
    }];
    
    [self.button_apply mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.button_recruit);
        make.height.mas_equalTo(@[self.button_recruit, self.button_admit]);
        make.left.mas_equalTo(self.button_recruit.mas_right).offset(space);
    }];
    
    [self.button_admit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.button_recruit);
        make.left.mas_equalTo(self.button_apply.mas_right).offset(space);
    }];
    
    [self.labdate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.arrowView.mas_left).offset(-10);
        make.bottom.mas_equalTo(-nameY);
    }];
}

- (WGBaseNoHightButton *)buttonWithTitle:(NSString *)title {
    WGBaseNoHightButton *button = [WGBaseNoHightButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = kFont(10);
    button.insets = UIEdgeInsetsMake(0, 5, 0, 5);
    [button setTitleColor:kWhiteColor forState:UIControlStateNormal];
//    button.backgroundColor = kColor_Black_Sub;
    UIImage *backImage = [[[UIImage wg_imageWithColor:kColor_Gray_Sub size:CGSizeMake(15, 14)] wg_imageWithCornerRadius:4] wg_resizedImage];
    [button setBackgroundImage:backImage forState:UIControlStateNormal];
    return button;
}

- (void)setItem:(WGMyWorkApplyListItem *)item {
    _item = item;
    if (_item) {
//        _item.jobName = @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试";
        self.labname.text = _item.jobName;
        self.labdate.text = _item.updateDate;
        
        NSString *recruitText = kStringAppend(@"招 ", kIntToStr(_item.rNum));
        if (_item.rNum == 999) {
            recruitText = kStringAppend(@"招 ", @"不限");
        }
        NSString *applyText = kStringAppend(@"应 ", kIntToStr(_item.pNum));
        NSString *admitText = kStringAppend(@"录 ", kIntToStr(_item.sNum));
        [self.button_recruit setTitle:recruitText forState:UIControlStateNormal];
        [self.button_apply setTitle:applyText forState:UIControlStateNormal];
        [self.button_admit setTitle:admitText forState:UIControlStateNormal];
//        self.textLabel.text = _item.jobName;
    }
}
#pragma mark - getter && setter 
- (UILabel *)labname {
    if (!_labname) {
        _labname = [UILabel wg_labelWithFont:kFont(15) textColor:kColor_Black];
    }
    return _labname;
}
- (UILabel *)labdate {
    if (!_labdate) {
        _labdate = [UILabel wg_labelWithFont:kFont(12) textColor:kColor_Black_Sub];
    }
    return _labdate;
}

@end
