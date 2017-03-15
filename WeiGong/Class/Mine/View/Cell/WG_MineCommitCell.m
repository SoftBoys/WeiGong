//
//  WG_MineCommitCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/21.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_MineCommitCell.h"
#import "WG_MineUser.h"

@interface WG_MineCountLabel : UILabel

@end

@implementation WG_MineCountLabel

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    
    size.height += 0.5;
    size.width = MAX(size.width, size.height) + 2.5 * (size.width/size.height);
    
    self.layer.cornerRadius = size.height/2;
    return size;
}

@end

@interface WG_MineCommitButton : UIButton
@property (nonatomic, strong) WG_MineCountLabel *labcount;
@property (nonatomic, assign) NSUInteger count;
@end
@implementation WG_MineCommitButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.labcount];
        
        [self.labcount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self).centerOffset(CGPointMake(11.5, -13));
//            make.width.mas_equalTo(15);
//            make.height.mas_equalTo(15);
        }];
        self.labcount.clipsToBounds = YES;
        
        self.titleLabel.font = kFont_12;
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:kColor_Black_Sub forState:UIControlStateNormal];
        self.count = 0;
    }
    return self;
}
- (void)setCount:(NSUInteger)count {
    
    self.labcount.text = [NSString stringWithFormat:@"%zd", count];
    self.labcount.hidden = count <= 0;
}
- (WG_MineCountLabel *)labcount {
    if (!_labcount) {
        _labcount = [WG_MineCountLabel wg_labelWithFont:kFont_12 textColor:kColor_White ];
        _labcount.backgroundColor = kColor(251, 0, 10);
        _labcount.textAlignment = NSTextAlignmentCenter;
    }
    return _labcount;
}
//- (CGSize)intrinsicContentSize {
//    CGSize size = [super intrinsicContentSize];
//    size.width += 10;
//    return size;
//}
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGSize size = self.currentImage.size;
    float imageY = CGRectGetHeight(self.frame)/2.0 - size.height + 2;
    float imageX = (CGRectGetWidth(self.frame)-size.width)/2.0;
    return (CGRect){imageX, imageY, size};
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGRect imageF = [self imageRectForContentRect:CGRectZero];
    float titleX = 0;
    float titleY = CGRectGetMaxY(imageF);
//    UILabel
    float titleW = CGRectGetWidth(self.frame);
    float titleH = CGRectGetHeight(self.frame)-titleY;
    titleH = [kFont_12 lineHeight];
    return (CGRect){titleX, titleY, titleW, titleH};
}

@end

@interface WG_MineCommitCell ()
@property (nonatomic, strong) WG_MineCommitButton *unSureBtn;
@property (nonatomic, strong) WG_MineCommitButton *unCommiteBtn;
@property (nonatomic, strong) WG_MineCommitButton *commitBtn;
@end
@implementation WG_MineCommitCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    
    self.unSureBtn = [self buttonWithImage:[UIImage imageNamed:@"mine_unsure"] title:@"待确认"];
    [self.contentView addSubview:self.unSureBtn];
    
    self.unCommiteBtn = [self buttonWithImage:[UIImage imageNamed:@"mine_unapprise"] title:@"待评价"];
    [self.contentView addSubview:self.unCommiteBtn];
    
    self.commitBtn = [self buttonWithImage:[UIImage imageNamed:@"mine_apprise"] title:@"已评价"];
    [self.contentView addSubview:self.commitBtn];
    
    
    [self makeSubConstraints];
    
}
- (void)makeSubConstraints {
    [self.unSureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.height.mas_equalTo(50);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kScreenWidth/3.0);
    }];
    
    [self.unCommiteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(self.unSureBtn.mas_right);
        make.width.mas_equalTo(self.unSureBtn);
    }];
    
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(self.unCommiteBtn.mas_right);
        make.width.mas_equalTo(self.unSureBtn);
    }];
}
- (void)wg_buttonClick:(WG_MineCommitButton *)button {
    if (button == self.unSureBtn) {
        if ([self.delegate respondsToSelector:@selector(wg_unSureTap)]) {
            [self.delegate wg_unSureTap];
        }
    } else if (button == self.unCommiteBtn) {
        if ([self.delegate respondsToSelector:@selector(wg_unCommitTap)]) {
            [self.delegate wg_unCommitTap];
        }
    } else if (button == self.commitBtn) {
        if ([self.delegate respondsToSelector:@selector(wg_commitTap)]) {
            [self.delegate wg_commitTap];
        }
    }
}
- (WG_MineCommitButton *)buttonWithImage:(UIImage *)image title:(NSString *)title {
    WG_MineCommitButton *button = [WG_MineCommitButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(wg_buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)setUser:(WG_MineUser *)user {
    _user = user;
    
    self.unSureBtn.count = _user.unSureCount;
    self.unCommiteBtn.count = _user.unCommitCount;
    self.commitBtn.count = _user.commitCount;
    self.commitBtn.count = 0;
    
//    if (_user) {
    
//        self.unSureBtn.count = 8;
//        self.unCommiteBtn.count = 88;
//        self.commitBtn.count = 123;
//    }
}
@end
