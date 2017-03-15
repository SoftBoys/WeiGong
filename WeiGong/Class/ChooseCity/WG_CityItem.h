//
//  WG_CityItem.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/14.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WG_CityItem : NSObject

@property (nonatomic, assign) NSUInteger cityCode;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSArray <WG_CityItem *> *subItems;
@end

@interface WG_CityTool : NSObject

+ (NSArray <WG_CityItem *> *)getCityItemArray;

+ (void)setCityItems:(NSArray <WG_CityItem *> *)cityItems;

@end

