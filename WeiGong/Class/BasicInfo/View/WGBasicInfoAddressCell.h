//
//  WGBasicInfoAddressCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/6.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGBasicInfoBaseCell.h"

@protocol WGBasicInfoAddressCellDelegate <NSObject>

- (void)modifyaddressItemWithCellItem:(WGBasicInfoCellItem *)cellItem;

@end

@interface WGBasicInfoAddressCell : WGBasicInfoBaseCell
@property (nonatomic, weak) id<WGBasicInfoAddressCellDelegate> delegate;
@end
