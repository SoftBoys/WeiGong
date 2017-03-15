//
//  NSTimer+Addition.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/26.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Addition)

+ (NSTimer *)wg_scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void(^)())block repeats:(BOOL)repeats;
+ (NSTimer *)wg_timerWithTimeInterval:(NSTimeInterval)interval block:(void(^)())block repeats:(BOOL)repeats;

@end
