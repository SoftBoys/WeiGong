//
//  WGApplyJobViewController+Calander.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/3.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGApplyJobViewController.h"

@class WG_JobDetail, WGApplyJobCollectionItem;
@interface WGApplyJobViewController (Calander)
- (NSArray <NSArray *> *)monthsWithJobDetail:(WG_JobDetail *)detail;
@end
