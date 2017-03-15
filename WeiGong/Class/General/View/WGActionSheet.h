//
//  WGActionSheet.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/22.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WGActionSheet;
typedef void(^WGActionSheetCompletionHandle)(WGActionSheet *sheet, NSInteger index);

@interface WGActionSheet : UIView

+ (instancetype)actionSheetWithTitle:(NSString *)title completionHandle:(WGActionSheetCompletionHandle)completionHandle cancel:(NSString *)cancel others:(NSArray<NSString *> *)others;
/** 是否需要蒙版 默认YES */
@property (nonatomic, assign) BOOL needMask;
@property (nonatomic, strong) UIColor *titleColor;
/** 是否可滚动 默认NO */
@property (nonatomic, assign) BOOL canScroll;
/** 设置最大高度 canScroll=YES 时有效 默认 220 */
@property (nonatomic, assign) CGFloat maxHeight;

@end
