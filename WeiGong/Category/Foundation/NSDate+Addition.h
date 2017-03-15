//
//  NSDate+Addition.h
//  WGKitDemo
//
//  Created by dfhb@rdd on 16/11/28.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Addition)
/** 今天 */
- (BOOL)wg_isToday;
/** 昨天 */
- (BOOL)wg_isYesterday;
/** 明天 */
- (BOOL)wg_isTomorrow;
/** 当月 */
- (BOOL)wg_isThisMonth;
/** 上一月 */
- (BOOL)wg_isLastMonth;
/** 下一月 */
- (BOOL)wg_isNextMonth;
/** 今年 */
- (BOOL)wg_isThisYear;
/** 去年 */
- (BOOL)wg_isLastYear;
/** 下一年 */
- (BOOL)wg_isNextYear;
/** 上一月 */
- (NSDate *)wg_lastMonth;
/** 下一月 */
- (NSDate *)wg_nextMonth;

/** 将日期格式化为字符串 */
- (NSString *)wg_stringWithDateFormat:(NSString *)dateFormat;
/** 将日期格式化为字符串 */
- (NSString *)wg_stringFromDate:(NSDate *)date dateFormat:(NSString *)dateFormat;
/** 将日期字符串转换为NSDate */
+ (NSDate *)wg_dateWithDateString:(NSString *)dateString dateFormat:(NSString *)dateFormat;

@end
