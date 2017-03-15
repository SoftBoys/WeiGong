//
//  WGChatHelper.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/28.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WG_BaseTabBarController.h"
#import "WG_MessageViewController.h"

@interface WGChatHelper : NSObject
+ (instancetype)shareInstance;
/** 消息页面 */
@property (nonatomic, strong) WG_MessageViewController *messageVC;
/** 主TabbarController */
@property (nonatomic, strong) WG_BaseTabBarController *mainVC;

@end
