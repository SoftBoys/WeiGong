//
//  WGWordOrderDetail.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/23.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WGWorkOrderDetailListItem;
@interface WGWorkOrderDetail : NSObject

/** 订单id */
@property (nonatomic, assign) NSInteger enterpriseOrderNewId;
/** 职位名称 */
@property (nonatomic, copy) NSString *jobName;
/** 订单日期 */
@property (nonatomic, copy) NSString *createDate;

/** 订单状态 */
@property (nonatomic, assign) NSInteger orderFlag;
/** 订单状态名称 */
@property (nonatomic, copy) NSString *orderFlagName;
/** 实付金额 */
@property (nonatomic, copy) NSString *realMoney;
/** 订单描述 */
@property (nonatomic, copy) NSString *orderDesc;

/** 支付日期 */
@property (nonatomic, copy) NSString *paymentDate;
/** 支付方式 */
@property (nonatomic, assign) NSInteger paymentFlag;
/** 支付方式名称 */
@property (nonatomic, copy) NSString *paymentFlagName;
/** 账户类型 */
@property (nonatomic, copy) NSString *accountType;
/** 账户类型名称 */
@property (nonatomic, copy) NSString *accountTypeName;
/** 账号 */
@property (nonatomic, copy) NSString *accountId;
/** 姓名 */
@property (nonatomic, copy) NSString *accountName;
/** 银行 */
@property (nonatomic, copy) NSString *accountBank;

@property (nonatomic, copy) NSArray <WGWorkOrderDetailListItem *> *workList;

/** 个人确认状态 */
@property (nonatomic, assign) NSInteger personalFlag;
/** 个人确认时间 */
@property (nonatomic, copy) NSString *personalFlagDate;
/** 状态 */
@property (nonatomic, assign) NSInteger flag;


@end

@interface WGWorkOrderDetailListItem : NSObject
/** 工作日期 */
@property (nonatomic, copy) NSString *workDate;
/** 上岗时间 */
@property (nonatomic, copy) NSString *startTime;
/** 下岗时间 */
@property (nonatomic, copy) NSString *stopTime;
/** 工作地址 */
@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *hours;

@property (nonatomic, copy) NSString *salaryDay;
/** 工作日期 */
@property (nonatomic, copy) NSString *workDateV;

@property (nonatomic, copy) NSString *hoursV;

@property (nonatomic, copy) NSString *salaryDayV;

@end
