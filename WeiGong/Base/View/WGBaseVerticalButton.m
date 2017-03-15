//
//  WGBaseVerticalButton.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/15.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGBaseVerticalButton.h"

@implementation WGBaseVerticalButton

//- (CGSize)intrinsicContentSize {
//    CGSize size = [super intrinsicContentSize];
//    size.height += _spaceY;
//    return size;
//}
- (void)setFont:(UIFont *)font {
    _font = font;
    self.titleLabel.font = _font;
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    CGRect imageF = [self imageRectForContentRect:CGRectZero];
    float titleX = 0;
    float titleW = CGRectGetWidth(self.frame) - titleX;
    float titleH = [self.font lineHeight];
    float titleY = CGRectGetMaxY(imageF) + _spaceY;
    if (self.type == kDMBaseButtonTypeTitleImage) {
        titleY = 0;
    }
    CGRect frame = CGRectMake(titleX, titleY, titleW, titleH);
    return frame;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    float imageW = self.currentImage.size.width;
    float imageH = self.currentImage.size.height;
    float imageY = 0;
    float imageX = (CGRectGetWidth(self.frame) - imageW)*0.5;
    
    if (self.type == kDMBaseButtonTypeTitleImage) {
        imageY = CGRectGetHeight(self.frame) - imageH;
    }
    CGRect frame = CGRectMake(imageX, imageY, imageW, imageH);
    return frame;
}

@end
