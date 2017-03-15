//
//  UIColor+Addition.m
//  WGKitDemo
//
//  Created by dfhb@rdd on 16/11/28.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "UIColor+Addition.h"

@implementation UIColor (Addition)

+ (UIColor *)wg_red:(float)red green:(float)green blue:(float)blue {
    return [self wg_red:red green:green blue:blue alpha:1];
}
+ (UIColor *)wg_red:(float)red green:(float)green blue:(float)blue alpha:(float)alpha {
    return [self colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}

+ (UIColor *)wg_colorWithHexString:(NSString *)hexString {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *cstring = [hexString stringByTrimmingCharactersInSet:set];
    
    if ([cstring hasPrefix:@"0X"]) {
        cstring = [cstring substringFromIndex:2];
    }
    if ([cstring hasPrefix:@"#"]) {
        cstring = [cstring substringFromIndex:1];
    }
    if (cstring.length != 6) {
        return [UIColor clearColor];
    }
    NSRange range;
    range.length = 2;
    
    // R
    range.location = 0;
    NSString *redString = [cstring substringWithRange:range];
    // G
    range.location = 2;
    NSString *greenString = [cstring substringWithRange:range];
    // B
    range.location = 4;
    NSString *blueString = [cstring substringWithRange:range];
    
    unsigned int red,green,blue;
    [[NSScanner scannerWithString:redString] scanHexInt:&red];
    [[NSScanner scannerWithString:greenString] scanHexInt:&green];
    [[NSScanner scannerWithString:blueString] scanHexInt:&blue];
    
    return [self wg_red:red green:green blue:blue];
}
@end
