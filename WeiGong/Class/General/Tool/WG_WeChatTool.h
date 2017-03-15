//
//  WG_WeChatTool.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/17.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

@interface WG_WeChatTool : NSObject <WXApiDelegate>
/** 检测是否安装了微信 */
+ (BOOL)isInstalledWeChat;

+ (instancetype)shareInstance;
/**
 *  分享到微信好友
 *
 *  @param title   标题
 *  @param content 文本
 *  @param icon    图标
 *  @param link    链接
 */
- (void)shareToSessionWithTitle:(NSString *)title content:(NSString *)content icon:(UIImage *)icon link:(NSString *)link;
/**
 *  分享到朋友圈
 *
 *  @param title   标题
 *  @param content 文本
 *  @param icon    图标
 *  @param link    链接
 */
- (void)shareToTimelineWithTitle:(NSString *)title content:(NSString *)content icon:(UIImage *)icon link:(NSString *)link;
@end
