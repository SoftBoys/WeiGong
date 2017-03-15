//
//  WGUserFeedbackParam.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/1.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGUserFeedbackParam : NSObject
/** 可不传 */
@property (nonatomic, copy) NSString *adminUserId;

@property (nonatomic, assign) NSInteger typeId;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *mobile;

@end
