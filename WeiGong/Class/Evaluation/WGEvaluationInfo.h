//
//  WGEvaluationInfo.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/8.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WGEvaluationListItem;
@interface WGEvaluationInfo : NSObject
/** 个人id */
@property (nonatomic, copy) NSString *personalInfoId;
/** 纪律性 */
@property (nonatomic, copy) NSString *disciplineScore;
/** 规范性 */
@property (nonatomic, copy) NSString *normativeScore;
/** 成长性 */
@property (nonatomic, copy) NSString *developmentScore;

@property (nonatomic, copy) NSArray <WGEvaluationListItem *>*evalRank;

@end

@interface WGEvaluationListItem : NSObject

@property (nonatomic, copy) NSString *markName;

@property (nonatomic, copy) NSString *nameUrlSm;

@property (nonatomic, copy) NSString *color;

@property (nonatomic, copy) NSString *markId;

@property (nonatomic, copy) NSString *sumHours;

@property (nonatomic, copy) NSString *myHours;

@end
