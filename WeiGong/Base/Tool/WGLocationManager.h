//
//  WGLocationManager.h
//  WGBaseDemo
//
//  Created by dfhb@rdd on 16/11/29.
//  Copyright © 2016年 guojunwei. All rights reserved.
//  1.需要导入的库文件  CoreLocation.framework , AddressBookUI.framework
//  2.注意：ATS记得打开，添加字段
//  3.使用定位功能需要在info中添加字段 NSLocationAlwaysUsageDescription = YES, 或者 NSLocationWhenInUseUsageDescription = YES

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class WGLocationInfo, WGLocationManager;
@protocol WGLocationManagerDelegate <NSObject>

- (void)locationManager:(WGLocationManager *)manager successInfo:(WGLocationInfo *)info;
- (void)locationManager:(WGLocationManager *)manager fail:(NSError *)error;
@end

typedef void(^WGSuccessCallBack)(WGLocationManager *manager, WGLocationInfo *info);
typedef void(^WGFailCallBack)(WGLocationManager *manager, NSError *error);
typedef NS_ENUM(NSUInteger, WGAuthStatus) {
    /** 未授权 (0) */
    kWGAuthStatus_UnAuth = kCLAuthorizationStatusNotDetermined,
    /** 不支持定位功能 (1) */
    kWGAuthStatus_Restricted = kCLAuthorizationStatusRestricted,
    /** 不允许 (2) */
    kWGAuthStatus_Denied = kCLAuthorizationStatusDenied,
    /** 始终 (3) */
    kWGAuthStatus_Always = kCLAuthorizationStatusAuthorizedAlways,
    /** 使用期间 (4) */
    kWGAuthStatus_WhenUse = kCLAuthorizationStatusAuthorizedWhenInUse
};
typedef NS_ENUM(NSUInteger, WGResultStatus) {
    /** 默认状态 (0) */
    kWGResultStatus_Default,
    /** 正在定位 (1) */
    kWGResultStatus_Loading,
    /** 定位成功 (2) */
    kWGResultStatus_Success,
    /** 定位失败 (3) */
    kWGResultStatus_Fail
};

@interface WGLocationManager : NSObject
/** 初始化(单利) */
+ (instancetype)shareManager;
/** 当前位置 */
@property (nonatomic, strong, readonly) CLLocation *location;
/** 定位成功格式化后的位置信息 */
@property (nonatomic, strong, readonly) WGLocationInfo *info;
/** 是否可以定位 */
@property (nonatomic, assign, getter=isCanLocation, readonly) BOOL canLocation;
/** 获取定位授权状态 */
@property (nonatomic, assign, readonly) WGAuthStatus authStatus;
/** 定位结果状态 */
@property (nonatomic, assign, readonly) WGResultStatus resultStatus;
/** 代理（记得在不用的时候置nil）*/
@property (nonatomic, weak) id<WGLocationManagerDelegate> delegate;
/** 开启定位 (需实现协议WGLocationManagerDelegate) */
- (void)startLocation;
/**
 *  开启定位 （不需要设置代理）
 *
 *  @param success 定位成功的回调
 *  @param fail   失败的回调
 */
- (void)startLocationWithSuccess:(WGSuccessCallBack)success fail:(WGFailCallBack)fail;
/** 停止定位 */
- (void)stopLocation;
/** 重新定位 (需实现协议WGLocationManagerDelegate) */
- (void)restartLocation;
/**
 *  开启定位 （不需要设置代理）
 *
 *  @param success 定位成功的回调
 *  @param fail   失败的回调
 */
- (void)restartLocationWithSuccess:(WGSuccessCallBack)success fail:(WGFailCallBack)fail;
@end

@interface WGLocationInfo : NSObject
/** 坐标 */
@property (nonatomic, copy) CLLocation *location;
/** 位置名 */
@property (nonatomic, copy) NSString *name;
/** 国家 */
@property (nonatomic, copy) NSString *country;
/** 省（直辖市） */
@property (nonatomic, copy) NSString *province;
/** 市 */
@property (nonatomic, copy) NSString *city;
/** 区（地级市/县） */
@property (nonatomic, copy) NSString *subcity;
/** 街道 */
@property (nonatomic, copy) NSString *street;
/** 子街道 */
@property (nonatomic, copy) NSString *substreet;
/** 详细位置信息 */
@property (nonatomic, copy) NSString *detailAddress;
/** 格式化地址 */
@property (nonatomic, copy) NSString *address;
@end


