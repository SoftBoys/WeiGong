//
//  WGMyWorkDetailAddressCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/25.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WG_BaseTableViewCell.h"

@class WGMyWorkDetail;
@interface WGMyWorkDetailAddressCell : WG_BaseTableViewCell
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) WGMyWorkDetail *workDetail;
@end
