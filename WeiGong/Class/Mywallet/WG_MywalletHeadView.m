//
//  WG_MywalletHeadView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/4.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_MywalletHeadView.h"
#import "WG_MywalletAccount.h"

@interface WG_MywalletIncomeView : UIView
@property (nonatomic, copy) NSString *title;
/** 元（万元） */
@property (nonatomic, copy) NSString *unit;
/** 金额 */
@property (nonatomic, assign) double money;
@property (nonatomic, copy) NSString *desc;
@end
@implementation WG_MywalletIncomeView {
    UILabel *_labtitle;
    UILabel *_labmoney;
    UIButton *_descBtn;
}
- (instancetype)init {
    if (self = [super init]) {
        _labtitle = [UILabel wg_labelWithFont:kFont_16 textColor:kColor_Black ];
        [self addSubview:_labtitle];
        
        _labmoney = [UILabel wg_labelWithFont:kFont_17 textColor:kColor_Orange ];
        _labmoney.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_labmoney];
        
        _descBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _descBtn.titleLabel.font = kFont_16;
        _descBtn.userInteractionEnabled = NO;
        [_descBtn setTitleColor:kColor_White forState:UIControlStateNormal];
        [self addSubview:_descBtn];
        CGSize size = CGSizeMake(46, 23);
        [_descBtn setBackgroundImage:[[UIImage wg_imageWithColor:kColor_Orange size:size] wg_imageWithCornerRadius:3] forState:UIControlStateNormal];
        
        float titleX = 15;
        [_labtitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleX);
            make.centerY.mas_equalTo(self.mas_centerY).offset(-15);
        }];
        
        float moneyMaxW = kScreenWidth/2.0-size.width-titleX-4;
//        moneyMaxW = 80;
//        _labmoney.preferredMaxLayoutWidth = 80;
        [_labmoney mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_labtitle.mas_left);
            make.top.mas_equalTo(_labtitle.mas_bottom).offset(5);
            make.width.mas_lessThanOrEqualTo(moneyMaxW);
        }];
        
        [_descBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_labmoney.mas_right).offset(2);
            make.centerY.mas_equalTo(_labmoney.mas_centerY);
        }];
    }
    return self;
}

- (void)wg_setTitle {
    NSMutableString *muTitle = @"".mutableCopy;
    if (_title && _unit) {
        [muTitle appendFormat:@"%@(", _title];
        [muTitle appendFormat:@"%@)", _unit];
        _labtitle.text = muTitle;
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self wg_setTitle];
}
- (void)setUnit:(NSString *)unit {
    _unit = unit;
    [self wg_setTitle];
}
- (void)setMoney:(double)money {
    _money = money;
    _labmoney.text = [NSString stringWithFormat:@"%.2f", _money];
}
- (void)setDesc:(NSString *)desc {
    _desc = desc;
    [_descBtn setTitle:_desc forState:UIControlStateNormal];
}
@end

@interface WG_MywalletHeadView ()
@property (nonatomic, strong) WG_MywalletIncomeView *incomeView;
@property (nonatomic, strong) WG_MywalletIncomeView *balanceView;
@end
@implementation WG_MywalletHeadView
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = kColor_White;
        [self addSubview:self.incomeView];
        [self addSubview:self.balanceView];
//        self.incomeView.backgroundColor = [UIColor redColor];
        
        [self.incomeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(self.balanceView.mas_width);
            make.right.mas_equalTo(self.balanceView.mas_left);
        }];
        [self.balanceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.mas_equalTo(0);
        }];
        
        [self.incomeView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wg_tapView:)]];
        [self.balanceView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wg_tapView:)]];
        
    }
    return self;
}
- (void)wg_tapView:(UITapGestureRecognizer *)tap {
    if (tap.view == self.incomeView) {
        if ([self.delegate respondsToSelector:@selector(wg_tapDetail)]) {
            [self.delegate wg_tapDetail];
        }
    } else if (tap.view == self.balanceView) {
        if ([self.delegate respondsToSelector:@selector(wg_tapCash)]) {
            [self.delegate wg_tapCash];
        }
    }
}
- (void)setAccount:(WG_MywalletAccount *)account {
    _account = account;
    
    long maxUnit = (long)pow(10, 6);
    float incomeMoney = _account.total;
//    incomeMoney = pow(10, 10);
    if (incomeMoney / maxUnit >= 1) {
        incomeMoney /= pow(10, 4);
        self.incomeView.unit = @"万元";
    }
    self.incomeView.money = incomeMoney;
    
    float balanceMoney = _account.balance;
    if (balanceMoney / maxUnit >= 1) {
        balanceMoney /= pow(10, 4);
        self.balanceView.unit = @"万元";
    }
    self.balanceView.money = balanceMoney;
}

- (WG_MywalletIncomeView *)incomeView {
    if (!_incomeView) {
        _incomeView = [WG_MywalletIncomeView new];
        _incomeView.title = @"收入";
        _incomeView.unit = @"元";
        _incomeView.money = 0;
        _incomeView.desc = @"明细";
    }
    return _incomeView;
}
- (WG_MywalletIncomeView *)balanceView {
    if (!_balanceView) {
        _balanceView = [WG_MywalletIncomeView new];
        _balanceView.title = @"余额";
        _balanceView.unit = @"元";
        _balanceView.money = 0;
        _balanceView.desc = @"提现";
    }
    return _balanceView;
}
@end
