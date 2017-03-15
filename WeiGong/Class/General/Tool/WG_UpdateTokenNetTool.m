//
//  WG_UpdateTokenNetTool.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/24.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_UpdateTokenNetTool.h"
#import "UDIDManager.h"
#import "WG_UserDefaults.h"

@interface WG_UpdateTokenParam : NSObject

@property (nonatomic, copy) NSString *deviceToken;

@property (nonatomic, assign) NSUInteger typeId;

@property (nonatomic, assign) NSUInteger deviceType;

@property (nonatomic, copy) NSString *deviceVersion;

@property (nonatomic, copy) NSString *deviceId;

@end

@implementation WG_UpdateTokenParam

@end

@implementation WG_UpdateTokenNetTool

+ (void)wg_toolWithDeviceToken:(NSString *)deviceToken {
    
    WG_UpdateTokenParam *param = [WG_UpdateTokenParam new];
    param.deviceVersion = [[UIDevice currentDevice] systemVersion];
    param.deviceId = [UDIDManager UDID];
    param.typeId = 2;
    param.deviceType = 2;
    param.deviceToken = deviceToken;
    
    NSString *token = [WG_UserDefaults shareInstance].deviceToken;
    
    if (token && [deviceToken isEqualToString:token]) return;
    
    [WG_UserDefaults shareInstance].deviceToken = deviceToken;
    
    NSString *url = @"/linggb-ws/ws/0.1/token/uploadDeviceInfo";
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:url isPost:YES];
    request.wg_parameters = [param mj_keyValues];
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        
    }];
    
}
@end
