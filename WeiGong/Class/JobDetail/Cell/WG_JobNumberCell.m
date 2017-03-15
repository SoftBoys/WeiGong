//
//  WG_JobNumberCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/7.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_JobNumberCell.h"
#import "WG_JobDetail.h"

@interface WG_JobNumberButton : UIButton

@end
@implementation WG_JobNumberButton
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = NO;
        self.titleLabel.font = kFont_15;
        
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        [self setTitleColor:kColor_Orange forState:UIControlStateNormal];
    }
    return self;
}
- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    size.width += 5;
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

@interface WG_JobNumberCell ()
@property (nonatomic, strong) WG_JobNumberButton *button1;
@property (nonatomic, strong) WG_JobNumberButton *button2;
@property (nonatomic, strong) WG_JobNumberButton *button3;
@end

@implementation WG_JobNumberCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.button1 = [self wg_buttonWithImage:[UIImage imageNamed:@"detailN"]];
    [self.contentView addSubview:self.button1];
    
    self.button2 = [self wg_buttonWithImage:[UIImage imageNamed:@"detailM"]];
    [self.contentView addSubview:self.button2];
    
    self.button3 = [self wg_buttonWithImage:[UIImage imageNamed:@"detailS"]];
    [self.contentView addSubview:self.button3];
    
    float kWidth = kScreenWidth/3;
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.centerX.mas_equalTo(self.contentView).offset(-kWidth);
    }];
    
    
    [self.button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.centerX.mas_equalTo(self.contentView);
    }];
    
    [self.button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.centerX.mas_equalTo(self.contentView).offset(kWidth);
    }];
}

- (WG_JobNumberButton *)wg_buttonWithImage:(UIImage *)image {
    WG_JobNumberButton *button = [WG_JobNumberButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    return button;
}

- (void)setDetail:(WG_JobDetail *)detail {
    _detail = detail;
    if (_detail) {
        NSString *numberText = [NSString stringWithFormat:@"%@人", @(_detail.recruitNum)];
        NSString *unitText = [NSString stringWithFormat:@"%@元/%@", _detail.salary, _detail.salaryStandard];
        
        [self.button1 setTitle:numberText forState:UIControlStateNormal];
        [self.button2 setTitle:unitText forState:UIControlStateNormal];
        [self.button3 setTitle:_detail.payCycle forState:UIControlStateNormal];
    }
}
@end
