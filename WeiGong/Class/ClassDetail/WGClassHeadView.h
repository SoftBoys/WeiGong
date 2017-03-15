//
//  WGClassHeadView.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/16.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WG_HomeClassItem.h"

@interface WGClassHeadView : UIView

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) WG_HomeClassItem *classItem;

@end
