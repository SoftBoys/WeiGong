//
//  WGClassDetailViewController.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/16.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WG_BaseTableViewController.h"
#import "WGHomeInfo.h"
#import "WG_HomeClassItem.h"

@interface WGClassDetailViewController : WG_BaseTableViewController
@property (nonatomic, strong) WGHomeInfo *homeInfo;
@property (nonatomic, strong) WG_HomeClassItem *classItem;
@end
