//
//  WGChatSetCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/28.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WG_BaseTableViewCell.h"

@class WGChatSetItem;
@interface WGChatSetCell : WG_BaseTableViewCell
@property (nonatomic, strong) WGChatSetItem *item;
@property (nonatomic, copy) void (^changeSwitchHandle)(UISwitch *myswitch);
@end

@interface WGChatSetItem : NSObject
/** 标题title  */
@property (nonatomic,copy) NSString *title;
/** 是否显示开关按钮 */
@property (nonatomic,assign) BOOL showSwitch;
/** 此群组是否被屏蔽 */
@property (nonatomic,assign) BOOL isBlocked;
@end
