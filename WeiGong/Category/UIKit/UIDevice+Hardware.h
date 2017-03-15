//
//  UIDevice+Hardware.h
//  WGKitDemo
//
//  Created by dfhb@rdd on 16/11/25.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Hardware)

+ (NSString *)wg_platform;
+ (NSString *)wg_platformString;

+ (NSString *)wg_macAddress;


/** 获取iOS系统版本号 */
+ (NSString *)wg_systemVersion;
/** 判断是否有摄像头 */
+ (BOOL)wg_hasCamera;
/** 获取手机内存总量, 返回的是字节数 */
+ (NSUInteger)wg_totalMemoryBytes;
/** 获取手机可用内存 */
+ (NSUInteger)wg_freeMemoryBytes;
/** 获取手机硬盘空闲空间, 返回的是字节数 */
+ (long long)wg_freeDiskSpaceBytes;
/** 获取手机硬盘总空间, 返回的是字节数 */
+ (long long)wg_totalDiskSpaceBytes;
@end

@interface UIDevice (Camara_Photo)
/** 是否有照相的权限 */
+ (BOOL)wg_isAccessCamera;
/** 是否有访问相册的权限 */
+ (BOOL)wg_isAccessPhoto;
/** 提示设置相机权限Alert */
+ (void)wg_showCameraAlert;
/** 提示设置照片权限Alert */
+ (void)wg_showPhotoAlert;
@end

@interface UIDevice (Phone)
/** 打电话 */
+ (void)wg_phoneWithNumber:(NSString *)phoneNumber;
@end
