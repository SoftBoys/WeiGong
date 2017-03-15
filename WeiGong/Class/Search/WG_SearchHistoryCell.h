//
//  WG_SearchHistoryCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/28.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_AccessoryIndicatorCell.h"

@class WG_SearchHistoryItem;
@interface WG_SearchHistoryCell : WG_AccessoryIndicatorCell
@property (nonatomic, strong) WG_SearchHistoryItem *item;

+ (UIImage *)backImageWithColor:(UIColor *)color;
@end
