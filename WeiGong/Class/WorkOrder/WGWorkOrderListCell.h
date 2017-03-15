//
//  WGWorkOrderListCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/23.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WG_BaseTableViewCell.h"

@class WGWorkOrderListItem;
@interface WGWorkOrderListCell : WG_BaseTableViewCell
@property (nonatomic, strong) WGWorkOrderListItem *item;
@end

@interface WGWorkOrderListItem : NSObject
/** 订单id */
@property (nonatomic, assign) NSUInteger enterpriseOrderNewId;
/** 岗位名称 */
@property (nonatomic, copy) NSString *jobName;
/** 订单日期 */
@property (nonatomic, copy) NSString *createDate;
/** 订单状态 */
@property (nonatomic, assign) NSInteger orderFlag;
/** 订单状态名称 */
@property (nonatomic, copy) NSString *orderFlagName;
/** 实际支付金额 */
@property (nonatomic, copy) NSString *realMoney;



@end
