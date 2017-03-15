//
//  WGChangeAccountParam.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/22.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGChangeAccountParam.h"

@implementation WGChangeAccountParam
- (instancetype)init {
    if (self = [super init]) {
        _typeId = 2;
    }
    return self;
}
+ (NSDictionary *)wg_dictWithModelReplacedKey {
    return @{@"phone_old":@"oldLoginName",
             @"phone_new":@"newLoginName",
             @"password_old":@"oldPassword",
             @"password_new":@"newPassword"};
}

@end
