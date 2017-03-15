//
//  NSNotificationCenter+Addition.m
//  WGKitDemo
//
//  Created by dfhb@rdd on 16/11/25.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "NSNotificationCenter+Addition.h"

@implementation NSNotificationCenter (Addition)
#pragma mark - 注册通知
+ (void)wg_addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName {
    [self wg_addObserver:observer selector:aSelector name:aName object:nil];
}
+ (void)wg_addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject {
    
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:aSelector name:aName object:anObject];
}
#pragma mark - 发送通知
+ (void)wg_postNotificationName:(NSString *)aName {
    [self wg_postNotificationName:aName object:nil];
}
+ (void)wg_postNotificationName:(NSString *)aName object:(id)anObject {
    [self wg_postNotificationName:aName object:anObject userInfo:nil];
}
+ (void)wg_postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo {
    if (aName == nil) {
#ifdef DEBUG
        NSLog(@"发通知名称不能为nil");
#endif
        return;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject userInfo:aUserInfo];
}

#pragma mark - 移除通知
+ (void)wg_removeObserver:(id)observer {
    [[NSNotificationCenter defaultCenter] removeObserver:observer];
}
@end
