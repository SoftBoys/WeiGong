//
//  NSMutableArray+Safe.m
//  自定义小控件
//
//  Created by dfhb@rdd on 16/11/25.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "NSArray+Safe.h"

@implementation NSArray (Safe)

- (id)wg_objectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return self[index];
    } else {
        return nil;
    }
}
- (NSString *)wg_stringAtIndex:(NSUInteger)index {
    id value = [self wg_objectAtIndex:index];
    if (value == nil || value == [NSNull null] || [[value description] isEqualToString:@"<null>"]) {
        return nil;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString *)value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)value stringValue];
    }
    return nil;
}
- (NSArray *)wg_arrayAtIndex:(NSUInteger)index {
    id value = [self wg_objectAtIndex:index];
    if (value == nil || value == [NSNull null] || [[value description] isEqualToString:@"<null>"]) {
        return nil;
    }
    if ([value isKindOfClass:[NSArray class]]) {
        return (NSArray *)value;
    }
    return nil;
}
- (NSDictionary *)wg_dictionaryAtIndex:(NSUInteger)index {
    id value = [self wg_objectAtIndex:index];
    if (value == nil || value == [NSNull null] || [[value description] isEqualToString:@"<null>"]) {
        return nil;
    }
    if ([value isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary *)value;
    }
    return nil;
}
- (NSInteger)wg_integerAtIndex:(NSUInteger)index {
    id value = [self wg_objectAtIndex:index];
    if (value == nil || value == [NSNull null] || [[value description] isEqualToString:@"<null>"]) {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value integerValue];
    }
    return 0;
}
- (float)wg_floatAtIndex:(NSUInteger)index {
    id value = [self wg_objectAtIndex:index];
    if (value == nil || value == [NSNull null] || [[value description] isEqualToString:@"<null>"]) {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value floatValue];
    }
    return 0;
}
- (double)wg_doubleAtIndex:(NSUInteger)index {
    id value = [self wg_objectAtIndex:index];
    if (value == nil || value == [NSNull null] || [[value description] isEqualToString:@"<null>"]) {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value doubleValue];
    }
    return 0;
}
@end
@implementation NSMutableArray (Safe)
#pragma mark - 添加
- (void)wg_addObject:(id)anObject {
    if (anObject) {
        [self addObject:anObject];
    }
}
- (void)wg_addBool:(BOOL)i {
    [self wg_addObject:@(i)];
}
- (void)wg_addInt:(int)i {
    [self wg_addObject:@(i)];
}
- (void)wg_addInteger:(NSInteger)i {
    [self wg_addObject:@(i)];
}
- (void)wg_addChar:(char)c {
    [self wg_addObject:@(c)];
}
- (void)wg_addFloat:(float)f {
    [self wg_addObject:@(f)];
}
- (void)wg_addSize:(CGSize)size {
    [self wg_addObject:NSStringFromCGSize(size)];
}
- (void)wg_addPoint:(CGPoint)point {
    [self wg_addObject:NSStringFromCGPoint(point)];
}
- (void)wg_addRect:(CGRect)rect {
    [self wg_addObject:NSStringFromCGRect(rect)];
}
#pragma mark - 插入
- (void)wg_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject && index <= self.count) {
        [self insertObject:anObject atIndex:index];
    } else {
#ifdef DEBUG
        NSLog(@"插入数据[%@]失败, index[%@], arraycount[%@]", anObject, @(index), @(self.count));
#endif
    }
    
}
#pragma mark - 删除
- (void)wg_removeObject:(id)anObject {
    if (anObject) {
        [self removeObject:anObject];
    }
}
- (void)wg_removeObjectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        [self removeObjectAtIndex:index];
    } else {
#ifdef DEBUG
        NSLog(@"删除数据失败, index[%@], arraycount[%@]", @(index), @(self.count));
#endif
    }
}
- (void)wg_removeLastObject {
    [self removeLastObject];
}

- (void)wg_addObjectsFromArray:(NSArray *)otherArray {
    if (otherArray && [otherArray isKindOfClass:[NSArray class]]) {
        [self addObjectsFromArray:otherArray];
    }
}

#pragma mark - private
- (BOOL)wg_isMutableArray {
    return [NSStringFromClass(self.class) isEqualToString:NSStringFromClass([NSMutableArray class])];
}
@end
