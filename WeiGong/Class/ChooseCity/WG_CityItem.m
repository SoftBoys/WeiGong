//
//  WG_CityItem.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/14.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_CityItem.h"

#import "WGDataBaseTool.h"

@implementation WG_CityItem
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"cityCode":@"id",
             @"city":@"name",
             @"subItems":@"item"};
}
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"subItems":[WG_CityItem class]};
}

@end

@implementation WG_CityTool

+ (NSArray<WG_CityItem *> *)getCityItemArray {
    
    NSString *cityId = kCityListKey;
    NSArray *array = [WGDataBaseTool getObjectById:cityId];
    
    NSArray *items = [WG_CityItem wg_modelArrayWithDictArray:array];
    if (items) {
        return items;
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"WG_City.plist" ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *citys = [WG_CityItem mj_objectArrayWithKeyValuesArray:dict[@"location"]];
    return citys;
}

+ (void)setCityItems:(NSArray<WG_CityItem *> *)cityItems {
    NSString *cityId = kCityListKey;
    NSArray *array = [WG_CityItem wg_dictArrayWithModelArray:cityItems];
    
    [WGDataBaseTool putObject:array withId:cityId];
}

@end
