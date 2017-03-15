//
//  UIView+Frame.m
//  WGKitDemo
//
//  Created by dfhb@rdd on 16/11/25.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (WGFrame)

- (void)setWg_origin:(CGPoint)wg_origin {
    CGRect frame = self.frame;
    frame.origin = wg_origin;
    self.frame = frame;
}
- (CGPoint)wg_origin {
    return self.frame.origin;
}
- (void)setWg_size:(CGSize)wg_size {
    CGRect frame = self.frame;
    frame.size = wg_size;
    self.frame = frame;
}
- (CGSize)wg_size {
    return self.frame.size;
}

- (void)setWg_centerX:(CGFloat)wg_centerX {
    CGPoint center = self.center;
    center.x = wg_centerX;
    self.center = center;
}
- (CGFloat)wg_centerX {
    return self.center.x;
}

- (void)setWg_centerY:(CGFloat)wg_centerY {
    CGPoint center = self.center;
    center.y = wg_centerY;
    self.center = center;
}
- (CGFloat)wg_centerY {
    return self.center.y;
}

- (void)setWg_x:(CGFloat)wg_x {
    CGRect frame = self.frame;
    frame.origin.x = wg_x;
    self.frame = frame;
}
- (CGFloat)wg_x {
    return self.frame.origin.x;
}

- (void)setWg_y:(CGFloat)wg_y {
    CGRect frame = self.frame;
    frame.origin.y = wg_y;
    self.frame = frame;
}
- (CGFloat)wg_y {
    return self.frame.origin.y;
}

- (void)setWg_top:(CGFloat)wg_top {
    CGRect frame = self.frame;
    frame.origin.y = wg_top;
    self.frame = frame;
}
- (CGFloat)wg_top {
    return self.frame.origin.y;
}

- (void)setWg_bottom:(CGFloat)wg_bottom {
    CGRect frame = self.frame;
    frame.origin.y = wg_bottom - frame.size.height;
    self.frame = frame;
}
- (CGFloat)wg_bottom {
    return CGRectGetMaxY(self.frame);
}

- (void)setWg_left:(CGFloat)wg_left {
    CGRect frame = self.frame;
    frame.origin.x = wg_left;
    self.frame = frame;
}
- (CGFloat)wg_left {
    return self.frame.origin.x;
}

- (void)setWg_right:(CGFloat)wg_right {
    CGRect frame = self.frame;
    frame.origin.x = wg_right - frame.size.width;
    self.frame = frame;
}
- (CGFloat)wg_right {
    return CGRectGetMaxX(self.frame);
}

- (void)setWg_width:(CGFloat)wg_width {
    CGRect frame = self.frame;
    frame.size.width = wg_width;
    self.frame = frame;
}
- (CGFloat)wg_width {
    return self.frame.size.width;
}

- (void)setWg_height:(CGFloat)wg_height {
    CGRect frame = self.frame;
    frame.size.height = wg_height;
    self.frame = frame;
}
- (CGFloat)wg_height {
    return self.frame.size.height;
}


@end
