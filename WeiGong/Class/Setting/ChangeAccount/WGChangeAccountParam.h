//
//  WGChangeAccountParam.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/22.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGChangeAccountParam : NSObject
/** 旧登陆手机号 */
@property (nonatomic, copy) NSString *phone_old;
/** 新登陆手机号 */
@property (nonatomic, copy) NSString *phone_new;
/** 旧登陆密码 */
@property (nonatomic, copy) NSString *password_old;
/** 新登陆密码 */
@property (nonatomic, copy) NSString *password_new;
/** 2：个人 */
@property (nonatomic, assign) NSInteger typeId;
/** 验证码 */
@property (nonatomic, copy) NSString *regCode;

@end
