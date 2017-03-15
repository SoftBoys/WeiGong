//
//  WGWorkOrderDetailHeadCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/8.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGWorkOrderDetailHeadCell.h"

@interface WGWorkOrderDetailHeadCell ()
@property (nonatomic, strong) UILabel *labname;
@end
@implementation WGWorkOrderDetailHeadCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = kClearColor;
    self.contentView.backgroundColor = kClearColor;
    UIView *backView = [UIView new];
    backView.backgroundColor = kWhiteColor;
    [self insertSubview:backView belowSubview:self.contentView];
    
    [self.contentView addSubview:self.labname];
    
    CGFloat left = 12;
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, left, 0, left));
    }];
    
    CGFloat nameX = 24;
    
    [self.labname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameX);
        make.right.mas_equalTo(-nameX);
        make.top.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
}

- (UILabel *)labname {
    if (!_labname) {
        _labname = [UILabel wg_labelWithFont:kFont(17) textColor:kColor_Blue];
        _labname.text = @"订单明细";
    }
    return _labname;
}
@end
