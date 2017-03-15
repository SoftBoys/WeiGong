//
//  WG_JobContentCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/7.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_BaseTableViewCell.h"

@class WG_JobDetail;
@interface WG_JobContentCell : WG_BaseTableViewCell
/** 0(工作内容) 1(工作要求) */
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) WG_JobDetail *detail;
@end
