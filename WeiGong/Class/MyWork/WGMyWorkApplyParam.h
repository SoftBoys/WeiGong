//
//  WGMyWorkApplyParam.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/24.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGMyWorkApplyParam : NSObject
/** 1:申请 2:已查看 3:录用 4:储备 */
@property (nonatomic, assign) NSInteger postStatus;

@property (nonatomic, assign) NSInteger pageNum;

@property (nonatomic, assign) NSInteger pageSize;
@end

@interface WGMyWorkArrangeParam : NSObject

@property (nonatomic, assign) NSInteger pageNum;

@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, assign) NSInteger isHistory;

@end
