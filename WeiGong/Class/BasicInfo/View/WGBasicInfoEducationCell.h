//
//  WGBasicInfoEducationCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/6.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGBasicInfoBaseCell.h"

@protocol WGBasicInfoEducationCellDelegate <NSObject>

- (void)modifyHeightWithCellItem:(WGBasicInfoCellItem *)cellItem;
- (void)modifyWeightWithCellItem:(WGBasicInfoCellItem *)cellItem;
- (void)modifyEducationWithCellItem:(WGBasicInfoCellItem *)cellItem;

@end

@interface WGBasicInfoEducationCell : WGBasicInfoBaseCell
@property (nonatomic, weak) id<WGBasicInfoEducationCellDelegate> delegate;
@end
