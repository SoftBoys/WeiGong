//
//  WGBasicInfoMoreCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/6.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGBasicInfoBaseCell.h"

@protocol WGBasicInfoMoreCellDelegate <NSObject>

- (void)modifyMoreCellStatuWithItem:(WGBasicInfoCellItem *)cellItem;

@end

@interface WGBasicInfoMoreCell : WGBasicInfoBaseCell
@property (nonatomic, weak) id<WGBasicInfoMoreCellDelegate> delegate;
@end
