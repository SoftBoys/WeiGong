//
//  WG_RealReachability.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/10.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WG_RealReachability : NSObject
/** 开启网络监测 */
+ (void)wg_startNotifier;
/** 网络是否连接 */
+ (BOOL)wg_isConnectNet;
@end
