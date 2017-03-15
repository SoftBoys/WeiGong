//
//  NSTimer+Addition.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/26.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "NSTimer+Addition.h"

@implementation NSTimer (Addition)

+ (NSTimer *)wg_scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void (^)())block repeats:(BOOL)repeats {
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(wg_timerRepead:) userInfo:[block copy] repeats:repeats];
}

+ (NSTimer *)wg_timerWithTimeInterval:(NSTimeInterval)interval block:(void (^)())block repeats:(BOOL)repeats {
    return [self timerWithTimeInterval:interval target:self selector:@selector(wg_timerRepead:) userInfo:[block copy] repeats:repeats];
}

+ (void)wg_timerRepead:(NSTimer *)timer {
    if (timer.userInfo) {
        void (^block)() = timer.userInfo;
        block();
    }
}
@end
