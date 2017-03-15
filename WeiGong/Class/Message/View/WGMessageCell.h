//
//  WGMessageCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/18.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WG_BaseTableViewCell.h"

@class WGMessageItem;
@interface WGMessageCell : WG_BaseTableViewCell
@property (nonatomic, strong) WGMessageItem *item;
@end
