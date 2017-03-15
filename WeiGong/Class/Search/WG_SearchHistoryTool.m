//
//  WG_SearchHisttoryTool.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/28.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_SearchHistoryTool.h"

#import <YTKKeyValueStore/YTKKeyValueStore.h>

@implementation WG_SearchHistoryTool

+ (NSArray<WG_SearchHistoryItem *> *)wg_historyItems {
    YTKKeyValueStore *store = [self store];
    
    NSString *tableName = @"wg_table_history";
    [store createTableWithName:tableName];
    
    NSArray<YTKKeyValueItem *> *array = [store getAllItemsFromTable:tableName];
    
    NSMutableArray<WG_SearchHistoryItem *> *historyItems = @[].mutableCopy;
    for (YTKKeyValueItem *ytkItem in array) {
        WG_SearchHistoryItem *item = [WG_SearchHistoryItem mj_objectWithKeyValues:ytkItem.itemObject];
        item.timeStamp = [[ytkItem createdTime] timeIntervalSince1970];
        [historyItems addObject:item];
    }
    [store close];
    NSArray *sortArray = [historyItems sortedArrayUsingComparator:^NSComparisonResult(WG_SearchHistoryItem *obj1, WG_SearchHistoryItem *obj2) {
        if (obj1.timeStamp >= obj2.timeStamp) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
    }];
    return sortArray;
}
+ (void)wg_saveHistoryItem:(WG_SearchHistoryItem *)item {
    YTKKeyValueStore *store = [self store];
    NSString *tableName = @"wg_table_history";

    [store putObject:[item mj_JSONObject] withId:item.key intoTable:tableName];
    [store close];
}

+ (void)wg_clearHistory {
    YTKKeyValueStore *store = [self store];
    [store clearTable:@"wg_table_history"];
}

+ (YTKKeyValueStore *)store {
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:@"wg_history.db"];
    return store;
}
@end

@implementation WG_SearchHistoryItem


@end