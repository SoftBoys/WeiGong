//
//  WG_UserDefaults.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/12.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WG_UserDefaults : NSObject

+ (instancetype)shareInstance;

@property (nonatomic, assign) BOOL isFirstOpen;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *userName;
/** 登陆手机号 */
@property (nonatomic, copy) NSString *loginPhoneNum;

@property (nonatomic, assign, readonly) BOOL isLogin;
/** 设备token */
@property (nonatomic, copy) NSString *deviceToken;
/** 环信用户名 */
@property (nonatomic, copy) NSString *huanxinUserName;

@property (nonatomic, copy) NSString *adminUserId;

@property (nonatomic, copy) NSString *iconUrl;

- (void)loginOut;


@property (nonatomic, copy) NSString *helpUrl;

@property (nonatomic, copy) NSString *protocolUrl;
@end
