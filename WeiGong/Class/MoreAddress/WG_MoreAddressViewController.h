//
//  WG_MoreAddressViewController.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/9.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_BaseTableViewController.h"

@class WG_JobAddressItem;
@interface WG_MoreAddressViewController : WG_BaseTableViewController

@property (nonatomic, copy) NSArray<WG_JobAddressItem *> *joblist;
@end
