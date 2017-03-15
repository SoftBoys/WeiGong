//
//  WG_QQTool.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/13.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WG_QQTool.h"
#import <TencentOpenAPI/QQApiInterface.h>

@implementation WG_QQTool

+ (BOOL)isInstalledQQ {
    return [TencentOAuth iphoneQQInstalled];
}

+ (instancetype)shareInstance {
    static WG_QQTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[WG_QQTool alloc] init];
    });
    return tool;
}

- (void)shareToSessionWithTitle:(NSString *)title content:(NSString *)content icon:(UIImage *)icon link:(NSString *)link {
    
    NSData *imageData = UIImageJPEGRepresentation(icon, 1.0);
    QQApiImageObject *imageObj = [QQApiImageObject objectWithData:imageData previewImageData:imageData title:title description:content imageDataArray:nil];
    
    SendMessageToQQReq *request = [SendMessageToQQReq reqWithContent:imageObj];
    
    QQApiSendResultCode send = [QQApiInterface sendReq:request];
    
    [self wg_messageWithSend:send];
}

- (void)shareToQzoneWithTitle:(NSString *)title content:(NSString *)content iconUrl:(NSString *)iconUrl link:(NSString *)link {
    
    link = link ?: @"";
    QQApiNewsObject *imageObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:link] title:title description:content previewImageURL:[NSURL URLWithString:iconUrl]];
//    imageObj.description = kStringAppend(content, link);
    
    
    SendMessageToQQReq *request = [SendMessageToQQReq reqWithContent:imageObj];
    QQApiSendResultCode send = [QQApiInterface SendReqToQZone:request];
    
    [self wg_messageWithSend:send];
}


- (void)wg_messageWithSend:(QQApiSendResultCode)send {
    
    NSString *message = nil;
    switch (send) {
        case EQQAPIAPPNOTREGISTED:
            message = @"app未注册";
            break;
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
            message = @"发送参数错误";
            break;
        case EQQAPIQQNOTINSTALLED:
            message = @"未安装手Q";
            break;
        case EQQAPIQQNOTSUPPORTAPI:
            message = @"API接口不支持";
            break;
        case EQQAPISENDFAILD:
            message = @"发送失败";
            break;
        case EQQAPIVERSIONNEEDUPDATE:
            message = @"当前QQ版本太低，需要更新";
            break;
            
        default:
            break;
    }
    
    [MBProgressHUD wg_message:message];
}


#pragma mark - TencentLoginDelegate
/** 登录成功后的回调 */
- (void)tencentDidLogin {
    
}

/** 登录失败后的回调
  \param cancelled 代表用户是否主动退出登录 */
- (void)tencentDidNotLogin:(BOOL)cancelled {
    
}

/** 登录时网络有问题的回调 */
- (void)tencentDidNotNetWork {
    
}

- (BOOL)tencentNeedPerformIncrAuth:(TencentOAuth *)tencentOAuth withPermissions:(NSArray *)permissions {
    return YES;
}
- (BOOL)tencentNeedPerformReAuth:(TencentOAuth *)tencentOAuth {
    return YES;
}
/** 分享到空间的回调 */
- (void)addShareResponse:(APIResponse*) response {
    
    if (response) {
        if (URLREQUEST_SUCCEED == response.retCode && kOpenSDKErrorSuccess == response.detailRetCode) {
            [MBProgressHUD wg_message:@"分享成功"];
        } else {
            [MBProgressHUD wg_message:response.errorMsg];
        }
    }
    
}
@end
