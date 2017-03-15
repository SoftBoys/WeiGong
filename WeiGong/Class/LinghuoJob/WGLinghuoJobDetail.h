//
//  WGLinghuoJobDetail.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/19.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGLinghuoJobDetail : NSObject

@property (nonatomic, copy) NSString *linkUrl;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *linkTitle;
@property (nonatomic, copy) NSString *contentUrl;

/** 1:不显示右上角按钮 2: 3:申请通过，显示每月工作情况按钮 4: 5:  */
@property (nonatomic, assign) NSInteger agileFlag;

@end
