//
//  GuideCell.m
//  GJW_BaseViewController
//
//  Created by dfhb@rdd on 16/3/31.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "GuideCell.h"

@interface GuideCell ()
@property (nonatomic, strong) UIImageView *icanView;
@property (nonatomic, strong) UIButton *nextButton;
@end
@implementation GuideCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self buildSubViews];
    }
    return self;
}
- (instancetype)init {
    if (self = [super init]) {
        [self buildSubViews];
    }
    return self;
}
- (void)buildSubViews {
    CGRect bounds = [[UIScreen mainScreen] bounds];
    self.icanView = [[UIImageView alloc] init];
    self.icanView.frame = bounds;
    self.icanView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.icanView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitle:@"立即体验" forState:UIControlStateNormal];
//    self.nextButton.frame = CGRectMake((CGRectGetWidth(bounds) - 100) * 0.5, CGRectGetHeight(bounds) - 110, 100, 33);
    [button setTitleColor:kColor_Orange forState:UIControlStateNormal];
    [button addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button];
    button.layer.borderColor = kColor_Orange.CGColor;
    button.layer.borderWidth = 0.8;
    
    button.hidden = YES;
    self.nextButton = button;
    
    float btnW = 100;
    float btnH = 35;
    float bottom = 90;
    UIFont *font = kFont_16;

    if (IS_IPhone4) {
        bottom = 75;
        btnH = 30;
        font = [UIFont fontWithName:FontName size:15];
    } else if (IS_IPhone5) {
        bottom = 85;
        btnH = 30;
        font = [UIFont fontWithName:FontName size:15];
    } else if (IS_IPhone6P) {
        bottom = 95;
    }
    self.nextButton.titleLabel.font = font;
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(btnW, btnH));
        make.centerX.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(-bottom);
    }];
    
    self.nextButton.layer.cornerRadius = btnH/2.0;
    
}
- (void)setImage:(UIImage *)image {
    _image = image;
    if (_image) {
        self.icanView.image = _image;
    }
}
- (void)setIsHiddenNextButton:(BOOL)isHiddenNextButton {
    _isHiddenNextButton = isHiddenNextButton;
    self.nextButton.hidden = _isHiddenNextButton;
}
- (void)nextClick {
    if ([self.delegate respondsToSelector:@selector(nextFinished)]) {
        [self.delegate nextFinished];
    }
}
@end
