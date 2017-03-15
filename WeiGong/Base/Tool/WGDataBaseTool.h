//
//  WGDataBaseTool.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/2.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *kCityListKey = @"cityId";
static NSString *kDataCodeKey = @"dataCode";

@interface WGDataBaseTool : NSObject

+ (void)putObject:(id)object withId:(NSString *)objectId;
+ (void)putObject:(id)object withId:(NSString *)objectId intoTable:(NSString *)tableName;
+ (id)getObjectById:(NSString *)objectId;
+ (id)getObjectById:(NSString *)objectId fromTable:(NSString *)tableName;

+ (void)clearTable:(NSString *)tableName;

@end
