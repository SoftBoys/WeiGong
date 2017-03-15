//
//  WGAddAccountParam.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/23.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGAddAccountParam : NSObject

@property (nonatomic, assign) NSUInteger accountType;
/** 姓名 */
@property (nonatomic, copy) NSString *accountName;
/** 账号 支付宝账号 */
@property (nonatomic, copy) NSString *accountId;
/** 开户行 */
@property (nonatomic, copy) NSString *bankInfo;

@end
