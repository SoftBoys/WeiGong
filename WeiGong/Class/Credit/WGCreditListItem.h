//
//  WGCreditListItem.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/25.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGCreditListItem : NSObject

@property (nonatomic, assign) NSInteger checkFlag;
@property (nonatomic, copy) NSString *enterpriseName;
@property (nonatomic, copy) NSString *jobName;
@property (nonatomic, strong) NSNumber *money;
@property (nonatomic, assign) NSInteger evalSum;
@property (nonatomic, assign) NSInteger evalTarget1;
@property (nonatomic, assign) NSInteger evalTarget2;
@property (nonatomic, assign) NSInteger evalTarget3;
@property (nonatomic, copy) NSString *evalDesc;
@property (nonatomic, copy) NSString *createDate;

@end
