//
//  WGNearMenuView.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/7.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WG_DropDownMenu.h"

@interface WGNearMenuView : UIView
@property (nonatomic, copy, readonly) NSArray *menuDistanceList; //数据源
@property (nonatomic, copy) void (^chooseDistanceHandle)(NSInteger distance);

@end
