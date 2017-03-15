//
//  AppDelegate+Share.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/17.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "AppDelegate.h"
#import <WeiboSDK/WeiboSDK.h>

@interface AppDelegate (Share) 
/** 配置微信 */
- (void)setWechat;
/** 配置新浪 */
- (void)setSina;
/** 配置QQ */
- (void)setQQ;

@end
