//
//  WG_JobDetail.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/7.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_JobDetail.h"

@implementation WG_JobDetail

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"jobplaces":[WG_JobAddressItem class],
             @"jobTimes":[WG_JobTimeItem class]};
}
+ (NSDictionary *)wg_dictWithModelReplacedKey {
    return @{@"jobDetailUrl":@"newJobUrl"};
}
@end

@implementation WG_JobAddressItem

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"baiduLat":@"baiduLatitude",
             @"baiduLon":@"baiduLongitude",
             @"gaodeLat":@"gaodeLatitude",
             @"gaodeLon":@"gaodeLongitude"};
}

@end

@implementation WG_JobTimeItem


@end
