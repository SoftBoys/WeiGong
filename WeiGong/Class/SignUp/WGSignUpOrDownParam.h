//
//  WGSignUpOrDownParam.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/26.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGSignUpOrDownParam : NSObject
/** 排班主键 */
@property (nonatomic, assign) long personalWorkId;
/** 百度经度（保留八位小数） */
@property (nonatomic, strong) NSNumber *baiduLongitude;
/**  百度纬度（保留八位小数） */
@property (nonatomic, strong) NSNumber *baiduLatitude;
/**  地理位置 (详细位置) */
@property (nonatomic, copy) NSString *deviceFlag;
/** 1:上班签到  2:下班签到 */
@property (nonatomic, assign) NSInteger flag;
@end
