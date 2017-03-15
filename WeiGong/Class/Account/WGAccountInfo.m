//
//  WGAccountInfo.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/22.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGAccountInfo.h"

@implementation WGAccountInfo
+ (NSDictionary *)wg_dictWithModelClassInArray {
    return @{@"bankInfo":[WGAccountBankInfo class]};
}
@end

@implementation WGAccountBankInfo


@end
