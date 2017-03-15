//
//  WG_Cache.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/24.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WG_Cache : NSObject
/** 获取缓存，单位为K */
+ (long long)wg_getCaches;
/** 清除缓存 */
+ (BOOL)wg_clearCaches;
@end
