//
//  WGMyWorkDetail.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/25.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGMyWorkDetail : NSObject

@property (nonatomic, copy) NSString *enterpriseName;

@property (nonatomic, copy) NSString *jobName;
@property (nonatomic, copy) NSString *contactName;
@property (nonatomic, copy) NSString *contactMobile;
@property (nonatomic, copy) NSString *contactPhone;
@property (nonatomic, copy) NSString *workDate;
@property (nonatomic, copy) NSString *serverDate;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *stopTime;
@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, strong) NSNumber *baiduLatitude;
@property (nonatomic, strong) NSNumber *baiduLongitude;
@end
