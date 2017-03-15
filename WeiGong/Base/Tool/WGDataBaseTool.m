//
//  WGDataBaseTool.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/2.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGDataBaseTool.h"

#import <YTKKeyValueStore/YTKKeyValueStore.h>

static NSString *kDefaultDBName = @"default_weigong.db";
static NSString *KDefaultTableName = @"default_table";

@interface WGDataBaseTool ()
@property (nonatomic, strong) YTKKeyValueStore *store;
@end
@implementation WGDataBaseTool

+ (YTKKeyValueStore *)defaultStore {
    return [[YTKKeyValueStore alloc] initDBWithName:kDefaultDBName];
}
+ (void)putObject:(id)object withId:(NSString *)objectId {
    [self putObject:object withId:objectId intoTable:KDefaultTableName];
}
+ (void)putObject:(id)object withId:(NSString *)objectId intoTable:(NSString *)tableName {
    if (objectId == nil) {
        WGLog(@"存储数据时 id is nil");
        return ;
    }
    YTKKeyValueStore *store = [self defaultStore];
    [store createTableWithName:tableName];
    [store putObject:object withId:objectId intoTable:tableName];
    [store close];
}
+ (id)getObjectById:(NSString *)objectId {
    return [self getObjectById:objectId fromTable:KDefaultTableName];
}
+ (id)getObjectById:(NSString *)objectId fromTable:(NSString *)tableName {
    if (objectId == nil) {
        WGLog(@"读取本地数据时 id is nil");
        return nil;
    }
    YTKKeyValueStore *store = [self defaultStore];
    [store createTableWithName:tableName];
    id object = [store getObjectById:objectId fromTable:tableName];
    [store close];
    return object;
}

+ (void)clearTable:(NSString *)tableName {
    if (tableName == nil) {
        WGLog(@"tableName is nil ... ");
        return;
    }
    YTKKeyValueStore *store = [self defaultStore];
    [store clearTable:tableName];
    [store close];
}
@end
