//
//  WGHomeInfo.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/16.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGHomeInfo.h"
#import "WG_HomeItem.h"
#import "WG_HomeBannerItem.h"
#import "WG_HomeClassItem.h"

@implementation WGHomeInfo

+ (NSDictionary *)wg_dictWithModelClassInArray {
    return @{@"bannerItems":[WG_HomeBannerItem class],
             @"homeItems":[WG_HomeItem class],
             @"classItems":[WG_HomeClassItem class]};
}

@end
