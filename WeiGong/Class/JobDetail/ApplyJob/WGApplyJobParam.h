//
//  WGApplyJobParam.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/2.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGApplyJobParam : NSObject
@property (nonatomic, assign) NSInteger enterpriseJobId; //职位ID
@property (nonatomic, assign) NSInteger enterpriseInfoId; //企业ID
@property (nonatomic, assign) NSInteger toAddress; //个人意向地点id
@property (nonatomic, copy) NSString *toDate; //意向日期
@property (nonatomic, copy) NSString *toTime; //意向时间
@end
