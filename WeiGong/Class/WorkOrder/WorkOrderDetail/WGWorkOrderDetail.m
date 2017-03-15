//
//  WGWordOrderDetail.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/23.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGWorkOrderDetail.h"

@implementation WGWorkOrderDetail
+ (NSDictionary *)wg_dictWithModelClassInArray {
    return @{@"workList":[WGWorkOrderDetailListItem class]};
    
}
@end

@implementation WGWorkOrderDetailListItem

@end
