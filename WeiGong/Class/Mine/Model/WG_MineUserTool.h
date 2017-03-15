//
//  WG_MineUserTool.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/19.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WG_MineUser;
@interface WG_MineUserTool : NSObject

/** 保存用户数据 */
+ (void)saveUser:(WG_MineUser *)user;
/** 获取用户数据 */
+ (WG_MineUser *)getUser;
+ (void)clearUser;
@end
