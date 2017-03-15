//
//  WGMyWorkApplyListItem.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/24.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGMyWorkApplyListItem : NSObject
/** 职位id */
@property (nonatomic, assign) NSUInteger enterpriseJobId;

@property (nonatomic, copy) NSString *jobName;

@property (nonatomic, copy) NSString *updateDate;

@property (nonatomic, assign) NSInteger postStatus;
/** 投递id */
@property (nonatomic, assign) NSUInteger personalJobId;

@property (nonatomic, copy) NSString *huanXinGroupId;
/** 招聘人数 */
@property (nonatomic, assign) NSUInteger rNum;
/** 应聘人数 */
@property (nonatomic, assign) NSUInteger pNum;
/** 入选人数 */
@property (nonatomic, assign) NSUInteger sNum;


@end

@interface WGMyWorkArrangeListItem : NSObject

@property (nonatomic, assign) NSUInteger adminUserId;
/** 职位名称 */
@property (nonatomic, copy) NSString *jobName;
/** 联系人姓名 */
@property (nonatomic, copy) NSString *contactName;
/** 日期 (yyyyMMdd) */
@property (nonatomic, copy) NSString *workDate;
/** 联系人手机 */
@property (nonatomic, copy) NSString *contactMobile;
/** 联系人座机 */
@property (nonatomic, copy) NSString *contactPhone;
/** 开始时间 */
@property (nonatomic, copy) NSString *startTime;
/** 截止时间 */
@property (nonatomic, copy) NSString *stopTime;
/** 工作地址 */
@property (nonatomic, copy) NSString *address;
/** 工作id */
@property (nonatomic, assign) NSUInteger personalWorkId;


@end
