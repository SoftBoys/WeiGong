//
//  UIView+Frame.h
//  WGKitDemo
//
//  Created by dfhb@rdd on 16/11/25.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WGFrame)
@property (nonatomic, assign) CGPoint wg_origin;
@property (nonatomic, assign) CGSize wg_size;

@property (nonatomic, assign) CGFloat wg_centerX;
@property (nonatomic, assign) CGFloat wg_centerY;

@property (nonatomic, assign) CGFloat wg_x;
@property (nonatomic, assign) CGFloat wg_y;
@property (nonatomic, assign) CGFloat wg_top;
@property (nonatomic, assign) CGFloat wg_left;
@property (nonatomic, assign) CGFloat wg_right;
@property (nonatomic, assign) CGFloat wg_bottom;

@property (nonatomic, assign) CGFloat wg_width;
@property (nonatomic, assign) CGFloat wg_height;
@end
