//
//  WG_JobDetailViewController+WG_Extension.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/7.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_JobDetailViewController.h"
#import <EMSDK.h>

@class WG_JobDetailShare, WG_JobDetail;
@interface WG_JobDetailViewController (WG_Extension)

@property (nonatomic, strong) WG_JobDetailShare *share;

- (void)wg_setRightItem;


- (void)wg_joinGroupWithGroupId:(NSString *)groupId competionHandle:(void(^)(EMGroup *group))handle;

@end
