//
//  WG_MineViewController+WG_Extension.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/21.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_MineViewController.h"

@class WG_MineCellItem;
@interface WG_MineViewController (WG_Extension)
/** 没登录的Items */
- (NSArray <NSArray*>*)wg_cellItemSectionsNoLogin;

/** 登录(无社保)的Items */
- (NSArray <NSArray *>*)wg_cellItemSectionsNoAgile;

/** 登录(有社保)的Items */
- (NSArray <NSArray *>*)wg_cellItemSectionsHaveAgile;
@end
