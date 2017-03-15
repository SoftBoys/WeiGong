//
//  WGAuthSubmitPhotoParam.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/20.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGAuthSubmitPhotoParam : NSObject
/**
 *  0: 上传营业执照
 *  1: 个人身份证正面
 *  2：个人身份证背面
 *  3：个人身份证手持
 */
@property (nonatomic, assign) NSInteger picFlag;
/**
 *  0:不提交  1:提交 (传0)
 */
@property (nonatomic, assign) NSInteger commitFlag;
@end
