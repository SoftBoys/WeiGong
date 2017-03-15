//
//  AppDelegate+Map.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/17.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "AppDelegate+Map.h"
#import <BaiduMapAPI_Base/BMKMapManager.h>

@interface WG_BaiduMapManager : NSObject <BMKGeneralDelegate>
+ (instancetype)shareInstance;
- (void)wg_start;
@end
@implementation WG_BaiduMapManager{
    BMKMapManager *_mapManager;
}
+ (instancetype)shareInstance {
    static WG_BaiduMapManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[[self class] alloc] init];
    });
    return manager;
}
- (instancetype)init {
    if (self = [super init]) {
        _mapManager = [[BMKMapManager alloc] init];
    }
    return self;
}
- (void)wg_start {
    NSString *mapKey = @"IzaPWjxLg2I6YK90H95W0R07";
#ifdef DEBUG
    mapKey = @"IzaPWjxLg2I6YK90H95W0R07";
#endif
    BOOL ret = [_mapManager start:mapKey generalDelegate:self];
    if (ret) {
        WGLog(@"百度地图初始化成功");
    } else {
        WGLog(@"百度地图初始化失败");
    }
}
#pragma mark - BMKGeneralDelegate
- (void)onGetNetworkState:(int)iError {
    WGLog(@"网络错误状态码:%@", @(iError));
}
- (void)onGetPermissionState:(int)iError {
    WGLog(@"鉴权结果状态码:%@", @(iError));
}
@end

@implementation AppDelegate (Map)
- (void)setBaiduMap {
    
    [[WG_BaiduMapManager shareInstance] wg_start];
    
}

@end
