//
//  UILabel+Addition.h
//  WGKitDemo
//
//  Created by dfhb@rdd on 16/11/25.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Addition)

+ (instancetype)wg_labelWithFont:(UIFont *)font;

+ (instancetype)wg_labelWithFont:(UIFont *)font
                       textColor:(UIColor *)textColor;
+ (instancetype)wg_labelWithFont:(UIFont *)font
                       textColor:(UIColor *)textColor
                   textAlignment:(NSTextAlignment)textAlignment;

@end
