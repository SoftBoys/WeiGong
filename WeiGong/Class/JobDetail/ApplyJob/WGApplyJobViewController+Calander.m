//
//  WGApplyJobViewController+Calander.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/3.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGApplyJobViewController+Calander.h"
#import "WG_JobDetail.h"
#import "WGApplyJobCollectionViewCell.h"


@implementation WGApplyJobViewController (Calander)
- (NSArray<NSArray *> *)monthsWithJobDetail:(WG_JobDetail *)detail {
    
//    detail.dateStop = @"20180308";
    NSDate *dateStart = [NSDate wg_dateWithDateString:detail.dateStart dateFormat:@"yyyyMMdd"];
    NSDate *dateStop = [NSDate wg_dateWithDateString:detail.dateStop dateFormat:@"yyyyMMdd"];
    
    NSCalendarUnit kCalendarUnitYMD = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    
    NSDateComponents *comp = [[self wg_calendar] components:NSCalendarUnitMonth fromDate:[NSDate date] toDate:dateStop options:0];
    NSInteger sections = comp.month + 1;
    
    NSMutableArray *monthList = @[].mutableCopy;
    for (NSInteger i = 0 ; i < sections; i++) {
        
        NSInteger count = [self getItemsWithSection:i];
        NSDate *firstOfMonth = [self firstOfMonthForSection:i];
        NSMutableArray *itemList = @[].mutableCopy;
        for (NSInteger j = 0; j < count; j++) {
            NSDate *cellDate = [self dateCellWithSection:i Item:j];
            
            NSDateComponents *cellDateComponents = [[self wg_calendar] components:kCalendarUnitYMD fromDate:cellDate];
            NSDateComponents *firstOfMonthsComponents = [[self wg_calendar] components:kCalendarUnitYMD fromDate:firstOfMonth];
//            NSDateComponents *components = [[self wg_calendar] components:NSCalendarUnitMonth fromDate:firstOfMonth toDate:cellDate options:0];
            
            WGApplyJobCollectionItem *item = [WGApplyJobCollectionItem new];
            item.date = cellDate;
            item.isToday = [cellDate wg_isToday];
            item.day = [cellDate wg_stringWithDateFormat:@"d"];
            item.enabled = YES;
            
            // 在同一个月
            
            if (cellDateComponents.month == firstOfMonthsComponents.month) {
                item.enabled = YES;
            } else {
                item.enabled = NO;
            }
            
            NSDateComponents *componentsDay = [[self wg_calendar] components:NSCalendarUnitDay fromDate:[NSDate date] toDate:cellDate options:0];
            if (componentsDay.day < 0) { // 日期小于今天
                item.enabled = NO;
            };
            
            NSDateComponents *componentsDay2 = [[self wg_calendar] components:NSCalendarUnitDay fromDate:dateStop toDate:cellDate options:0];
            if (componentsDay2.day > 0) { // 日期大于今天
                item.enabled = NO;
            };
            
            [itemList wg_addObject:item];
            
        }
        [monthList wg_addObject:itemList];
    }
    
    return [monthList copy];
    
}

#pragma mark 获取每个section的items
- (NSInteger)getItemsWithSection:(NSInteger)section {
    NSDate *firstOfMonth = [self firstOfMonthForSection:section];
    NSCalendarUnit weekCalendarUnit = [self weekCalendarUnitDependingOniOSVersion];
    NSRange rangeOfWeeks = [[self wg_calendar] rangeOfUnit:weekCalendarUnit inUnit:NSCalendarUnitMonth forDate:firstOfMonth];
    return (rangeOfWeeks.length * 7);
}
- (NSCalendarUnit)weekCalendarUnitDependingOniOSVersion {
    //isDateInToday is a new (awesome) method available on iOS8 only.
    if ([[self wg_calendar] respondsToSelector:@selector(isDateInToday:)]) {
        return NSCalendarUnitWeekOfMonth;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return NSWeekCalendarUnit;
#pragma clang diagnostic pop
    }
}
- (NSDate *)firstOfMonthForSection:(NSInteger)section {
    NSDateComponents *offset = [NSDateComponents new];
    offset.month = section;
    return [[self wg_calendar] dateByAddingComponents:offset toDate:self.firstDateMonth options:0];
}

- (NSDate *)firstDateMonth {
    NSCalendarUnit kCalendarUnit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *components = [[self wg_calendar] components:kCalendarUnit
                                                    fromDate:[NSDate date]];
    components.day = 1;
    
    return[[self wg_calendar] dateFromComponents:components];
}

#pragma mark 设置每个Item的日期
- (NSDate *)dateCellWithSection:(NSInteger)section Item:(NSInteger)item {
    NSDate *firstOfMonth = [self firstOfMonthForSection:section];
    
    NSUInteger weekday = [[[self wg_calendar] components: NSCalendarUnitWeekday fromDate: firstOfMonth] weekday];
    NSInteger startOffset = weekday - [self wg_calendar].firstWeekday;
    startOffset += startOffset >= 0 ? 0 : 7;
    
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.day = item - startOffset;
    
    return [[self wg_calendar] dateByAddingComponents:dateComponents toDate:firstOfMonth options:0];
}

#pragma mark - private
- (NSCalendar *)wg_calendar {
    static NSCalendar *calendar = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
            calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
        } else {
            calendar = [NSCalendar currentCalendar];
        }
    });
    return calendar;
}


@end
