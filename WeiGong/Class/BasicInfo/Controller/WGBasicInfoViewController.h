//
//  WGBasicInfoViewController.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/19.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WG_BaseTableViewController.h"

@class WG_CityItem;
@interface WGBasicInfoViewController : WG_BaseTableViewController

@property (nonatomic, assign) BOOL moreCellIsOn;

@property (nonatomic, strong) WG_CityItem *cityItem;

@end
