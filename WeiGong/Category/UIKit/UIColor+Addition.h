//
//  UIColor+Addition.h
//  WGKitDemo
//
//  Created by dfhb@rdd on 16/11/28.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Addition)
/** 根据RGB获取颜色red,green,blue 取值范围(0~255) */
+ (UIColor *)wg_red:(float)red green:(float)green blue:(float)blue;
+ (UIColor *)wg_red:(float)red green:(float)green blue:(float)blue alpha:(float)alpha;
/** 根据十六进制色值返回UIColor */
+ (UIColor *)wg_colorWithHexString:(NSString *)hexString;
@end
