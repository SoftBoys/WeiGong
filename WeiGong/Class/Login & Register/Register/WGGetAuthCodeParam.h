//
//  WGGetAuthCodeParam.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/22.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGGetAuthCodeParam : NSObject
/** 手机号码 */
@property (nonatomic, copy) NSString *phoneNum;
/** 2:个人 */
@property (nonatomic, assign) NSInteger typeId;
/** 1:注册 2:设置提现密码 3:重置密码 4:更换账号 */
@property (nonatomic, assign) NSInteger tag;
@end
