//
//  WG_RealReachability.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/10.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_RealReachability.h"
#import <RealReachability/RealReachability.h>

@implementation WG_RealReachability

+ (void)wg_startNotifier {
    
    GLobalRealReachability.hostForPing = @"www.baidu.com";
    [GLobalRealReachability reachabilityWithBlock:^(ReachabilityStatus status) {
        WGLog(@"status:%@", @(status));
    }];
    [GLobalRealReachability startNotifier];
}

+ (BOOL)wg_isConnectNet {
    BOOL isConnect = NO;
    if ([UIDevice wg_platformString]) {
        isConnect = YES;
    } else {
        ReachabilityStatus status = [GLobalRealReachability currentReachabilityStatus];
        switch (status) {
            case RealStatusViaWWAN:
                isConnect = YES;
                break;
            case RealStatusViaWiFi:
                isConnect = YES;
                break;
            default:
                isConnect = NO;
                break;
        }
    }
    
    return isConnect;
}
@end
