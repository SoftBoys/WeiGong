//
//  WG_HomeCityButton.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/13.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_HomeCityButton.h"

//static float space = 2.0f;
@implementation WG_HomeCityButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = kFont_16;
        [self setImage:[UIImage imageNamed:@"home_city"] forState:UIControlStateNormal];
        [self setTitleColor:kColor_White forState:UIControlStateNormal];
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
//        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
//        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    size.width += 5;
    return size;
}
- (void)setTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
}
- (void)setHighlighted:(BOOL)highlighted {}
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    float titleX = 0;
    float titleY = 0;
    float titleW = CGRectGetWidth(self.frame) - titleX - self.currentImage.size.width;
    float titleH = CGRectGetHeight(self.frame);
    CGRect frame = CGRectMake(titleX, titleY, titleW, titleH);
    return frame;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    float imageW = self.currentImage.size.width;
    float imageH = self.currentImage.size.height;
    float imageX = CGRectGetWidth(self.frame) - imageW;
    float imageY = (CGRectGetHeight(self.frame) - imageH)*0.5;
    CGRect frame = CGRectMake(imageX, imageY, imageW, imageH);
    return frame;
}
@end
