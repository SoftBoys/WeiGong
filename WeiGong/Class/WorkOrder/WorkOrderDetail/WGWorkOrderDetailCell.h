//
//  WGWorkOrderDetailCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/24.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WG_BaseTableViewCell.h"

@class WGWorkOrderDetail;
@interface WGWorkOrderDetailCell : WG_BaseTableViewCell
@property (nonatomic, strong) WGWorkOrderDetail *orderDetail;
@end
