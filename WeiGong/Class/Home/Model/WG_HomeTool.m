//
//  WG_HomeTool.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/14.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_HomeTool.h"
#import "WG_CityItem.h"
#import "WG_HomeItem.h"
#import "WGHomeInfo.h"
#import "WGDataBaseTool.h"


NSString *const kItemKey = @"kCityKey";
@implementation WG_HomeTool

+ (void)saveCurrentCityItem:(WG_CityItem *)item {
    [WGDataBaseTool putObject:[item wg_keyValues] withId:kItemKey];
}

+ (WG_CityItem *)getCurrentCityItem {
    NSDictionary *dict = [WGDataBaseTool getObjectById:kItemKey];
    WG_CityItem *item = [WG_CityItem wg_modelWithDictionry:dict];
    return item;
}

+ (void)wg_setCacheItems:(NSArray<WG_HomeItem *> *)items {
    
    NSString *homeCacheKey = @"homeCacheKey";
    NSArray *array = [WG_HomeItem wg_dictArrayWithModelArray:items];
    if (array) {
        [WGDataBaseTool putObject:array withId:homeCacheKey];
    }
}
+ (NSArray<WG_HomeItem *> *)wg_homeCacheItems {
    
    NSString *homeCacheKey = @"homeCacheKey";
    
    NSArray *array = [WGDataBaseTool getObjectById:homeCacheKey];
    NSArray *items = [WG_HomeItem wg_modelArrayWithDictArray:array];
    return items;
}

+ (void)saveHomeInfo:(WGHomeInfo *)info {
    
    NSString *infoKey = @"infoKey";
    NSDictionary *dict = [info wg_keyValues];
    if (dict) {
        [WGDataBaseTool putObject:dict withId:infoKey];
    }
}
+ (WGHomeInfo *)homeInfo {
    NSString *infoKey = @"infoKey";
    NSDictionary *dict = [WGDataBaseTool getObjectById:infoKey];
    return [WGHomeInfo wg_modelWithDictionry:dict];
}

@end
