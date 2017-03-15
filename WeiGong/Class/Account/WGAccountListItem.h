//
//  WGAccountListItem.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/22.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGAccountListItem : NSObject
/** 账号id */
@property (nonatomic, assign) NSUInteger paymentAccountId;
/** 账户名 */
@property (nonatomic, copy) NSString *accountId;
/** 姓名 */
@property (nonatomic, copy) NSString *accountName;

/** 账号类型 */
@property (nonatomic, assign) NSUInteger accountTypeId;
/** 账号类型名称 (支付宝,微信 ...) */
@property (nonatomic, copy) NSString *accountType;
/** 账号图片 */
@property (nonatomic, copy) NSString *picUrl;
/** 是否为默认账号 1:默认  0:非默认 */
@property (nonatomic, assign) NSInteger accountDefault;


@end
