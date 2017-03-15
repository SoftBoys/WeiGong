//
//  WGNearParam.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/7.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGNearParam : NSObject

@property (nonatomic, assign) CGFloat longitude;
@property (nonatomic, assign) CGFloat latitude;
/** 米 */
@property (nonatomic, assign) NSInteger distance;
/** 0 */
@property (nonatomic, assign) NSInteger pageNum;
/** 500 */
@property (nonatomic, assign) NSInteger pageSize;

@end
