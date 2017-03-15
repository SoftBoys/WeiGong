//
//  WG_MineTranslucentView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/18.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_MineTranslucentView.h"
#import "WG_MineUser.h"
#import "WG_VerticalIconButton.h"
#import "NSAttributedString+Addition.h"

@interface WG_MineTranslucentLabel : UILabel

- (instancetype)initWithTitle:(NSString *)title;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 数量 */
@property (nonatomic, assign) NSUInteger count;

@end
@implementation WG_MineTranslucentLabel
- (instancetype)initWithTitle:(NSString *)title {
    if (self = [super init]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.numberOfLines = 0;
        self.textColor = kColor_Black;
        self.font = kFont_16;
        self.title = title;
        self.userInteractionEnabled = YES;
    }
    return self;
}
- (void)setTitle:(NSString *)title {
    _title = title;
    [self setContent];
}
- (void)setCount:(NSUInteger)count {
    _count = count;
    [self setContent];
}
- (NSString *)getContent {
    NSMutableString *string = [NSMutableString string];
    if (self.title) {
        [string appendString:self.title];
        [string appendString:@"\n"];
    }
    [string appendString:[NSString stringWithFormat:@"%zd", self.count]];
    return string;
}
- (void)setContent {
    NSString *text = [self getContent];
//    WGLog(@"text:%@",text);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:NSFontAttributeName value:kFont_13 range:NSMakeRange(0, self.title.length)];
//    NSRange range = [text rangeOfString:@"\n"];
    NSString *count = [NSString stringWithFormat:@"%zd", self.count];
    [attStr addAttribute:NSFontAttributeName value:kFont_12 range:NSMakeRange(text.length - count.length, count.length)];
//    WGLog(@"text:%zd ",text.length,);
    self.attributedText = attStr;
}
@end

@interface WG_MineTranslucentView ()
//@property (nonatomic, strong) WG_MineTranslucentLabel *labcollection;
//@property (nonatomic, strong) WG_MineTranslucentLabel *labcredit;
//@property (nonatomic, strong) WG_MineTranslucentLabel *labreject;

@property (nonatomic, strong) WG_VerticalIconButton *btn_collection;
@property (nonatomic, strong) WG_VerticalIconButton *btn_credit;
@property (nonatomic, strong) WG_VerticalIconButton *btn_reject;

@end
@implementation WG_MineTranslucentView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.25];
        self.backgroundColor = kWhiteColor;
        [self addSubview:self.btn_collection];
        [self addSubview:self.btn_credit];
        [self addSubview:self.btn_reject];
        _collectButton = self.btn_collection;
        _creditButton = self.btn_credit;
        _rejectButton = self.btn_reject;
        
        float labW = kScreenWidth/3.0;
        [self.btn_collection mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self);
            make.width.mas_equalTo(labW);
            make.top.bottom.mas_equalTo(0);
        }];
        
        [self.btn_credit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.width.mas_equalTo(self.btn_collection);
            make.left.mas_equalTo(self.btn_collection.mas_right);
            make.top.bottom.mas_equalTo(0);
        }];
        
        [self.btn_reject mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.width.mas_equalTo(self.btn_collection);
            make.left.mas_equalTo(self.btn_credit.mas_right);
            make.top.bottom.mas_equalTo(0);
        }];
        
//        self.labcollection.count = 100;
//        self.labcredit.count = 10;
//        self.labreject.count = 1;
    }
    return self;
}

- (void)setUser:(WG_MineUser *)user {
    _user = user;
    if (_user) {
        NSString *collection = @"收藏 ", *credit = @"信誉 ", *reject = @"放鸽子 ";
        NSString *collectionText = kStringAppend(collection, kIntToStr(_user.collectCount));
        NSString *creditText = kStringAppend(credit, kIntToStr(_user.creditCount));
        NSString *rejectText = kStringAppend(reject, kIntToStr(_user.rejectCount));
        
//        [self.btn_collection setTitle:collectionText forState:UIControlStateNormal];
        
        NSAttributedString *attcollection = [self attStringWithString:collectionText keyWord:collection];
        [self.btn_collection setAttributedTitle:attcollection forState:UIControlStateNormal];
        
        NSAttributedString *attcredit = [self attStringWithString:creditText keyWord:credit];
        [self.btn_credit setAttributedTitle:attcredit forState:UIControlStateNormal];
        
        NSAttributedString *attreject = [self attStringWithString:rejectText keyWord:reject];
        [self.btn_reject setAttributedTitle:attreject forState:UIControlStateNormal];
    }
}
- (NSAttributedString *)attStringWithString:(NSString *)string keyWord:(NSString *)keyWord {
    NSAttributedString *attString = [NSAttributedString wg_attStringWithString:string keyWord:keyWord highlightFont:kFont(13) font:kFont(12) highlightColor:kBlackColor textColor:kColor_OrangeRed lineSpace:2.0 alignment:NSTextAlignmentCenter searhType:kAttributedSearchTypeSingle];
    return attString;
}

- (WG_VerticalIconButton *)buttonWithIcon:(UIImage *)icon {
    WG_VerticalIconButton *button = [WG_VerticalIconButton buttonWithType:UIButtonTypeCustom];
    [button setImage:icon forState:UIControlStateNormal];
    button.space = 3;
//    button.backgroundColor = kRedColor;
//    button.titleLabel.textAlignment = NSTextAlignmentCenter;
//    button.titleLabel.backgroundColor = kRedColor;
//    button.contentMode = UIViewContentModeCenter;
    return button;
}
#pragma mark - getter && setter
- (WG_VerticalIconButton *)btn_collection {
    if (!_btn_collection) {
//        _btn_collection = [[WG_MineTranslucentLabel alloc] initWithTitle:@"收藏"];
        _btn_collection = [self buttonWithIcon:[UIImage imageNamed:@"mine_collect"]];
    }
    return _btn_collection;
}
- (WG_VerticalIconButton *)btn_credit {
    if (!_btn_credit) {
//        _labcredit = [[WG_MineTranslucentLabel alloc] initWithTitle:@"信誉"];
        _btn_credit = [self buttonWithIcon:[UIImage imageNamed:@"mine_xinyu"]];
    }
    return _btn_credit;
}
- (WG_VerticalIconButton *)btn_reject {
    if (!_btn_reject) {
//        _labreject = [[WG_MineTranslucentLabel alloc] initWithTitle:@"放鸽子"];
        _btn_reject = [self buttonWithIcon:[UIImage imageNamed:@"mine_fangegzi"]];
        
    }
    return _btn_reject;
}
@end
