//
//  WGBasicInfoBaseCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/6.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WG_AccessoryIndicatorCell.h"
#import "WGBasicInfoCellItem.h"

@interface WGBasicInfoBaseCell : WG_AccessoryIndicatorCell
@property (nonatomic, strong) WGBasicInfoCellItem *cellItem;
@end
