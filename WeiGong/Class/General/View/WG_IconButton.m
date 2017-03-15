//
//  WG_IconButton.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/8.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_IconButton.h"

@implementation WG_IconButton
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        [self setTitleColor:kColor_Black forState:UIControlStateNormal];
        self.titleLabel.font = kFont_15;
        self.space = 0;
    }
    return self;
}
//- (void)setSpace:(CGFloat)space {
//    _space = space;
//    [self intrinsicContentSize];
//}
- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    size.width += self.space;
//    size.width += 5;
    return size;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGSize size = self.currentImage.size;
    float imageY = (CGRectGetHeight(self.frame)-size.height)/2.0;
    float imageX = 0;
    if (self.type == 1) {
        imageX = CGRectGetWidth(self.frame) - size.width;
    }
    return (CGRect){imageX, imageY, size};
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGRect imageF = [self imageRectForContentRect:CGRectZero];
    float titleX = CGRectGetMaxX(imageF);
    if (self.type == 1) {
        titleX = 0;
    }
    float titleW = CGRectGetWidth(self.frame) - titleX;
    float titleH = CGRectGetHeight(self.frame);
    return (CGRect){titleX, 0, titleW, titleH};
}

@end
