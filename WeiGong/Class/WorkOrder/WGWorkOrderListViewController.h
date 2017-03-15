//
//  WGWorkOrderListViewController.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/23.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WG_BaseTableViewController.h"

@interface WGWorkOrderListViewController : WG_BaseTableViewController
/** 订单状态：0全部、1待支付、2待确认、3已确认 */
@property (nonatomic, assign) NSInteger orderFlag;

@end
