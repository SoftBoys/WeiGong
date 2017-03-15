//
//  NSNotificationCenter+Addition.h
//  WGKitDemo
//
//  Created by dfhb@rdd on 16/11/25.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (Addition)
+ (void)wg_addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName;
+ (void)wg_addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject;

+ (void)wg_postNotificationName:(NSString *)aName;
+ (void)wg_postNotificationName:(NSString *)aName object:(id)anObject;
+ (void)wg_postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo;

+ (void)wg_removeObserver:(id)observer;

@end
