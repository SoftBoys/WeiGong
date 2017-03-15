//
//  WGHuanxinTool.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/28.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGHuanxinTool.h"
#import "WG_UserDefaults.h"

#import <EMSDK.h>
#import "EaseSDKHelper.h"

@implementation WGHuanxinTool

+ (void)wg_loginWithName:(NSString *)name pass:(NSString *)pass {
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = [[EMClient sharedClient] loginWithUsername:name password:pass];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                //设置是否自动登录
                [[EMClient sharedClient].options setIsAutoLogin:YES];
                
                //获取数据库中数据
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [[EMClient sharedClient] migrateDatabaseToLatestSDK];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
//                        [[ChatDemoHelper shareHelper] asyncPushOptions];
                        //发送自动登陆状态通知
                        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@([[EMClient sharedClient] isLoggedIn])];
                    });
                });
            }
        });
    });
    
    
}

+ (void)wg_loginout {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = [[EMClient sharedClient] logout:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error != nil) {
                [MBProgressHUD wg_message:error.errorDescription];
            }
            else{
                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
            }
        });
    });
}

@end
