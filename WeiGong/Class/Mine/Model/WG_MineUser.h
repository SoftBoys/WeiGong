//
//  WG_MineUser.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/18.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WG_MineUser : NSObject

@property (nonatomic, copy) NSString *loginNum;

/** picUrl */
@property (nonatomic, copy) NSString *iconUrl;
/** 名称 */
@property (nonatomic, copy) NSString *personalName;
/** 电话 */
@property (nonatomic, copy) NSString *mobile;
/** userid */
@property (nonatomic, strong) NSNumber *personalInfoId;

@property (nonatomic, strong) NSNumber *adminUserId;

@property (nonatomic, copy) NSString *huanxinUserName;

@property (nonatomic, assign) NSUInteger checkFlag;
/** 社保状态 0无  非0有 */
@property (nonatomic, assign) NSUInteger agileFlag;



@property (nonatomic, assign) NSUInteger collectCount;

@property (nonatomic, assign) NSUInteger creditCount;

@property (nonatomic, assign) NSUInteger rejectCount;



@property (nonatomic, assign) NSUInteger unSureCount;

@property (nonatomic, assign) NSUInteger unCommitCount;

@property (nonatomic, assign) NSUInteger commitCount;
/** 工作状态 2:开启  1:关闭 */
@property (nonatomic, assign) NSInteger status;
/** 收入数量 */
@property (nonatomic, strong) NSNumber *accountNum;
/** 账户金额 */
@property (nonatomic, copy) NSString *accountTotal;

@end
