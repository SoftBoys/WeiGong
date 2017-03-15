//
//  WGBasicInfoViewController+More.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/6.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGBasicInfoViewController+More.h"
#import "WGBasicInfo.h"
#import "WGBasicInfoCellItem.h"
#import "WGDataTypeItem.h"

#import "WG_CityItem.h"
#import "WGPickerCityView.h"

#import <objc/runtime.h>

const char kAllCellItemsKey;
@implementation WGBasicInfoViewController (More)

- (NSArray <NSArray *> *)allCellItemsWithInfo:(WGBasicInfo *)info {
    NSArray *allCellItems = objc_getAssociatedObject(self, &kAllCellItemsKey);
    if (allCellItems == nil) {
        NSInteger cellType = 0;
        NSMutableArray *dataArray = @[].mutableCopy;
        NSInteger sections = 4;
        for (NSInteger i = 0; i < sections; i++) {
            NSInteger rows = 1;
            if (i == 1) rows = 8;
            else if (i == 2) rows = 2;
            else if (i == 3) rows = 5;
            NSMutableArray *rowItems = @[].mutableCopy;
            for (NSInteger j = 0; j < rows; j++) {
                WGBasicInfoCellItem *item = [self cellItemWithType:cellType info:info moreCellIsOn:YES];
                [rowItems wg_addObject:item];
                cellType ++;
            }
            [dataArray wg_addObject:rowItems];
        }
        allCellItems = [dataArray copy];
        objc_setAssociatedObject(self, &kAllCellItemsKey, allCellItems, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return allCellItems;
}

- (NSArray<NSArray *> *)getCellItemsWithInfo:(WGBasicInfo *)info moreCellIsOn:(BOOL)isOn {
    
    NSInteger cellType = 0;
    NSMutableArray *dataArray = @[].mutableCopy;
    NSInteger sections = 4;
    for (NSInteger i = 0; i < sections; i++) {
        
        NSInteger rows = 1;
        if (i == 1) rows = 8;
        else if (i == 2) rows = 2;
        else if (i == 3) rows = 5;
        NSMutableArray *rowItems = @[].mutableCopy;
        for (NSInteger j = 0; j < rows; j++) {
            WGBasicInfoCellItem *item = [self cellItemWithType:cellType info:info moreCellIsOn:isOn];
            item.info = info;
            [rowItems wg_addObject:item];
            cellType ++;
        }
        [dataArray wg_addObject:rowItems];
    }
    
    NSInteger identFlag = [info.identFlag integerValue];
    if (identFlag == 2) { // 社会人员
        NSMutableArray *array = [[dataArray wg_objectAtIndex:1] mutableCopy];
        [array wg_removeObjectAtIndex:5];
        [array wg_removeObjectAtIndex:4];
        dataArray[1] = array;
    }
    if (isOn == NO) {
        WGBasicInfoCellItem *cellItem = [[dataArray wg_objectAtIndex:3] firstObject];
        dataArray[3] = @[cellItem];
    }
    
    return [dataArray copy];
}

- (WGBasicInfoCellItem *)cellItemWithType:(NSInteger)cellType info:(WGBasicInfo *)info moreCellIsOn:(BOOL)isOn {
    NSString *name, *placeholder, *content;
    BOOL canInput = !(info.checkFlag == 1 || info.checkFlag == 2);
    WGBasicInfoSexItem *sexItem = nil;
    WGBasicInfoBirthItem *birthItem = nil;
    NSInteger identFlag = [info.identFlag integerValue];
    BOOL moreCellIsOn = isOn;
    NSInteger healthCard = 0, driveLicense = 0;
    NSInteger height = 0;
    NSInteger weight = 0;
    WGDataTypeItem *educationItem = nil;
    WGPickerCityItem *subcityItem = nil;
    if (cellType == 0) {
        
    } else if (cellType == 1) {
        name = @"姓名";
        placeholder = @"输入姓名";
        content = info.personalName;
    } else if (cellType == 2) {
        name = @"性别";
        placeholder = @"选择性别";
        
        sexItem = [WGBasicInfoSexItem new];
        sexItem.sexCode = info.sex;
        NSString *name = nil;
        if (info.sex == 1) {
            name = @"男";
        } else if (info.sex == 2) {
            name = @"女";
        }
        sexItem.name = name;
        
    } else if (cellType == 3) {
        name = @"出生日期";
        placeholder = @"选择出生日期";
        content = info.personalName;
        birthItem = [WGBasicInfoBirthItem new];
        birthItem.dateStr = info.birthday;
        birthItem.date = [NSDate wg_dateWithDateString:info.birthday dateFormat:@"yyyy-MM-dd"];
    } else if (cellType == 4) {
        name = @"个人身份";
//        placeholder = @"输入姓名";
        content = info.personalName;
        
    } else if (cellType == 5) {
        name = @"学校名称";
        placeholder = @"输入学校名称";
        content = info.school;
        canInput = YES;
    } else if (cellType == 6) {
        name = @"专业名称";
        placeholder = @"输入专业名称";
        content = info.profession;
        canInput = YES;
    } else if (cellType == 7) {
        name = @"工作经验";
        placeholder = @"选择经验标签";
        content = info.personalMarkStr;
        canInput = NO;
    } else if (cellType == 8) {
        name = @"工作区域";
        placeholder = @"填写期望地点";
        content = info.address;
        canInput = YES;
        for (WG_CityItem *cityItem in self.cityItem.subItems) {
            if (cityItem.cityCode == info.locationCodeId) {
                
                subcityItem = [WGPickerCityItem new];
                subcityItem.cityCode = cityItem.cityCode;
                subcityItem.city = cityItem.city;
            }
        }
        
    } else if (cellType == 9) {
        name = nil;
        placeholder = nil;
        content = nil;
        height = info.height;
        weight = info.weight;
        if (info.degree) {
            educationItem = [WGDataTypeItem new];
            educationItem.code = info.degree;
            educationItem.name = info.degreeName;
        }
        
    } else if (cellType == 10) {
        name = @"持有证照";
        placeholder = nil;
        content = info.personalName;
        healthCard = info.healthCard;
        driveLicense = info.driveLicense;
    } else if (cellType == 11) {
        name = @"更多信息";
        
        moreCellIsOn = isOn;
        content = info.personalName;
    } else if (cellType == 12) {
        name = @"联系手机";
        placeholder = @"填写联系电话";
        content = info.mobile;
        canInput = YES;
    } else if (cellType == 13) {
        name = @"微信号";
        placeholder = @"填写微信号";
        content = info.wechatNo;
        canInput = YES;
    } else if (cellType == 14) {
        name = @"QQ号";
        placeholder = @"填写QQ号";
        content = info.qqNo;
        canInput = YES;
    } else if (cellType == 15) {
        name = @"自我描述";
        placeholder = @"请生动形象地介绍一下自己，让企业更快发现你";
        content = info.resume;
        canInput = YES;
    }
    
    
    WGBasicInfoCellItem *item = [WGBasicInfoCellItem new];
    item.cellType = cellType;
    item.name_left = name;
    item.placeholder = placeholder;
    item.name_content = content;
    item.canInput = canInput;
    item.sexItem = sexItem;
    item.birthItem = birthItem;
    item.photoItemList = info.lifePics;
    item.identFlag = identFlag;
    item.moreCellIsOn = moreCellIsOn;
    item.height = height;
    item.weight = weight;
    item.educationItem = educationItem;
    item.subcityItem = subcityItem;
    item.driveLicense = driveLicense;
    item.healthCard = healthCard;
    return item;
}

- (NSString *)leftNameWithCellType:(NSInteger)cellType {
    NSString *name = @"";
    switch (cellType) {
        case 0:
            name = @"生活照";
            break;
        case 1:
            name = @"姓名";
            break;
        case 2:
            name = @"性别";
            break;
        case 3:
            name = @"出生日期";
            break;
        case 4:
            name = @"个人身份";
            break;
        case 5:
            name = @"学校名称";
            break;
        case 6:
            name = @"专业名称";
            break;
        case 7:
            name = @"工作经验";
            break;
        case 8:
            name = @"工作区域";
            break;
        case 9:
            name = @"姓名";
            break;
        case 10:
            name = @"持有证照";
            break;
        case 11:
            name = @"更多信息";
            break;
        case 12:
            name = @"联系手机";
            break;
        case 13:
            name = @"微信号";
            break;
        case 14:
            name = @"QQ号";
            break;
        case 15:
            name = @"自我描述";
            break;
            
            
        default:
            name = @"";
            break;
    }
    
    return name;
}

- (NSString *)placeholderWithCellType:(NSInteger)cellType {
    NSString *placeholder = nil;
    switch (cellType) {
        case 1:
            placeholder = @"输入姓名";
            break;
        case 2:
            placeholder = @"选择性别";
            break;
        case 3:
            placeholder = @"选择出生日期";
            break;
        case 5:
            placeholder = @"输入学校名称";
            break;
        case 6:
            placeholder = @"输入专业名称";
            break;
        case 7:
            placeholder = @"选择经验标签";
            break;
        case 8:
            placeholder = @"填写期望地点";
            break;
        case 12:
            placeholder = @"填写联系电话";
            break;
        case 13:
            placeholder = @"填写微信号";
            break;
        case 14:
            placeholder = @"填写QQ号";
            break;
        case 15:
            placeholder = @"介绍自己";
            break;
        
            
            
        default:
            placeholder = nil;
            break;
    }
    
    return placeholder;
}

@end
