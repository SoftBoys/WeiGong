//
//  WG_WeChatTool.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/17.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_WeChatTool.h"

#import "WXApi.h"

@implementation WG_WeChatTool
+ (BOOL)isInstalledWeChat {
    return ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]);
}
+ (instancetype)shareInstance {
    static WG_WeChatTool *tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[[self class] alloc] init];
    });
    return tool;
}

- (void)shareToSessionWithTitle:(NSString *)title content:(NSString *)content icon:(UIImage *)icon link:(NSString *)link {
    [self shareTitle:title content:content icon:icon scene:0 link:link];
}

- (void)shareToTimelineWithTitle:(NSString *)title content:(NSString *)content icon:(UIImage *)icon link:(NSString *)link {
    [self shareTitle:title content:content icon:icon scene:1 link:link];
}

- (void)shareTitle:(NSString *)title content:(NSString *)content icon:(UIImage *)icon scene:(int)scene link:(NSString *)link {
    if (![WG_WeChatTool isInstalledWeChat]) {
        WGLog(@"请安装微信");
        return;
    }
    
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = content;
    
    if (icon) {
        [message setThumbImage:icon];
    }
    
    if (link) {
        WXWebpageObject *webObj = [WXWebpageObject object];
        webObj.webpageUrl = link;
        message.mediaObject = webObj;
    }
    
    SendMessageToWXReq *request = [[SendMessageToWXReq alloc] init];
    request.scene = scene;
    request.message = message;
    [WXApi sendReq:request];
}

#pragma mark - WXApiDelegate

- (void)onResp:(BaseResp *)resp {
    
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        SendMessageToWXResp *messageResp = (SendMessageToWXResp *)resp;
        
        NSString *message = nil;
        switch (messageResp.errCode) {
            case 0:
                message = @"分享成功";
                break;
            case -1:
                message = @"分享失败";
                break;
            case -2:
                message = @"取消分享";
                break;
                
            default:
                break;
        }
        [MBProgressHUD wg_message:message];
//        [UIAlertController wg_alertWithTitle:@"分享结果" message:message completion:^(UIAlertController *alert, NSInteger buttonIndex) {
//            
//        } cancel:@"cancel" sure:@"sure"];
    }
}
@end
