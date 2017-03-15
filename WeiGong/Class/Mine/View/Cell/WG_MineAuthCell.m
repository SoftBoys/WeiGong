//
//  WG_MineAuthCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/21.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_MineAuthCell.h"

#import "WG_MineCellItem.h"

@interface WG_MineIconButton : UIButton

@end

@implementation WG_MineIconButton
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = NO;
        self.titleLabel.font = kFont_15;
        
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        [self setTitleColor:kColor_Black_Sub forState:UIControlStateNormal];
    }
    return self;
}
- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    size.width += 8;
    return size;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGSize size = self.currentImage.size;
    float imageY = (CGRectGetHeight(self.frame)-size.height)/2.0;
    return (CGRect){0, imageY, size};
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGRect imageF = [self imageRectForContentRect:CGRectZero];
    float titleX = CGRectGetMaxX(imageF);
    float titleW = CGRectGetWidth(self.frame) - titleX;
    float titleH = CGRectGetHeight(self.frame);
    return (CGRect){titleX, 0, titleW, titleH};
}
@end

@interface WG_MineAuthCell ()
@property (nonatomic, strong) WG_MineIconButton *iconBtn;
@property (nonatomic, strong) UILabel *labname_right;
@property (nonatomic, strong) UIButton *button_account;
@end
@implementation WG_MineAuthCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    
    [self.contentView addSubview:self.iconBtn];
    [self.contentView addSubview:self.labname_right];
    [self.contentView addSubview:self.button_account];
    
    [self.iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.contentView).offset(0);
        make.bottom.mas_equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(45);
    }];
    
    [self.labname_right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(self.arrowView.mas_left).offset(-5);
    }];
    
    CGFloat accountW = 60.0, accountH = 25.0;
    [self.button_account mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(self.arrowView.mas_left).offset(6);
        make.width.mas_equalTo(accountW);
        make.height.mas_equalTo(accountH);
    }];
    
    CGFloat lineW = kLineHeight;
    CGFloat radius = accountH/2;// accountH/2
    UIImage *image_nor = [[[UIImage wg_imageWithColor:kWhiteColor size:CGSizeMake(accountW, accountH)] wg_imageWithCornerRadius:radius borderWidth:lineW borderColor:kColor_OrangeRed] wg_resizedImage];
    UIImage *image_hig = [[[UIImage wg_imageWithColor:[kWhiteColor colorWithAlphaComponent:0.9] size:CGSizeMake(accountW, accountH)] wg_imageWithCornerRadius:radius borderWidth:lineW borderColor:kColor_OrangeRed] wg_resizedImage];
    [_button_account setBackgroundImage:image_nor forState:UIControlStateNormal];
    [_button_account setBackgroundImage:image_hig forState:UIControlStateHighlighted];
//    [self.iconBtn setImage:[UIImage imageNamed:@"mine_mywork"] forState:UIControlStateNormal];
//    [self.iconBtn setTitle:@"测试信息" forState:UIControlStateNormal];
//    self.labname_right.backgroundColor = [UIColor redColor];
//    self.iconBtn.backgroundColor = [UIColor redColor];
}

- (void)setItem:(WG_MineCellItem *)item {
    _item = item;
    if (_item) {
        [self.iconBtn setImage:_item.icon forState:UIControlStateNormal];
        [self.iconBtn setTitle:_item.name_left forState:UIControlStateNormal];
        
        self.labname_right.text = _item.name_right;
        
//        self.labname_right.text = @"1234";
        
        self.arrowView.hidden = _item.cellType == 0;
        self.selectionStyle =  _item.cellType == 0 ? UITableViewCellSelectionStyleNone : UITableViewCellSelectionStyleDefault;
        self.labname_right.hidden = _item.cellType != 2;
        
        self.button_account.hidden = _item.type != 0;
        
    }
}

- (WG_MineIconButton *)iconBtn {
    if (!_iconBtn) {
        _iconBtn = [WG_MineIconButton buttonWithType:UIButtonTypeCustom];
        [_iconBtn setTitleColor:kColor_Black forState:UIControlStateNormal];
        _iconBtn.titleLabel.font = kFont(14);
    }
    return _iconBtn;
}
- (UILabel *)labname_right {
    if (!_labname_right) {
        _labname_right = [UILabel wg_labelWithFont:kFont_13 textColor:kColor_Gray_Sub];
    }
    return _labname_right;
}
- (UIButton *)button_account {
    if (!_button_account) {
        _button_account = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_account.titleLabel.font = kFont(14);
        [_button_account setTitleColor:kColor_OrangeRed forState:UIControlStateNormal];
        [_button_account setTitle:@"账户" forState:UIControlStateNormal];
        __weak typeof(self) weakself = self;
        [_button_account setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            if ([strongself.delegate respondsToSelector:@selector(clickCellAccountWithItem:)]) {
                [strongself.delegate clickCellAccountWithItem:strongself.item];
            }
        }];
    }
    return _button_account;
}
@end
