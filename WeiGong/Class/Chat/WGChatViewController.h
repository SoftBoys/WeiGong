//
//  WGChatViewController.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/27.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "EaseMessageViewController.h"
//#import "WG_BaseTableViewController.h"

@interface WGChatViewController : EaseMessageViewController
+ (instancetype)wg_chatWithChatter:(NSString *)chatter;
/** 聊天页面初始化 chatter:群组id，用户名  isGroup:默认YES  */
+ (instancetype)wg_chatWithChatter:(NSString *)chatter isGroup:(BOOL)isGroup;

@end
