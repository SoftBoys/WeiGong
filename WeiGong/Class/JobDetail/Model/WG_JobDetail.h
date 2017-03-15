//
//  WG_JobDetail.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/7.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WG_JobAddressItem, WG_JobTimeItem;
@interface WG_JobDetail : NSObject
/** 企业Id */
@property (nonatomic, assign) NSUInteger enterpriseInfoId;
/** 企业职位Id */
@property (nonatomic, assign) NSUInteger enterpriseJobId;
/** 企业名称 */
@property (nonatomic, copy) NSString *enterpriseName;

@property (nonatomic, copy) NSString *jobName;
/** 工作要求 */
@property (nonatomic, copy) NSString *jobRequire;
/** 工作要求标签字符串(,间隔) */
@property (nonatomic, copy) NSString *requireStr;
/** 工作内容 */
@property (nonatomic, copy) NSString *jobDesc;

@property (nonatomic, copy) NSString *dateStart;
@property (nonatomic, copy) NSString *dateStop;
@property (nonatomic, copy) NSString *jobTimeStr;

@property (nonatomic, copy) NSArray<WG_JobAddressItem *> *jobplaces;
@property (nonatomic, copy) NSArray<WG_JobTimeItem *> *jobTimes;

/** 招聘人数 */
@property (nonatomic, assign) NSUInteger recruitNum;
/** 薪酬 */
@property (nonatomic, strong) NSNumber *salary;
/** 薪酬标准 */
@property (nonatomic, copy) NSString *salaryStandard;
/** 支付周期 */
@property (nonatomic, copy) NSString *payCycle;
/** 支付方式 */
@property (nonatomic, copy) NSString *payStyle;
/** 显示协议内容（0不显示 1显示） */
@property (nonatomic, assign) NSUInteger protocolFlag;
/** 协议内容 */
@property (nonatomic, copy) NSString *protocolFlagContent;
/** 1显示平台结算 */
@property (nonatomic, assign) NSUInteger platformPay;
/** 平台奖励 1有 0无*/
@property (nonatomic, assign) NSUInteger platformReward;
/** 奖励文本内容 */
@property (nonatomic, copy) NSString *platformRewardContent;
/** 1男 2女*/
@property (nonatomic, assign) NSUInteger sex;
/** 福利待遇 (,间隔的字符串)*/
@property (nonatomic, copy) NSString *welfare;
/** 是否收藏 */
@property (nonatomic, assign) NSUInteger favorite;


/** 详情页Url */
@property (nonatomic, copy) NSString *jobDetailUrl;
/** 群组id */
@property (nonatomic, copy) NSString *huanXinGroupId;
/** 是否过期 2:过期  */
@property (nonatomic, assign) NSInteger overdue;
/** personalJobId==0 :立即申请 personalJobId!=0&&postFlag==1:撤销申请  personalJobId!=0&&postFlag!=1:已经申请 */
@property (nonatomic, assign) NSInteger postFlag;
/** 投递id */
@property (nonatomic, assign) NSInteger personalJobId;
@end

@interface WG_JobAddressItem : NSObject
/** 1表示默认 0非默认 */
@property (nonatomic, assign) NSUInteger defaultFlag;
/** 百度纬度 */
@property (nonatomic, assign) double baiduLat;
/** 百度经度 */
@property (nonatomic, assign) double baiduLon;
/** 高德纬度 */
@property (nonatomic, assign) double gaodeLat;
/** 高德经度 */
@property (nonatomic, assign) double gaodeLon;

@property (nonatomic, assign) NSUInteger enterpriseJobplaceId;
/** 职位详细地址 */
@property (nonatomic, copy) NSString *jobAddress;
/** 定位地点 */
@property (nonatomic, copy) NSString *jobLocationDetail;

@property (nonatomic, assign) NSUInteger jobLocationId;
/** 地点名称 */
@property (nonatomic, copy) NSString *locationName;

@property (nonatomic, copy) NSString *cityName;

@end

@interface WG_JobTimeItem : NSObject
@property (nonatomic, assign) NSInteger enterpriseJobId;
@property (nonatomic, assign) NSInteger enterpriseInfoId;
@property (nonatomic, copy) NSString *createDate;
/** HH:mm */
@property (nonatomic, copy) NSString *startTime;
/** HH:mm */
@property (nonatomic, copy) NSString *stopTime;
@end
