//
//  WGApplyJobListItem.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/2.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WG_JobAddressItem, WG_JobTimeItem;
@interface WGApplyJobListItem : NSObject
/** 0:要求  1:工作地点  2:上岗时段  3:上岗日期 */
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) WG_JobAddressItem *addressItem;

@property (nonatomic, strong) WG_JobTimeItem *timeItem;
/** 月份 */
@property (nonatomic, copy) NSArray<NSArray *> *monthList;

@end
