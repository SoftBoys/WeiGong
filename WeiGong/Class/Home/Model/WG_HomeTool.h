//
//  WG_HomeTool.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/14.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WG_CityItem, WG_HomeItem, WGHomeInfo;
@interface WG_HomeTool : NSObject
/** 保存当前城市数据 */
+ (void)saveCurrentCityItem:(WG_CityItem *)item;
/** 获取当前城市数据 */
+ (WG_CityItem *)getCurrentCityItem;


+ (NSArray<WG_HomeItem *> *)wg_homeCacheItems;

+ (void)wg_setCacheItems:(NSArray<WG_HomeItem *> *)items;

+ (void)saveHomeInfo:(WGHomeInfo *)info;
+ (WGHomeInfo *)homeInfo;

@end
