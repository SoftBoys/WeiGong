//
//  WG_HomeCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/12.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_HomeCell.h"
#import "WG_HomeItem.h"
#import "WG_IconButton.h"

@interface WG_HomeCell ()
@property (nonatomic, strong) UIImageView *markIconView;
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIImageView *maskView;
@property (nonatomic, strong) WG_IconButton *button_time;
@property (nonatomic, strong) UILabel *labprice;
@property (nonatomic, strong) UILabel *labtitle;
@end
@implementation WG_HomeCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    
    [self.backImageView addSubview:self.markIconView];
    [self.backImageView addSubview:self.maskView];
    [self.maskView addSubview:self.button_time];
    [self.contentView addSubview:self.backImageView];
    
    [self.contentView addSubview:self.labprice];
    [self.contentView addSubview:self.labtitle];
    
    CGFloat markW = 20, markH = markW;
    [self.markIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.backImageView);
        make.size.mas_equalTo(CGSizeMake(markW, markH));
    }];
    CGFloat maskH = 20;
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(maskH);
    }];
    
    [self.button_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(10);
    }];
    
    CGFloat left = 12, top = 10;
    CGFloat height = (kScreenWidth-left*2) * 0.38;
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(left);
        make.top.mas_equalTo(top);
        make.right.mas_equalTo(-left);
        make.height.mas_equalTo(height);
    }];
    
    CGFloat spaceY = 8;
    [self.labprice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backImageView.mas_left);
        make.top.mas_equalTo(self.backImageView.mas_bottom).offset(spaceY);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-top);
    }];
    
    [self.labtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labprice.mas_right).offset(5);
        make.centerY.mas_equalTo(self.labprice);
//        make.right.mas_lessThanOrEqualTo(self.contentView.mas_right).offset(-left);
    }];
}

- (void)setItem:(WG_HomeItem *)item {
    _item = item;
    if (_item) {
        NSString *price = [NSString  stringWithFormat:@"￥%@/%@", _item.salary, _item.salaryStandard];
        self.labprice.text = price;
        self.labtitle.text = _item.jobName;
        
        CGFloat priceW = [self.labprice systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].width;
        
        self.labtitle.preferredMaxLayoutWidth = kScreenWidth-32-priceW;
//        self.labtitle.backgroundColor = kRedColor;
        
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
        
        [WGDownloadImageManager downloadImageWithUrl:_item.jobUrl completeHandle:^(BOOL finished, UIImage *image) {
//            self.backImageView.image = image;
//            return ;
            if (image) {
                self.backImageView.image = image;
            } else {
                self.backImageView.image = nil;
            }
        }];
        
        
        [WGDownloadImageManager downloadImageWithUrl:_item.markNameUrlSm completeHandle:^(BOOL finished, UIImage *image) {
            if (image) {
                self.markIconView.image = image;
            } else {
                self.markIconView.image = nil;
            }
        }];
        
        [self.button_time setTitle:_item.jobTimes forState:UIControlStateNormal];
    }
}
- (void)updateConstraints {
    [super updateConstraints];
    [self.labtitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.labtitle.preferredMaxLayoutWidth);
    }];
}
#pragma mark - getter && setter 
- (UIImageView *)markIconView {
    if (!_markIconView) {
        _markIconView = [UIImageView new];
//        _markIconView.contentMode = UIViewContentModeScaleAspectFit;
        _markIconView.backgroundColor = kClearColor;
    }
    return _markIconView;
}
- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [UIImageView new];
//        _backImageView.contentMode = UIViewContentModeScaleAspectFit;
        _backImageView.backgroundColor = kLightGrayColor;
    }
    return _backImageView;
}
- (UILabel *)labprice {
    if (!_labprice) {
        _labprice = [UILabel wg_labelWithFont:kFont_15 textColor:kColor_OrangeRed];
    }
    return _labprice;
}
- (UILabel *)labtitle {
    if (!_labtitle) {
        _labtitle = [UILabel wg_labelWithFont:kFont_16 textColor:kColor_Black];
    }
    return _labtitle;
}

- (UIImageView *)maskView {
    if (!_maskView) {
        _maskView = [UIImageView new];
        _maskView.image = [[UIImage wg_imageWithColor:[kBlackColor colorWithAlphaComponent:0.3]] wg_resizedImage];
//        _maskView.backgroundColor = [kBlackColor colorWithAlphaComponent:0.3];
    }
    return _maskView;
}
- (WG_IconButton *)button_time {
    if (!_button_time) {
        _button_time = [WG_IconButton buttonWithType:UIButtonTypeCustom];
        _button_time.userInteractionEnabled = NO;
        _button_time.type = 0;
        _button_time.space = 4;
        _button_time.titleLabel.font = kFont(11);
        [_button_time setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_button_time setImage:[UIImage imageNamed:@"home_time"] forState:UIControlStateNormal];
    }
    return _button_time;
}
@end
