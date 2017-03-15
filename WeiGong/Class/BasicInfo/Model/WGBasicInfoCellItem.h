//
//  WGBasicInfoCellItem.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/6.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WGBasicInfo.h"

@class WGBasicInfoPhotoItem, WGBasicInfoSexItem, WGBasicInfoBirthItem, WGDataTypeItem, WGPickerCityItem;
@interface WGBasicInfoCellItem : NSObject
/** 0:生活照 1:姓名 2:性别 3:出生日期 4:个人身份 5:学校名称 6:专业名称 7:工作经验 8:地址 9:身高体重 10:证照 11:更多 12:手机 13:微信 14:QQ 15:自我描述 */
@property (nonatomic, assign) NSInteger cellType;

@property (nonatomic, copy) NSString *name_left;

@property (nonatomic, copy) NSString *name_content;

@property (nonatomic, copy) NSString *placeholder;

@property (nonatomic, assign) BOOL canInput;

@property (nonatomic, copy) NSArray<WGBasicInfoPhotoItem *> *photoItemList;

@property (nonatomic, strong) WGBasicInfoSexItem *sexItem;

@property (nonatomic, strong) WGBasicInfoBirthItem *birthItem;

/** 个人身份（1学生  2社会成员）*/
@property (nonatomic, assign) NSInteger identFlag;

@property (nonatomic, assign) BOOL moreCellIsOn;
/** 健康证 */
@property (nonatomic, assign) NSInteger healthCard;
/** 驾驶证 */
@property (nonatomic, assign) NSInteger driveLicense;
/** 身高 */
@property (nonatomic, assign) NSInteger height;
/** 体重 */
@property (nonatomic, assign) NSInteger weight;
/** 学历标签 */
@property (nonatomic, strong) WGDataTypeItem *educationItem;

@property (nonatomic, strong) WGPickerCityItem *subcityItem;

@property (nonatomic, strong) WGBasicInfo *info;

@end

@interface WGBasicInfoSexItem : NSObject
/** 男女标记（1男，2女）*/
@property (nonatomic, assign) NSInteger sexCode;
/** 标题（男，女）*/
@property (nonatomic, copy) NSString *name;
@end

@interface WGBasicInfoBirthItem : NSObject
/** 日期 */
@property (nonatomic, strong) NSDate *date;
/** 日期(yyyy-MM-dd) */
@property (nonatomic, copy) NSString *dateStr;
@end


