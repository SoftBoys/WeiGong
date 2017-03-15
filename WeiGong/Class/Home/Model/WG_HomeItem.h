//
//  WG_HomeItem.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/12.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WG_HomeItem : NSObject
/** 职位id */
@property (nonatomic, copy) NSString *enterpriseJobId;  //职位id
/** 职位名称 */
@property (nonatomic, copy) NSString *jobName;//职位名称
/** 企业名称 */
@property (nonatomic, copy) NSString *enterpriseName; //企业名称
/** 企业id */
@property (nonatomic, copy) NSString *enterpriseInfoId;  //企业id
/** 结算周期 */
@property (nonatomic, copy) NSString *payCycle;
/** 结算方式 */
@property (nonatomic, copy) NSString *payStyle;
/** 职位图片Url */
@property (nonatomic, copy) NSString *jobUrl;
/** 标签名字 */
@property (nonatomic, copy) NSString *markName;
@property (nonatomic, copy) NSString *markNameUrl;
@property (nonatomic, copy) NSString *markNameUrlSm;
/** 地址 */
@property (nonatomic, copy) NSString *address;
/** 薪酬 */
@property (nonatomic, copy) NSString *salary; //
/** 薪酬标准（月，天） */
@property (nonatomic, copy) NSString *salaryStandard; //薪酬标准
/** 福利 */
@property (nonatomic, copy) NSString *welfare;
/** 工作区域（朝阳区） */
@property (nonatomic, copy) NSString *locationName;
/** 平台奖励，1：有，0：没有 */
@property (nonatomic, assign) NSInteger platformReward;
/** 协议v 0:不显示,1:显示v */
@property (nonatomic, assign) NSInteger protocolFlag;
/** 职位日期 (05/11~12/29) */
@property (nonatomic, copy) NSString *jobDates;
/** 职位时间 （逗号分隔的字符串） */
@property (nonatomic, copy) NSString *jobTimes;
/** 平台支付，0：没有，1：有 */
@property (nonatomic, assign) NSInteger platformPay;
/** 是否显示V  2显示 */
@property (nonatomic,strong) NSString *checkFlag;  //是否显示V  2显示
/** 详情页Url */
@property (nonatomic, copy) NSString *jobDetailUrl;
@end
