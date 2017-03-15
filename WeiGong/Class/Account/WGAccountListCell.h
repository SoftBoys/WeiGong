//
//  WGAccountListCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/22.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WG_BaseTableViewCell.h"

@class WGAccountListItem;
@protocol WGAccountListCellDelegate <NSObject>

- (void)tapAccountBoxWithItem:(WGAccountListItem *)item;

@end
@interface WGAccountListCell : WG_BaseTableViewCell
@property (nonatomic, strong) WGAccountListItem *item;
@property (nonatomic, weak) id<WGAccountListCellDelegate> delegate;
@end
