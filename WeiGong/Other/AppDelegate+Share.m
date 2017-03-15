//
//  AppDelegate+Share.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/17.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "AppDelegate+Share.h"

#import "WXApi.h"
#import <WeiboSDK/WeiboSDK.h>
#import "WG_SinaTool.h"
#import "WG_WeChatTool.h"
#import "WG_QQTool.h"
#import <TencentOpenAPI/TencentOAuth.h>

@implementation AppDelegate (Share) 

- (void)setWechat {
    
    [WXApi registerApp:@"wxf447a4fd8a8a43b2"];
    
}

- (void)setSina {
    
#ifdef DEBUG
    [WeiboSDK enableDebugMode:YES];
#else
    [WeiboSDK enableDebugMode:NO];
#endif
    
    [WeiboSDK registerApp:@"2195807134"];
    
}
- (void)setQQ {
    [WG_QQTool shareInstance].tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"1104789355" andDelegate:[WG_QQTool shareInstance]];
}
#pragma mark - UIApplicationDelegate
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    WGLog(@"url1:%@", url.absoluteString);
    BOOL isWeChat = [WXApi handleOpenURL:url delegate:[WG_WeChatTool shareInstance]];
    if (isWeChat) {
        return isWeChat;
    }
    
    BOOL isWeibo = [WeiboSDK handleOpenURL:url delegate:[WG_SinaTool shareInstance]];
    if (isWeibo) {
        return isWeibo;
    }
    
//    BOOL isQQ = [QQApiInterface handleOpenURL:url delegate:[WG_QQTool shareInstance]];
    BOOL isQQ = [TencentOAuth HandleOpenURL:url];
    if (isQQ) {
        return isQQ;
    }
    
    return YES;
//    return [WXApi handleOpenURL:url delegate:[WG_WeChatTool shareInstance]];
//    return [WeiboSDK handleOpenURL:url delegate:[WG_SinaTool shareInstance]];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    WGLog(@"url2:%@", url.absoluteString);
    BOOL isWeChat = [WXApi handleOpenURL:url delegate:[WG_WeChatTool shareInstance]];
    if (isWeChat) {
        return isWeChat;
    }
    
    BOOL isWeibo = [WeiboSDK handleOpenURL:url delegate:[WG_SinaTool shareInstance]];
    if (isWeibo) {
        return isWeibo;
    }
    
//    BOOL isQQ = [QQApiInterface handleOpenURL:url delegate:[WG_QQTool shareInstance]];
    BOOL isQQ = [TencentOAuth HandleOpenURL:url];
    if (isQQ) {
        return isQQ;
    }
    
    return YES;
//    return [WeiboSDK handleOpenURL:url delegate:[WG_SinaTool shareInstance]];
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    WGLog(@"url3:%@", url.absoluteString);
    BOOL isWeChat = [WXApi handleOpenURL:url delegate:[WG_WeChatTool shareInstance]];
    if (isWeChat) {
        return isWeChat;
    }
    
    BOOL isWeibo = [WeiboSDK handleOpenURL:url delegate:[WG_SinaTool shareInstance]];
    if (isWeibo) {
        return isWeibo;
    }
    
//    BOOL isQQ = [QQApiInterface handleOpenURL:url delegate:[WG_QQTool shareInstance]];
    BOOL isQQ = [TencentOAuth HandleOpenURL:url];
    if (isQQ) {
        return isQQ;
    }
    
    return YES;
//    return [WeiboSDK handleOpenURL:url delegate:[WG_SinaTool shareInstance]];
}
@end
