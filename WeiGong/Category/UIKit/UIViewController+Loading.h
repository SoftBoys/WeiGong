//
//  UIViewController+Loading.h
//  WGKitDemo
//
//  Created by dfhb@rdd on 16/11/28.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 正在加载时文本内容 */
static NSString *const kLoadingText = @"正在加载...";
@interface UIViewController (Loading)

- (UIView *)wg_loadingView;
/** 显示加载框 */
- (void)wg_showLoadingView;
- (void)wg_showLoadingViewWithFrame:(CGRect)frame;
/** 隐藏加载框 */
- (void)wg_hideLoadingView;

@end
