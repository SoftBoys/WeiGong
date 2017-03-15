//
//  WGWorkExperienceViewController.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/20.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WG_BaseTableViewController.h"
#import "WGWorkExperienceItem.h"

@class WGWorkExperienceItem;
typedef void(^WGWorkCallBackHandle)(NSArray<WGWorkExperienceItem*> *items, NSString *markNameList);
@interface WGWorkExperienceViewController : WG_BaseTableViewController

+ (instancetype)instanceWithCallBackHandle:(WGWorkCallBackHandle)handel;
@property (nonatomic, copy) WGWorkCallBackHandle handle;

@end
