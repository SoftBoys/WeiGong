//
//  WGAuthIdentify.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/19.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGAuthIdentify : NSObject
/**
 *  0:未上传；1：申请中；2：审核通过；3：审核失败
 */
@property (nonatomic, assign) NSInteger checkFlag;
/** 0：显示三张照片  非0：显示一张手持照片 */
@property (nonatomic, assign) NSInteger agileFlag;
/**
 *  身份证正面
 */
@property (nonatomic, copy) NSString *identityCardUrl;
/**
 *  身份证背面
 */
@property (nonatomic, copy) NSString *identityCardUrl2;
/**
 *  手持身份证
 */
@property (nonatomic, copy) NSString *identityCardUrl3;
/**
 *  姓名
 */
@property (nonatomic, copy) NSString *personalName;
/**
 *  身份证号码
 */
@property (nonatomic, copy) NSString *identityCard;
/**
 *  失败原因
 */
@property (nonatomic, copy) NSString *checkReason;
/**
 *  提示内容
 */
@property (nonatomic, copy) NSString *content;
@end
