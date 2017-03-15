//
//  WG_SinaTool.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/17.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_SinaTool.h"

#import <WeiboSDK/WeiboSDK.h>

@implementation WG_SinaTool

+ (instancetype)shareInstance {
    static WG_SinaTool *tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[[self class] alloc] init];
    });
    return tool;
}

- (void)shareContent:(NSString *)content imageData:(NSData *)imageData {
    
    WBMessageObject *message = [WBMessageObject message];
    message.text = content;
    
    if (imageData) {
        WBImageObject *objc = [WBImageObject object];
        objc.imageData = imageData;
        message.imageObject = objc;
    }
    
    WBAuthorizeRequest *auth = [WBAuthorizeRequest request];
    auth.scope = @"all";
    auth.redirectURI = @"http://www.vvgong.com/down/";
    
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:auth access_token:self.access_token];
    [WeiboSDK sendRequest:request];
}

#pragma mark - WeiboSDKDelegate
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    
}
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    NSString *title = nil;
    if ([response isKindOfClass:[WBSendMessageToWeiboResponse class]]) {
        title = NSLocalizedString(@"分享结果", nil);
        WBSendMessageToWeiboResponse *sendMessageResponse = (WBSendMessageToWeiboResponse *)response;
        NSString *token = [sendMessageResponse.authResponse accessToken];
        if (token) {
            self.access_token = token;
        }
        NSString *userID = [sendMessageResponse.authResponse userID];
        if (userID) {
            self.userID = userID;
        }
        
        NSString *message = sendMessageResponse.userInfo[@"msg"];
        
        switch (sendMessageResponse.statusCode) {
            case WeiboSDKResponseStatusCodeSuccess:
                message = @"发送成功";
                break;
            case WeiboSDKResponseStatusCodeUserCancel:
                message = @"取消发送";
                break;
            case WeiboSDKResponseStatusCodeSentFail:
                message = @"发送失败";
                break;
            case WeiboSDKResponseStatusCodeAuthDeny:
                message = @"授权失败";
                break;
            case WeiboSDKResponseStatusCodeShareInSDKFailed:
                message = @"分享失败"; // 此时查看userinfo
                break;
                
            default:
                break;
        }
        
        [MBProgressHUD wg_message:message];
//        if (message) {
//            // TODO:展示信息提示
//            [UIAlertController wg_alertWithTitle:title message:message completion:^(UIAlertController *alert, NSInteger buttonIndex) {
//                
//            } cancel:@"cancel" sure:@"sure"];
//            
//        }
        
    } else if ([response isKindOfClass:[WBAuthorizeResponse class]]) {
        title = NSLocalizedString(@"认证结果", nil);
    } else if ([response isKindOfClass:[WBProvideMessageForWeiboResponse class]]) {
        title = NSLocalizedString(@"提供结果", nil);
    } else if ([response isKindOfClass:[WBPaymentResponse class]]) {
        title = NSLocalizedString(@"支付结果", nil);
    }
    
    if (title) {
        WGLog(@"title:%@", title);
    }
}

@end
