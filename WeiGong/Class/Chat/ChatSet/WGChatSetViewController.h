//
//  WGChatSetViewController.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/27.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

static NSString *RemoveAllMessages = @"RemoveAllMessages";
static NSString *ExitGroup = @"ExitGroup";

#import "WG_BaseTableViewController.h"

@interface WGChatSetViewController : WG_BaseTableViewController

@property (nonatomic, copy) NSString *chatter;

@property (nonatomic, assign) BOOL isGroup;

@end
