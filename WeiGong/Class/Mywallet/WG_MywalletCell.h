//
//  WG_MywalletCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/4.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_BaseTableViewCell.h"

@class WG_MywalletAccountItem;
@interface WG_MywalletCell : WG_BaseTableViewCell
@property (nonatomic, strong) WG_MywalletAccountItem *item;
@end
