//
//  WG_MineWalletCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/21.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_BaseTableViewCell.h"

@protocol WG_MineWalletCellDelegate <NSObject>

- (void)wg_tapWallet;

- (void)wg_tapRewards;

@end
@interface WG_MineWalletCell : WG_BaseTableViewCell
@property (nonatomic, weak) id<WG_MineWalletCellDelegate> delegate;
@end
