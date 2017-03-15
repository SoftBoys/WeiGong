//
//  WG_MineUser.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/18.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_MineUser.h"

@implementation WG_MineUser

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"iconUrl":@"picUrl",
             
             @"collectCount":@"countsUp.favoriteCount",
             @"creditCount":@"countsUp.evaluationCount",
             @"rejectCount":@"countsUp.flyCount",
             
             @"unSureCount":@"counts.unCheck",
             @"unCommitCount":@"counts.unEva",
             @"commitCount":@"counts.eva",
             @"accountNum":@"accountInfo.accountNum",
             @"accountTotal":@"accountInfo.accountTotal"};
}

@end
