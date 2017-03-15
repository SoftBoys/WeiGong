//
//  NSDictionary+Safe.m
//  自定义小控件
//
//  Created by dfhb@rdd on 16/11/25.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "NSDictionary+Safe.h"

@implementation NSDictionary (Safe)

- (NSString *)wg_stringForKey:(id)aKey {
    id value = [self wg_objectForKey:aKey];
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString *)value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)value stringValue];
    }
    return nil;
}
- (NSNumber *)wg_numberForKey:(id)aKey {
    id value = [self wg_objectForKey:aKey];
    if ([value isKindOfClass:[NSNumber class]]) {
        return (NSNumber *)value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        return [f numberFromString:(NSString*)value];
    }
    return nil;
}
- (NSArray *)wg_arrayForKey:(id)aKey {
    id value = [self wg_objectForKey:aKey];
    if ([value isKindOfClass:[NSArray class]]) {
        return (NSArray *)value;
    }
    return nil;
}
- (NSDictionary *)wg_dicrionaryForKey:(id)aKey {
    id value = [self wg_objectForKey:aKey];
    if ([value isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary *)value;
    }
    return nil;
}
- (NSInteger)wg_integerForKey:(id)aKey {
    id value = [self wg_objectForKey:aKey];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value integerValue];
    }
    return 0;
}
- (float)wg_floatForKey:(id)aKey {
    id value = [self wg_objectForKey:aKey];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value floatValue];
    }
    return 0;
}
- (double)wg_doubleForKey:(id)aKey {
    id value = [self wg_objectForKey:aKey];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value doubleValue];
    }
    return 0;
}
- (BOOL)wg_boolForKey:(id)aKey {
    id value = [self wg_objectForKey:aKey];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value boolValue];
    }
    return NO;
}
- (char)wg_charForKey:(id)aKey {
    id value = [self wg_objectForKey:aKey];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value charValue];
    }
    return 0;
}

#pragma mark - private
- (id)wg_objectForKey:(id)aKey {
    id value = [self objectForKey:aKey];
    if (value == nil || value == [NSNull null] || [[value description] isEqualToString:@"<null>"]) {
        return nil;
    }
    return value;
}

@end

@implementation NSMutableDictionary (Safe)

- (void)wg_setObject:(id)anObject forKey:(NSString *)aKey {
    if (aKey) {
        [self setObject:anObject forKey:aKey];
    }
}
- (void)wg_setString:(NSString *)string forKey:(NSString *)aKey {
    [self wg_setObject:string forKey:aKey];
}
- (void)wg_setNumber:(NSNumber *)number forKey:(NSString *)aKey {
    [self wg_setObject:number forKey:aKey];
}
- (void)wg_setInt:(int)i forKey:(NSString *)aKey {
    [self wg_setObject:@(i) forKey:aKey];
}
- (void)wg_setInteger:(NSInteger)i forKey:(NSString *)aKey {
    [self wg_setObject:@(i) forKey:aKey];
}
- (void)wg_setFloat:(float)f forKey:(NSString *)aKey {
    [self wg_setObject:@(f) forKey:aKey];
}
- (void)wg_setDouble:(double)d forKey:(NSString *)aKey {
    [self wg_setObject:@(d) forKey:aKey];
}
- (void)wg_setBool:(float)b forKey:(NSString *)aKey {
    [self wg_setObject:@(b) forKey:aKey];
}
@end

@implementation NSDictionary (JSON)
- (NSString *)wg_JSONString {
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
    if (data == nil) {
#ifdef DEBUG
        NSLog(@"fail to get JSON from dictionary: %@, error: %@", self, error);
#endif
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return jsonString;
}
@end