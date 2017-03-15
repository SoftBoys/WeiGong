//
//  WGNearMapItem.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/7.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>

#import "WG_HomeItem.h"

@interface WGNearMapItem : WG_HomeItem

@property (nonatomic, copy) NSString *baiduLatitude;
@property (nonatomic, copy) NSString *baiduLongitude;
@property (nonatomic, copy) NSString *distance;

@property (nonatomic, strong) BMKPointAnnotation *item;

@end
