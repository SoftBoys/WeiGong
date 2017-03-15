//
//  WGRegisterParam.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/2.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGRegisterParam : NSObject
/** 手机号码 */
@property (nonatomic, copy) NSString *phoneNum;
/** 密码 */
@property (nonatomic, copy) NSString *passWord;
/** 验证码 */
@property (nonatomic, copy) NSString *regCode;
/** 用户姓名 */
@property (nonatomic, copy) NSString *personalName;
/** 城市id */
@property (nonatomic, assign) NSInteger cityCode;
/** 城市名称 */
@property (nonatomic, copy) NSString *cityName;
/** 工作地址 */
@property (nonatomic, copy) NSString *address;
/** 岗位id */
@property (nonatomic, copy) NSString *markId;
/** 岗位名称 */
@property (nonatomic, copy) NSString *markName;
@end
