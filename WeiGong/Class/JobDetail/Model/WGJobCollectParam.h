//
//  WGJobCollectParam.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/17.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGJobCollectParam : NSObject

@property (nonatomic, copy) NSString *personalInfoId;

@property (nonatomic, copy) NSString *enterpriseInfoId;

@property (nonatomic, copy) NSString *enterpriseJobId;

@property (nonatomic, strong) NSNumber *postFlag;

@end
