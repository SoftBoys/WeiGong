//
//  WG_MineCommitCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/21.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_BaseTableViewCell.h"

@protocol WG_MineCommitCellDelegate <NSObject>

- (void)wg_unSureTap;
- (void)wg_unCommitTap;
- (void)wg_commitTap;
@end

@class WG_MineUser;
@interface WG_MineCommitCell : WG_BaseTableViewCell
@property (nonatomic, strong) WG_MineUser *user;
@property (nonatomic, weak) id<WG_MineCommitCellDelegate> delegate;
@end
