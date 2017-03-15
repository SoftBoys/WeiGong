//
//  WGBasixInfoSaveParam.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/7.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGBasixInfoSaveParam : NSObject
@property (nonatomic, copy) NSString *personName;

@property (nonatomic, copy) NSString *identityCard;
/**
 *  个人简介
 */
@property (nonatomic, copy) NSString *resume;
/**
 *  联系电话号码
 */
@property (nonatomic, copy) NSString *mobile;
/**
 *  微信号
 */
@property (nonatomic, copy) NSString *wechatNo;
/**
 *  qq号
 */
@property (nonatomic, copy) NSString *qqNo;
/**
 *  性别（1男  2女）
 */
@property (nonatomic, assign) NSInteger sex;
/**
 *  出生日期
 */
@property (nonatomic, copy) NSString *birthday;
/**
 *  学历
 */
@property (nonatomic, strong) NSNumber *degreeId;
/**
 *  个人身份（1学生  2社会成员）
 */
@property (nonatomic, assign) NSInteger identFlag;
/**
 *  学校（学生身份必传）
 */
@property (nonatomic, copy) NSString *school;
/**
 *  学业（学生身份必传）
 */
@property (nonatomic, copy) NSString *profession;
/**
 *  驾照
 */
@property (nonatomic, assign) NSInteger driveLicense;
/**
 *  健康证
 */
@property (nonatomic, assign) NSInteger healthCard;
/**
 *  个人标签字符串
 */
@property (nonatomic, copy) NSString *personalMarkStr;
/**
 *  工作地址
 */
@property (nonatomic, copy) NSString *address;
/**
 *  区县或城市id
 */
@property (nonatomic, assign) NSInteger cityCode;
/**
 *  城市名字
 */
@property (nonatomic, copy) NSString *cityName;
/**
 *  身高
 */
@property (nonatomic, strong) NSNumber *height;
/**
 *  体重
 */
@property (nonatomic, strong) NSNumber *weight;
@end
