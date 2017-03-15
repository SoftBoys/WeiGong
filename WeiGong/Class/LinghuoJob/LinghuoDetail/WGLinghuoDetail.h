//
//  WGLinghuoDetail.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/25.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WGLinghuoDetailListItem;
@interface WGLinghuoDetail : NSObject

@property (nonatomic, strong) NSNumber *totalMoney;

@property (nonatomic, assign) NSInteger addWorkFlag;
/** 0:不可生成电子凭证  非0:可以   */
@property (nonatomic, assign) NSInteger uploadFlag;

@property (nonatomic, assign) NSInteger totalDay;

@property (nonatomic, copy) NSArray <WGLinghuoDetailListItem *> *jobList;

@end

@interface WGLinghuoDetailListItem : NSObject

@property (nonatomic, copy) NSString *enterpriseName;

@property (nonatomic, copy) NSString *workDate;

@property (nonatomic, copy) NSString *workTime;

@property (nonatomic, copy) NSString *jobName;

@property (nonatomic, copy) NSString *checkFlag;


@end
