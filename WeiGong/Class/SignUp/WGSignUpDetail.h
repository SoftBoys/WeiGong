//
//  WGSignUpDetail.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/26.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WGSignUpListItem;
@interface WGSignUpDetail : NSObject

@property (nonatomic, copy) NSString *serverDate;

@property (nonatomic, copy) NSString *addressStr;
/** 服务器时间戳 (毫秒) */
@property (nonatomic, assign) NSTimeInterval currentTime;

@property (nonatomic, copy) NSArray <WGSignUpListItem *>*jobList;

@end

@interface WGSignUpListItem : NSObject
/** 职位名称 */
@property (nonatomic, copy) NSString *jobName;
/** 排班主键 */
@property (nonatomic, assign) long personalWorkId;
/** 工作地址 */
@property (nonatomic, copy) NSString *address;
/** 工作日期 */
@property (nonatomic, copy) NSString *workDate;
/** 上班时间 */
@property (nonatomic, copy) NSString *startTime;
/** 下班时间 */
@property (nonatomic, copy) NSString *stopTime;
/** 上班标示1:已经打卡 */
@property (nonatomic, assign) NSInteger startFlag;
/** 下班标示1：已经打卡 */
@property (nonatomic, assign) NSInteger stopFlag;
/** 上班打卡时间 */
@property (nonatomic, copy) NSString *startDate;
/** 下班打卡时间 */
@property (nonatomic, copy) NSString *stopDate;
/** 定位距离 */
@property (nonatomic, assign) CGFloat distance;
/** 上班打卡距离 */
@property (nonatomic, assign) CGFloat startDistance;
/** 下班打卡距离 */
@property (nonatomic, assign) CGFloat stopDistance;
@end
