//
//  WGHomeParam.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/16.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGHomeParam : NSObject

@property (nonatomic, assign) NSUInteger deviceType;

@property (nonatomic, assign) NSUInteger locationCodeId;

@property (nonatomic, assign) NSUInteger pageNum;

@property (nonatomic, assign) NSUInteger pageSize;

@property (nonatomic, strong) NSNumber *markId;

@end
