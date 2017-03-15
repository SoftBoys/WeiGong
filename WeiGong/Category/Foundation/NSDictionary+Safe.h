//
//  NSDictionary+Safe.h
//  自定义小控件
//
//  Created by dfhb@rdd on 16/11/25.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Safe)
- (NSString *)wg_stringForKey:(id)aKey;
- (NSNumber *)wg_numberForKey:(id)aKey;
- (NSArray *)wg_arrayForKey:(id)aKey;
- (NSDictionary *)wg_dicrionaryForKey:(id)aKey;
- (NSInteger)wg_integerForKey:(id)aKey;
- (float)wg_floatForKey:(id)aKey;
- (double)wg_doubleForKey:(id)aKey;
- (BOOL)wg_boolForKey:(id)aKey;
- (char)wg_charForKey:(id)aKey;
@end

@interface NSMutableDictionary (Safe)
- (void)wg_setObject:(id)anObject forKey:(NSString *)aKey;
- (void)wg_setString:(NSString *)string forKey:(NSString *)aKey;
- (void)wg_setNumber:(NSNumber *)number forKey:(NSString *)aKey;
- (void)wg_setInt:(int)i forKey:(NSString *)aKey;
- (void)wg_setInteger:(NSInteger)i forKey:(NSString *)aKey;
- (void)wg_setFloat:(float)f forKey:(NSString *)aKey;
- (void)wg_setDouble:(double)d forKey:(NSString *)aKey;
- (void)wg_setBool:(float)b forKey:(NSString *)aKey;
@end

@interface NSDictionary (JSON)
- (NSString *)wg_JSONString;
@end