//
//  WGWorkOrderDetailCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/24.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGWorkOrderDetailCell.h"
#import "WGWorkOrderDetail.h"
#import "WGBaseLabel.h"

NSString *kName = @"职位名称：", *kOrderDate = @"订单日期：", *kState = @"订单状态：", *kPrice = @"订单金额：", *kDesc = @"订单备注：", *kPayDate = @"支付日期", *kPayDesc = @"支付信息：";
@interface WGWorkOrderDetailCell ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) WGBaseLabel *labName_left;
@property (nonatomic, strong) WGBaseLabel *labOrderDate_left;
@property (nonatomic, strong) WGBaseLabel *labState_left;
@property (nonatomic, strong) WGBaseLabel *labPrice_left;
@property (nonatomic, strong) WGBaseLabel *labDesc_left;
@property (nonatomic, strong) WGBaseLabel *labPayDate_left;
@property (nonatomic, strong) WGBaseLabel *labPayDesc_left;

@property (nonatomic, strong) WGBaseLabel *labName;
@property (nonatomic, strong) WGBaseLabel *labOrderDate;
@property (nonatomic, strong) WGBaseLabel *labState;
@property (nonatomic, strong) WGBaseLabel *labPrice;
@property (nonatomic, strong) WGBaseLabel *labDesc;
@property (nonatomic, strong) WGBaseLabel *labPayDate;
@property (nonatomic, strong) WGBaseLabel *labPayDesc;
@end

@implementation WGWorkOrderDetailCell
- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    self.backgroundColor = kClearColor;
    self.contentView.backgroundColor = kClearColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.backView];
    
    self.labName_left = [self labelWithText:kName textColor:kColor_Black_Sub];
    [self.backView addSubview:self.labName_left];
    
    self.labOrderDate_left = [self labelWithText:kOrderDate textColor:self.labName_left.textColor];
    [self.backView addSubview:self.labOrderDate_left];
    
    self.labState_left = [self labelWithText:kState textColor:self.labName_left.textColor];
    [self.backView addSubview:self.labState_left];
    
    self.labPrice_left = [self labelWithText:kPrice textColor:self.labName_left.textColor];
    [self.backView addSubview:self.labPrice_left];
    
    self.labDesc_left = [self labelWithText:kDesc textColor:self.labName_left.textColor];
    [self.backView addSubview:self.labDesc_left];
    
    self.labPayDate_left = [self labelWithText:kPayDate textColor:self.labName_left.textColor];
    [self.backView addSubview:self.labPayDate_left];
    
    self.labPayDesc_left = [self labelWithText:kPayDesc textColor:self.labName_left.textColor];
    [self.backView addSubview:self.labPayDesc_left];
    
    self.labName = [self labelWithText:nil textColor:kColor_Black];
    [self.backView addSubview:self.labName];
    
    self.labOrderDate = [self labelWithText:nil textColor:self.labName.textColor];
    [self.backView addSubview:self.labOrderDate];
    
    self.labState = [self labelWithText:nil textColor:self.labName.textColor];
    [self.backView addSubview:self.labState];
    
    self.labPrice = [self labelWithText:nil textColor:self.labName.textColor];
    [self.backView addSubview:self.labPrice];
    
    self.labDesc = [self labelWithText:nil textColor:self.labName.textColor];
    [self.backView addSubview:self.labDesc];
    
    self.labPayDate = [self labelWithText:nil textColor:self.labName.textColor];
    [self.backView addSubview:self.labPayDate];
    
    self.labPayDesc = [self labelWithText:nil textColor:self.labName.textColor];
    [self.backView addSubview:self.labPayDesc];
    
    [self makeSubviewsConstraints];
    
}
- (void)makeSubviewsConstraints {
    CGFloat left = 12;
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, left, 0, left));
//        make.height.mas_equalTo(200);
    }];
    CGFloat nameX = 12, nameY = 15;
    
    [self.labName_left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameX);
        make.top.mas_equalTo(nameY);
//        make.height.mas_equalTo(nameSize.height);
    }];
    
    CGSize nameSize = [self.labName_left systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    [self.labName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labName_left.mas_right);
        make.top.mas_equalTo(self.labName_left.mas_top);
    }];
    
    [self.labOrderDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labName.mas_left);
        make.top.mas_equalTo(self.labName.mas_bottom);
    }];
    
    [self.labState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labName.mas_left);
        make.top.mas_equalTo(self.labOrderDate.mas_bottom);
    }];
    
    [self.labPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labName.mas_left);
        make.top.mas_equalTo(self.labState.mas_bottom);
    }];
    
    [self.labDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labName.mas_left);
        make.top.mas_equalTo(self.labPrice.mas_bottom);
    }];
    
    [self.labPayDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labName.mas_left);
        make.top.mas_equalTo(self.labDesc.mas_bottom);
    }];
    
    [self.labPayDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labName.mas_left);
        make.top.mas_equalTo(self.labPayDate.mas_bottom);
    }];
    
    
    [self.labOrderDate_left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@[self.labName_left,self.labState_left,self.labPrice_left,self.labDesc_left,self.labPayDate_left,self.labPayDesc_left]);
        make.top.mas_equalTo(self.labOrderDate.mas_top);
    }];
    
    [self.labState_left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.labState.mas_top);
    }];
    
    [self.labPrice_left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.labPrice.mas_top);
    }];
    
    [self.labDesc_left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.labDesc.mas_top);
    }];
    
    [self.labPayDate_left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.labPayDate.mas_top);
    }];
    
    [self.labPayDesc_left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.labPayDesc.mas_top);
    }];
   
    
    
    CGFloat nameW = nameSize.width;
    CGFloat maxW = kScreenWidth-nameW-(left+nameX)*2;
    self.labName.preferredMaxLayoutWidth = maxW;
    self.labOrderDate.preferredMaxLayoutWidth = maxW;
    self.labState.preferredMaxLayoutWidth = maxW;
    self.labPrice.preferredMaxLayoutWidth = maxW;
    self.labDesc.preferredMaxLayoutWidth = maxW;
    self.labPayDate.preferredMaxLayoutWidth = maxW;
    self.labPayDesc.preferredMaxLayoutWidth = maxW;
    
}

