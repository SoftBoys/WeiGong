//
//  WGMessageHistoryViewController+More.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/27.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGMessageHistoryViewController.h"

@class WGMessageHistoryListItem;
@interface WGMessageHistoryViewController (More)

- (void)loadEaseDataWithCompletionHandle:(void(^)(NSArray <WGMessageHistoryListItem *>*list))handle;

@end
