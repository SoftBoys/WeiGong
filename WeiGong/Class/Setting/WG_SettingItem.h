//
//  WG_SettingItem.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/21.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WG_SettingItem : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) BOOL isCache;
/** 缓存内容 */
@property (nonatomic, copy) NSString *cache;
/** 是否显示开关 */
@property (nonatomic, assign) BOOL isSwitch;
/** 开关状态 2:开  1:关 */
@property (nonatomic, assign) NSInteger status;

@end
