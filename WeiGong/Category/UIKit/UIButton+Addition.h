//
//  UIButton+Addition.h
//  WGKitDemo
//
//  Created by dfhb@rdd on 16/11/29.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TouckBlock)(UIButton *button);
@interface UIButton (Addition)
/**
 *  快速初始化
 *
 *  @param image      图标
 *  @param hightImage 高亮图标
 *  @param backImage  背景图片
 *  @param target     目标
 *  @param action     响应事件
 */
+ (instancetype)wg_buttonWithImage:(UIImage *)image
                        hightImage:(UIImage *)hightImage
                         backImage:(UIImage *)backImage
                            target:(id)target
                            action:(SEL)action;
/**
 *  快速初始化
 *
 *  @param image      图标
 *  @param hightImage 高亮图标
 *  @param backImage  背景图片
 *  @param block      按钮回调
 */
+ (instancetype)wg_buttonWithImage:(UIImage *)image
                        hightImage:(UIImage *)hightImage
                         backImage:(UIImage *)backImage
                        touchBlock:(TouckBlock)block;
/**
 *  快速初始化
 *
 *  @param title       标题
 *  @param normalColor 标题颜色
 *  @param selectColor 标题选中的颜色
 *  @param textFont    标题字体大小
 *  @param target      目标
 *  @param action      响应事件
 */
+ (instancetype)wg_buttonWithTitle:(NSString *)title
                       normalColor:(UIColor *)normalColor
                       selectColor:(UIColor *)selectColor
                          textFont:(UIFont *)textFont
                            target:(id)target
                            action:(SEL)action;
/**
 *  快速初始化
 *
 *  @param title       标题
 *  @param normalColor 标题颜色
 *  @param selectColor 标题选中颜色
 *  @param textFont    字体大小
 *  @param block       按钮回调
 */
+ (instancetype)wg_buttonWithTitle:(NSString *)title
                       normalColor:(UIColor *)normalColor
                       selectColor:(UIColor *)selectColor
                          textFont:(UIFont *)textFont
                        touchBlock:(TouckBlock)block;

@end


//@interface UIButton (State)
///** 是否禁用高亮状态 */
//@property (nonatomic, assign) BOOL disableHighlightedState;
//@end
