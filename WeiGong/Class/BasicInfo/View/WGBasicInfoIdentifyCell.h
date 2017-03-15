//
//  WGBasicInfoIdentifyCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/6.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGBasicInfoBaseCell.h"

@protocol WGBasicInfoIdentifyCellDelegate <NSObject>

- (void)modifyIdentifyWithCellItem:(WGBasicInfoCellItem *)cellItem;

@end

@interface WGBasicInfoIdentifyCell : WGBasicInfoBaseCell
@property (nonatomic, weak) id<WGBasicInfoIdentifyCellDelegate> delegate;
@end
