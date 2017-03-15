//
//  WG_LoginUser.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/21.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WG_LoginUser : NSObject
@property (nonatomic, assign) NSString *adminUserId;

@property (nonatomic, assign) NSUInteger personalInfoId;

@property (nonatomic, copy) NSString *adminUserName;

@property (nonatomic, copy) NSString *personalName;

@property (nonatomic, copy) NSString *picUrl;

@property (nonatomic, copy) NSString *huanxinUserName;

@property (nonatomic, assign) NSUInteger automaticLogin;

@end
