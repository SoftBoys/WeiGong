//
//  PickerDateView.h
//  ForceUpdate
//
//  Created by dfhb@rdd on 15/10/23.
//  Copyright © 2015年 GW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerDateItem.h"
typedef enum NSInteger{
    /**
     *  年月日的形式
     */
    Type_YMD,
    /**
     *  时分的形式
     */
    Type_HM,
}DayType;
@interface PickerDateView : UIView
/**
 *  初始化
 */
+ (instancetype)showPickerWithcurrentItem:(PickerDateItem *)currentItem;
/**
 *  pick的高度(默认200)
 */
@property (nonatomic, assign) float pickH;
/**
 *  点击确定按钮的Block
 */
@property (nonatomic, strong) void (^sureBlock)(PickerDateItem *item);
/**
 *  是否显示蒙版 (默认显示)
 */
@property (nonatomic, assign) BOOL showMask;
/**
 *  显示的日期类型 (默认是年月日的形式)
 */
@property (nonatomic, assign) DayType type;
@end


@interface BottomBackView : UIView
/**
 *  当前的item
 */
@property (nonatomic, strong) PickerDateItem *currentItem;
/**
 *  显示的日期类型 (默认是年月日的形式)
 */
@property (nonatomic, assign) DayType type;
@end