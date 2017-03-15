//
//  WG_JobDetailViewController.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/21.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_WebViewController.h"
#import "WG_HomeItem.h"

@interface WG_JobDetailViewController : WG_WebViewController
/** 职位id（enterpriseJobId） */
@property (nonatomic, copy) NSString *jobId;

@property (nonatomic, strong) WG_HomeItem *homeItem;

@end