- (WGBaseLabel *)labelWithText:(NSString *)text textColor:(UIColor *)textColor {
    WGBaseLabel *label = [WGBaseLabel wg_labelWithFont:kFont(14) textColor:textColor];
    label.text = text;
    CGFloat top = 2, left = 0;
    label.insets = UIEdgeInsetsMake(top, left, top, left);
    label.numberOfLines = 0;
//    label.backgroundColor = kRedColor;
    return label;
}

- (void)setOrderDetail:(WGWorkOrderDetail *)orderDetail {
    _orderDetail = orderDetail;
    if (_orderDetail) {
//        _orderDetail.jobName = @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试";
        
        self.labName.text = _orderDetail.jobName;
        self.labOrderDate.text = _orderDetail.createDate;
        self.labState.text = _orderDetail.orderFlagName;
        self.labPrice.text = kStringAppend(_orderDetail.realMoney, @"元");
        self.labDesc.text = _orderDetail.orderDesc;
        self.labPayDate.text = _orderDetail.paymentDate;
        
        NSMutableString *payDesc = @"".mutableCopy;
        if (_orderDetail.accountTypeName) {
            [payDesc appendFormat:@"%@\n", _orderDetail.accountTypeName];
        }
        if (_orderDetail.accountName) {
            [payDesc appendFormat:@"姓名：%@\n", _orderDetail.accountName];
        }
        if (_orderDetail.accountId) {
            [payDesc appendFormat:@"账号：%@\n", _orderDetail.accountId];
        }
        if (_orderDetail.accountBank) {
            [payDesc appendFormat:@"银行：%@\n", _orderDetail.accountBank];
        }
        
        if (payDesc.length > 1) {
            self.labPayDesc.text = [payDesc substringToIndex:payDesc.length-1];
        }
        
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
        
    }
}
- (void)updateConstraints {
    [super updateConstraints];
    
    UIView *lastView = nil;
    
    if (self.labName.text.length == 0) {
        
        [self.labName mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    } else {
        lastView = self.labName;
    }
    
    if (self.labOrderDate.text.length == 0) {
        [self.labOrderDate mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    } else {
        lastView = self.labOrderDate;
    }
    
    if (self.labState.text.length == 0) {
        [self.labState mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    } else {
        lastView = self.labState;
    }
    
    if (self.labPrice.text.length == 0) {
        [self.labPrice mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    } else {
        lastView = self.labPrice;
    }
    
    if (self.labDesc.text.length == 0) {
        [self.labDesc mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    } else {
        lastView = self.labDesc;
    }
    
    if (self.labPayDate.text.length == 0) {
        [self.labPayDate mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    } else {
        lastView = self.labPayDate;
    }
    
    if (self.labPayDesc.text.length == 0) {
        [self.labPayDesc mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    } else {
        lastView = self.labPayDesc;
    }
    
    if (lastView) {
        [lastView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-10);
        }];
    }
    
    self.labName.hidden = self.labName.text.length == 0;
    self.labName_left.hidden = self.labName.hidden;
    
    self.labOrderDate.hidden = self.labOrderDate.text.length == 0;
    self.labOrderDate_left.hidden = self.labOrderDate.hidden;
    
    self.labState.hidden = self.labState.text.length == 0;
    self.labState_left.hidden = self.labState.hidden;
    
    self.labPrice.hidden = self.labPrice.text.length == 0;
    self.labPrice_left.hidden = self.labPrice.hidden;
    
    self.labDesc.hidden = self.labDesc.text.length == 0;
    self.labDesc_left.hidden = self.labDesc.hidden;
    
    self.labPayDate.hidden = self.labPayDate.text.length == 0;
    self.labPayDate_left.hidden = self.labPayDate.hidden;
    
    self.labPayDesc.hidden = self.labPayDesc.text.length == 0;
    self.labPayDesc_left.hidden = self.labPayDesc.hidden;
    
}
#pragma mark - getter && setter 
- (UIView *)backView {
    if (!_backView) {
        _backView = [UIView new];
        _backView.backgroundColor = kWhiteColor;
    }
    return _backView;
}
@end
