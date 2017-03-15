//
//  NSDate+Addition.m
//  WGKitDemo
//
//  Created by dfhb@rdd on 16/11/28.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "NSDate+Addition.h"
#import <objc/runtime.h>

NSString *kYMD = @"yyyy-MM-dd", *kYMonth = @"yyyy-MM", *kYear = @"yyyy";
NSCalendarUnit kCalendarUnit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute;
const void *WG_dateFormatterKey, *WG_calendarKey;
@implementation NSDate (Addition)

- (BOOL)wg_isToday {
    NSDateComponents *components = [self wg_componentsFromDate:self toDate:[NSDate date] dateFormat:kYMD];
    return (components.year == 0 && components.month == 0 && components.day == 0);
}
- (BOOL)wg_isYesterday {
    NSDateComponents *components = [self wg_componentsFromDate:self toDate:[NSDate date] dateFormat:kYMD];
    return (components.year == 0 && components.month == 0 && components.day == 1);
}
- (BOOL)wg_isTomorrow {
    NSDateComponents *components = [self wg_componentsFromDate:self toDate:[NSDate date] dateFormat:kYMD];
    return (components.year == 0 && components.month == 0 && components.day == -1);
}

- (BOOL)wg_isThisMonth {
    NSDateComponents *components = [self wg_componentsFromDate:self toDate:[NSDate date] dateFormat:kYMonth];
    return (components.year == 0 && components.month == 0);
}
- (BOOL)wg_isLastMonth {
    NSDateComponents *components = [self wg_componentsFromDate:self toDate:[NSDate date] dateFormat:kYMonth];
    return (components.year == 0 && components.month == 1);
}
- (BOOL)wg_isNextMonth {
    NSDateComponents *components = [self wg_componentsFromDate:self toDate:[NSDate date] dateFormat:kYMonth];
    return (components.year == 0 && components.month == -1);
}

- (BOOL)wg_isThisYear {
    NSDateComponents *components = [self wg_componentsFromDate:self toDate:[NSDate date] dateFormat:kYear];
    return (components.year == 0);
}
- (BOOL)wg_isLastYear {
    NSDateComponents *components = [self wg_componentsFromDate:self toDate:[NSDate date] dateFormat:kYear];
    return (components.year == 1);
}
- (BOOL)wg_isNextYear {
    NSDateComponents *components = [self wg_componentsFromDate:self toDate:[NSDate date] dateFormat:kYear];
    return (components.year == -1);
}


- (NSDate *)wg_lastMonth {
//    NSDateComponents *components = [self wg_componentsFromDate:self toDate:nil dateFormat:kYMonth];
    NSCalendar *calendar = [self wg_calendar];
    NSDateComponents *components = [calendar components:kCalendarUnit fromDate:self];
    components.month = components.month - 1;
    NSDate *date = [calendar dateFromComponents:components];
    return date;
}
- (NSDate *)wg_nextMonth {
    NSCalendar *calendar = [self wg_calendar];
    NSDateComponents *components = [calendar components:kCalendarUnit fromDate:self];
    components.month = components.month + 1;
    NSDate *date = [calendar dateFromComponents:components];
    return date;
}


/** 将日期格式化为固定字符串 */
- (NSString *)wg_stringWithDateFormat:(NSString *)dateFormat {
    return [self wg_stringFromDate:self dateFormat:dateFormat];
}
/** 将日期格式化为固定字符串 */
- (NSString *)wg_stringFromDate:(NSDate *)date dateFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [self wg_formatter];
    formatter.dateFormat = dateFormat;
    return [formatter stringFromDate:date];
}

+ (NSDate *)wg_dateWithDateString:(NSString *)dateString dateFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [NSDate wg_formatter];
    formatter.dateFormat = dateFormat;
    return [formatter dateFromString:dateString];
}

#pragma mark - private -- 私有方法
- (NSDateComponents *)wg_componentsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate dateFormat:(NSString *)dateFormat {
    NSCalendar *calendar = [self wg_calendar];
    NSDateFormatter *formatter = [self wg_formatter];
    if (dateFormat == nil) {
        dateFormat = kYMD;
    }
    [formatter setDateFormat:dateFormat];
    NSDate *newFromDate = [formatter dateFromString:[formatter stringFromDate:fromDate]];
    NSDate *newToDate = [formatter dateFromString:[formatter stringFromDate:toDate]];
    NSDateComponents *components = [calendar components:kCalendarUnit fromDate:newFromDate toDate:newToDate options:0];
//    NSLog(@"components:%@", components);
    return components;
}
+ (NSDateFormatter *)wg_formatter {
    return [[NSDate date] wg_formatter];
}
- (NSDateFormatter *)wg_formatter {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
    });
    return formatter;
    
//    NSDateFormatter *formatter = objc_getAssociatedObject(self, &WG_dateFormatterKey);
//    if (formatter == nil) {
//        formatter = [[NSDateFormatter alloc] init];
//        objc_setAssociatedObject(self, &WG_dateFormatterKey, formatter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    }
//    return formatter;
}
- (NSCalendar *)wg_calendar {
    static NSCalendar *calendar = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
            calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
        } else {
            calendar = [NSCalendar currentCalendar];
        }
//        NSLog(@"calendar");
    });
    return calendar;
    
//    NSCalendar *calendar = objc_getAssociatedObject(self, &WG_calendarKey);
//    if (calendar == nil) {
//        if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
//            calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
//        } else {
//            calendar = [NSCalendar currentCalendar];
//        }
//        objc_setAssociatedObject(self, &WG_calendarKey, calendar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    }
//    return calendar;
}
@end
