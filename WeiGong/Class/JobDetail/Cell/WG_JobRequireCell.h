//
//  WG_JobRequireCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/7.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_BaseTableViewCell.h"

@class WG_JobDetail;
@interface WG_JobRequireCell : WG_BaseTableViewCell
@property (nonatomic, strong) WG_JobDetail *detail;
@end
