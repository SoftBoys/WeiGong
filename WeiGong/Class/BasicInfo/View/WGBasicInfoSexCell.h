//
//  WGBasicInfoSexCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/6.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGBasicInfoBaseCell.h"

@protocol WGBasicInfoSexCellDelegate <NSObject>

- (void)actionSheetWithItem:(WGBasicInfoCellItem *)item;

@end

@interface WGBasicInfoSexCell : WGBasicInfoBaseCell
@property (nonatomic, weak) id<WGBasicInfoSexCellDelegate> delegate;
@end
