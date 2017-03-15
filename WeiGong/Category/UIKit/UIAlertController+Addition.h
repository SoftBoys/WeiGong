//
//  UIAlertController+Addition.h
//  WGKitDemo
//
//  Created by dfhb@rdd on 16/11/28.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Addition)
/**
 *  初始化一个AlertView
 *
 *  @param title      标题
 *  @param message    内容
 *  @param completion 按钮回调
 *  @param cancel     取消
 *  @param sure       确认
 */
+ (instancetype)wg_alertWithTitle:(NSString *)title message:(NSString *)message completion:(void(^)(UIAlertController *alert, NSInteger index))completion cancel:(NSString *)cancel sure:(NSString *)sure;
/**
 *  初始化一个ActionSheet
 *
 *  @param title      标题
 *  @param message    内容
 *  @param completion 按钮回调
 *  @param cancel     取消
 *  @param others     其他按钮
 */
+ (instancetype)wg_actionSheetWithTitle:(NSString *)title message:(NSString *)message completion:(void(^)(UIAlertController *alert, NSInteger index))completion cancel:(NSString *)cancel others:(NSArray<NSString *> *)others;

@end
