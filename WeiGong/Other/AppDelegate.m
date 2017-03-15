//
//  AppDelegate.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/12.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "AppDelegate.h"
#import "WG_RootTool.h"

#import "AppDelegate+Share.h"
#import "AppDelegate+UMeng.h"
#import "AppDelegate+WG_Noti.h"
#import "AppDelegate+CheckVersion.h"
#import "AppDelegate+Map.h"
#import "AppDelegate+Chat.h"

#import <Bugly/Bugly.h>
#import <JPFPSStatus/JPFPSStatus.h>


@interface AppDelegate () 

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self setUMeng];
    
    [self setUMessageWithOptions:launchOptions];
    
    [self setWechat];
    
    [self setSina];
    
    [self setQQ];
    
    [self setBaiduMap];
    
    [self wg_addNoti];
    
    [self wg_checkVersion];
    
    [self wg_updateLocalData];
    
    [self easemobApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    [Bugly startWithAppId:@"902f7e03ba"];
    
    [WG_RootTool setRootController];
    
#ifdef DEBUG
    [[JPFPSStatus sharedInstance] open];
#endif
    
    return YES;
}


@end
