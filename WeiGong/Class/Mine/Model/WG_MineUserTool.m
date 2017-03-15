//
//  WG_MineUserTool.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/19.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_MineUserTool.h"
#import "WG_MineUser.h"
#import <YTKKeyValueStore/YTKKeyValueStore.h>
#import "WGDataBaseTool.h"

NSString *const kUserTableName  = @"mine_user";
NSString *const kUserKey        = @"user_key";

@implementation WG_MineUserTool
+ (void)clearUser {
    [WGDataBaseTool clearTable:kUserTableName];
}
+ (void)saveUser:(WG_MineUser *)user {
    
    NSDictionary *userDict = [user wg_keyValues];
    [WGDataBaseTool putObject:userDict withId:kUserKey intoTable:kUserTableName];
    
}
+ (WG_MineUser *)getUser {
    NSDictionary *userDict = [WGDataBaseTool getObjectById:kUserKey fromTable:kUserTableName];
    WG_MineUser *user = [WG_MineUser wg_modelWithDictionry:userDict];
    return user;
}
@end
