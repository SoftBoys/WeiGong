//
//  WGApplyJobViewController.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/27.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WG_BaseTableViewController.h"

@class WG_JobDetail;
@interface WGApplyJobViewController : WG_BaseTableViewController
@property (nonatomic, strong) WG_JobDetail *detail;

@property (nonatomic, copy) void (^submitSuccessHandle)();

@end
