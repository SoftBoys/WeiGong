//
//  WG_RootTool.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/12.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WG_RootTool : NSObject
/**
 *  设置根视图控制器
 */
+ (void)setRootController;

+ (UIWindow *)window;
+ (UIViewController *)rootController;
@end
