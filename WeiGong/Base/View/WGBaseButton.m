//
//  WGBaseButton.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/14.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGBaseButton.h"

@implementation WGBaseButton

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    size.width += _spaceX;
    //    size.height += _spaceY;
    return size;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    float titleX = 0;
    float titleY = 0;
    
    float titleW = CGRectGetWidth(self.frame) - titleX - self.currentImage.size.width;
    float titleH = CGRectGetHeight(self.frame);
    if (self.type == kDMBaseButtonTypeImageTitle) {
        CGRect imageF = [self imageRectForContentRect:CGRectZero];
        titleX = CGRectGetMaxX(imageF) + _spaceX;
        titleW = CGRectGetWidth(self.frame) - titleX;
    }
    CGRect frame = CGRectMake(titleX, titleY, titleW, titleH);
    return frame;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    float imageW = self.currentImage.size.width;
    float imageH = self.currentImage.size.height;
    float imageY = (CGRectGetHeight(self.frame) - imageH)*0.5;
    float imageX = CGRectGetWidth(self.frame) - imageW;
    if (self.type == kDMBaseButtonTypeImageTitle) {
        imageX = 0;
    }
    CGRect frame = CGRectMake(imageX, imageY, imageW, imageH);
    return frame;
}
@end
