//
//  WGBasicInfo.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/6.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WGBasicInfoPhotoItem;
@interface WGBasicInfo : NSObject

/** 姓名 */
@property (nonatomic, copy) NSString *personalName;
/** 出生年月 */
@property (nonatomic, copy) NSString *birthday;
/** 性别 (1男 2女) */
@property (nonatomic, assign) NSInteger sex;

@property (nonatomic, assign) NSInteger checkFlag;
/** 学历编号 */
@property (nonatomic, assign) NSInteger degree;
/** 学历名称 */
@property (nonatomic, copy) NSString *degreeName;
@property (nonatomic, copy) NSString *huanxinUserName;
@property (nonatomic, copy) NSString *identityCard;
@property (nonatomic, copy) NSString *identityCardUrl;
@property (nonatomic, copy) NSString *loginNum;
@property (nonatomic, copy) NSString *markId;
@property (nonatomic, copy) NSString *markName;
@property (nonatomic, copy) NSString *unMarkName;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *personalInfoId;

@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, copy) NSString *resume;

@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *identFlag;
@property (nonatomic, copy) NSString *school;
@property (nonatomic, copy) NSString *profession;
//@property (nonatomic, copy) NSDictionary *counts;
@property (nonatomic, assign) NSInteger agileFlag;
@property (nonatomic, copy) NSString *agileContent;
/** 地点位置信息 */
@property (nonatomic, copy) NSString *locationName;
/** QQ号 */
@property (nonatomic, copy) NSString *qqNo;
/** 微信号 */
@property (nonatomic, copy) NSString *wechatNo;
/** 生活照 */
@property (nonatomic, strong) NSArray <WGBasicInfoPhotoItem *>*lifePics;
/** 个人标签字符串 */
@property (nonatomic, copy) NSString *personalMarkStr;
/** 驾照(0: 1:) */
@property (nonatomic, assign) NSInteger driveLicense;
/** 健康证(0: 1:) */
@property (nonatomic, assign) NSInteger healthCard;
/** 驾照(0: 1:) */
@property (nonatomic, copy) NSString *address;
/** 城市id */
@property (nonatomic, assign) NSInteger parentLocationId;
/** 区域id */
@property (nonatomic, assign) NSInteger locationCodeId;
/** 身高 */
@property (nonatomic, assign) NSInteger height;
/** 体重 */
@property (nonatomic, assign) NSInteger weight;

@end

@interface WGBasicInfoPhotoItem : NSObject

@property (nonatomic, assign) NSInteger lifePicId;

@property (nonatomic, copy) NSString *picUrlS;

@property (nonatomic, copy) NSString *picUrlB;

@end
