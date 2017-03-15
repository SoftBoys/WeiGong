//
//  WGBasicInfoViewController+More.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/6.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGBasicInfoViewController.h"

@class WGBasicInfo,WGBasicInfoCellItem;
@interface WGBasicInfoViewController (More)

- (NSArray<NSArray *> *)getCellItemsWithInfo:(WGBasicInfo *)info moreCellIsOn:(BOOL)isOn;


@end
