//
//  WG_SettingCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/21.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_AccessoryIndicatorCell.h"
#import "WG_SettingItem.h"

@interface WG_SettingCell : WG_AccessoryIndicatorCell
@property (nonatomic, strong) WG_SettingItem *item;
@end
