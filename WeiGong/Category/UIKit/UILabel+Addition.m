//
//  UILabel+Addition.m
//  WGKitDemo
//
//  Created by dfhb@rdd on 16/11/25.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "UILabel+Addition.h"

@implementation UILabel (Addition)

+ (instancetype)wg_labelWithFont:(UIFont *)font {
    return [self wg_labelWithFont:font textColor:nil];
}
+ (instancetype)wg_labelWithFont:(UIFont *)font textColor:(UIColor *)textColor {
    return [self wg_labelWithFont:font textColor:textColor textAlignment:NSTextAlignmentLeft];
}
+ (instancetype)wg_labelWithFont:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment {
    UILabel *label = [[[self class] alloc] init];
    label.font = font;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    return label;
}

@end
