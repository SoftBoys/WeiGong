//
//  WG_TypeTool.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/26.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_TypeTool.h"
#import "WGDataBaseTool.h"
#import "WGDataTypeItem.h"

@implementation WG_TypeTool

+ (NSArray<WGDataTypeItem *> *)wg_typeJobPositionList {
    NSArray *typelist = [self wg_typeList];
    NSMutableArray *newList = [@[] mutableCopy];
    for (WGDataTypeItem *item in typelist) {
        if (item.typeId == 11) {
            [newList addObject:item];
        }
    }
    return [newList copy];
}
+ (NSArray<WGDataTypeItem *> *)wg_typeEducationPositionList {
    NSArray *typelist = [self wg_typeList];
    NSMutableArray *newList = [@[] mutableCopy];
    for (WGDataTypeItem *item in typelist) {
        if (item.typeId == 15) {
            [newList addObject:item];
        }
    }
    return [newList copy]; 
}

+ (NSArray<WGDataTypeItem *> *)wg_typeList {
    
    NSArray *dataCode = [WGDataBaseTool getObjectById:kDataCodeKey];
    NSArray <WGDataTypeItem *> *list = [WGDataTypeItem wg_modelArrayWithDictArray:dataCode];
    
    if (list) {
        return list;
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"WG_Type.plist" ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    //    NSLog(@"%@",dict);
    NSArray *typeArray = [WGDataTypeItem mj_objectArrayWithKeyValuesArray:dict[@"typeList"]];
    return typeArray;
}

@end
