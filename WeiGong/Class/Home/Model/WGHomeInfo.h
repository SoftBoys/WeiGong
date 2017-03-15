//
//  WGHomeInfo.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/16.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WG_HomeBannerItem, WG_HomeItem, WG_CityItem, WG_HomeClassItem;
@interface WGHomeInfo : NSObject
@property (nonatomic, strong) WG_CityItem *city;
@property (nonatomic, copy) NSArray <WG_HomeBannerItem *>*bannerItems;
@property (nonatomic, copy) NSArray <WG_HomeClassItem *>*classItems;
@property (nonatomic, copy) NSArray <WG_HomeItem *>*homeItems;
@end
