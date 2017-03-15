//
//  WG_MineAuthCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/21.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_AccessoryIndicatorCell.h"

@class WG_MineCellItem;
@protocol WG_MineAccountCellDelegate <NSObject>

- (void)clickCellAccountWithItem:(WG_MineCellItem *)item;

@end
@interface WG_MineAuthCell : WG_AccessoryIndicatorCell
@property (nonatomic, strong) WG_MineCellItem *item;
@property (nonatomic, weak) id <WG_MineAccountCellDelegate> delegate;
@end
