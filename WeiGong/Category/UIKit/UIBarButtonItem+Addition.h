//
//  UIBarButtonItem+Addition.h
//  WGPublicClassDemo
//
//  Created by dfhb@rdd on 16/12/1.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WGBarButtonTouchBlock)(id obj);
@interface UIBarButtonItem (Addition)

+ (instancetype)wg_itemWithImage:(UIImage *)image highlightImage:(UIImage *)highlightImage target:(id)target action:(SEL)action;
+ (instancetype)wg_itemWithImage:(UIImage *)image highlightImage:(UIImage *)highlightImage touchBlock:(WGBarButtonTouchBlock)block;

+ (instancetype)wg_itemWithTitle:(NSString *)title tintColor:(UIColor *)tintColor target:(id)target action:(SEL)action;
+ (instancetype)wg_itemWithTitle:(NSString *)title tintColor:(UIColor *)tintColor touchBlock:(WGBarButtonTouchBlock)block;
@end
