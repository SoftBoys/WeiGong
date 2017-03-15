//
//  PickerDateItem.h
//  ForceUpdate
//
//  Created by dfhb@rdd on 15/10/23.
//  Copyright © 2015年 GW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PickerDateItem : NSObject
/**
 *  当前日期
 */
@property (nonatomic, strong) NSDate *currentDate;
/**
 *  最大的日期
 */
@property (nonatomic, strong) NSDate *maxDate;
/**
 *  最小的日期
 */
@property (nonatomic, strong) NSDate *minDate;
@end
