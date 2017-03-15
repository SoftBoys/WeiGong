//
//  WGStepView.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/21.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGStepView : UIView
+ (instancetype)stepViewWithTitles:(NSArray <NSString*>*)titles;
@property (nonatomic, copy) NSArray <NSString *> *titles;

@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, strong) UIColor *colorNor;

@property (nonatomic, strong) UIColor *colorSel;
/** 当前页面 默认为0 */
@property (nonatomic, assign) NSInteger currentIndex;
/** 分割线的颜色 */
@property (nonatomic, strong) UIColor *colorLine;

@end
