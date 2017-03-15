//
//  WGApplyJobDateCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/2.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WG_BaseTableViewCell.h"

@class WGApplyJobListItem;
@interface WGApplyJobDateCell : WG_BaseTableViewCell
@property (nonatomic, strong) WGApplyJobListItem *item;

@property (nonatomic, copy) void (^refreshHandle)();

@end
