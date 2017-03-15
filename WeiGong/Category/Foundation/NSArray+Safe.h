//
//  NSMutableArray+Safe.h
//  自定义小控件
//
//  Created by dfhb@rdd on 16/11/25.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSArray (Safe)

- (id)wg_objectAtIndex:(NSUInteger)index;
- (NSString *)wg_stringAtIndex:(NSUInteger)index;
- (NSArray *)wg_arrayAtIndex:(NSUInteger)index;
- (NSDictionary *)wg_dictionaryAtIndex:(NSUInteger)index;
- (NSInteger)wg_integerAtIndex:(NSUInteger)index;
- (float)wg_floatAtIndex:(NSUInteger)index;
- (double)wg_doubleAtIndex:(NSUInteger)index;

@end

@interface NSMutableArray (Safe)

- (void)wg_addObject:(id)anObject;
- (void)wg_addBool:(BOOL)i;
- (void)wg_addInt:(int)i;
- (void)wg_addInteger:(NSInteger)i;
- (void)wg_addChar:(char)c;

- (void)wg_addFloat:(float)f;
- (void)wg_addSize:(CGSize)size;
- (void)wg_addPoint:(CGPoint)point;
- (void)wg_addRect:(CGRect)rect;

- (void)wg_insertObject:(id)anObject atIndex:(NSUInteger)index;

- (void)wg_removeObject:(id)anObject;
- (void)wg_removeObjectAtIndex:(NSUInteger)index;
- (void)wg_removeLastObject;

- (void)wg_addObjectsFromArray:(NSArray *)otherArray;
@end
