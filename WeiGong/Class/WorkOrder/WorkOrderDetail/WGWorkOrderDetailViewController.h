//
//  WGWorkOrderDetailViewController.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/23.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WG_BaseTableViewController.h"

@class WGWorkOrderListItem;
@interface WGWorkOrderDetailViewController : WG_BaseTableViewController
@property (nonatomic, strong) WGWorkOrderListItem *listItem;
@end
