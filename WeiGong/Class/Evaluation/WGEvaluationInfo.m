//
//  WGEvaluationInfo.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/8.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGEvaluationInfo.h"

@implementation WGEvaluationInfo
+ (NSDictionary *)wg_dictWithModelReplacedKey {
    return @{@"personalInfoId":@"evalInfo.personalInfoId",
             @"disciplineScore":@"evalInfo.disciplineScore",
             @"normativeScore":@"evalInfo.normativeScore",
             @"developmentScore":@"evalInfo.developmentScore"};
}
+ (NSDictionary *)wg_dictWithModelClassInArray {
    return @{@"evalRank":[WGEvaluationListItem class]};
}

@end

@implementation WGEvaluationListItem



@end
