//
//  WGMyWorkViewController.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/19.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WG_BaseTableViewController.h"

@interface WGMyWorkViewController : WG_BaseTableViewController
/** 0:申请 1:录用 2:待上岗 3:完工 */
@property (nonatomic, assign) NSInteger status;

@end
