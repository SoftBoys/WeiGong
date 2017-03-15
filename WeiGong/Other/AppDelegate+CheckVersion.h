//
//  AppDelegate+CheckVersion.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/24.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "AppDelegate.h"

@class WG_UpdateItem;
@interface AppDelegate (CheckVersion)
/** 检测版本的更新 */
- (void)wg_checkVersion;
/** 显示alertView */
- (void)wg_showAlert;

@property (nonatomic, strong) WG_UpdateItem *wg_updateItem;
@end

@interface AppDelegate (GetBaseData)
- (void)wg_updateLocalData;
@end


@interface WG_UpdateItem : NSObject

//+ (instancetype)wg_checkNewVersion:(NSString *)newVersion localVersion:(NSString *)localVersion lowVersion:(NSString *)lowVersion;
/** 0:不需要更新 1:提示更新 2:强制更新 */
@property (nonatomic, assign) NSUInteger updateType;
@end
