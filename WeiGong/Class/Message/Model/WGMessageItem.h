//
//  WGMessageItem.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/18.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGMessageItem : NSObject
/** 1:咨询消息, 2:系统消息, 3:工作消息, */
@property (nonatomic, assign) NSInteger itemId;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *imageUrl;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, strong) NSNumber *workNew;

@property (nonatomic, copy) NSString *linkUrl;

@property (nonatomic, assign) NSInteger unreadCount;

@end
