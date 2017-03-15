//
//  WGAddAccountViewController.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/23.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WG_BaseTableViewController.h"

@class WGAccountInfo;
@interface WGAddAccountViewController : WG_BaseTableViewController
@property (nonatomic, strong) WGAccountInfo *info;
@property (nonatomic, copy) void (^saveAccountSuccessHandle)();
@end
