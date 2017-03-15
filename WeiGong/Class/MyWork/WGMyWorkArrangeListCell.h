//
//  WGMyWorkArrangeListCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/24.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WG_AccessoryIndicatorCell.h"

@class WGMyWorkArrangeListItem;
@interface WGMyWorkArrangeListCell : WG_AccessoryIndicatorCell
@property (nonatomic, strong) WGMyWorkArrangeListItem *item;
@end
