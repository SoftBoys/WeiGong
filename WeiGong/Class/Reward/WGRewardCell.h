//
//  WGRewardCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/15.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WG_AccessoryIndicatorCell.h"

@class WGRewardItem;
@interface WGRewardCell : WG_AccessoryIndicatorCell
@property (nonatomic, strong) WGRewardItem *item;

@property (nonatomic, copy) NSString *scanUrl;
@end
