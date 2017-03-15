//
//  WG_JobDetailViewController+WG_Extension.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/7.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_JobDetailViewController+WG_Extension.h"

#import "WGActionSheet.h"
#import "WG_SinaTool.h"
#import "WG_WeChatTool.h"
#import "WG_QQTool.h"

#import "WG_JobDetailShare.h"
#import <objc/runtime.h>

@interface WG_JobDetailViewController () <WeiboSDKDelegate, WXApiDelegate>

@end

@implementation WG_JobDetailViewController (WG_Extension)
static void *shareKey;
- (void)setShare:(WG_JobDetailShare *)share {
    objc_setAssociatedObject(self, &shareKey, share, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (WG_JobDetailShare *)share {
    return objc_getAssociatedObject(self, &shareKey);
}
- (void)wg_setRightItem {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(wg_share) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = kFont_15;
//    [button setTitleColor:kColor_Black forState:UIControlStateNormal];
//    [button setTitle:@"分享" forState:UIControlStateNormal];
    UIImage *image = [UIImage imageNamed:@"detail_share"];
    [button setImage:image forState:UIControlStateNormal];
    
    [self.navBar addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kStatusBarHeight);
        make.right.bottom.mas_equalTo(0);
        make.width.mas_equalTo(50);
    }];
    
//    [button setBackgroundImage:[UIImage wg_imageWithColor:[UIColor clearColor] size:CGSizeMake(44, 44) cornerRadius:4 borderColor:kColor_Orange borderWidth:kLineHeight] forState:UIControlStateNormal];
}

- (void)wg_share {
    
    if (self.share == nil) {
        WGLog(@"分享职位无效");
        return;
    }
    
    NSMutableArray *titles = @[@"微博"].mutableCopy;
    if ([WG_WeChatTool isInstalledWeChat]) {
        [titles addObjectsFromArray:@[@"朋友圈", @"微信好友"]];
    }
    if ([WG_QQTool isInstalledQQ]) {
        [titles addObjectsFromArray:@[@"手机QQ", @"空间"]];
    }
    
    [WGActionSheet actionSheetWithTitle:nil completionHandle:^(WGActionSheet *sheet, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [[WG_SinaTool shareInstance] shareContent:self.share.content_sina imageData:self.share.imageData];
        } else if (buttonIndex == 2) {
            [[WG_WeChatTool shareInstance] shareToTimelineWithTitle:self.share.title content:self.share.content icon:self.share.icon link:self.share.linkUrl];
        } else if (buttonIndex == 3) {
            [[WG_WeChatTool shareInstance] shareToSessionWithTitle:self.share.title content:self.share.content icon:self.share.icon link:self.share.linkUrl];
        } else if (buttonIndex == 4) {
            [[WG_QQTool shareInstance] shareToSessionWithTitle:self.share.title content:self.share.content icon:self.share.icon link:self.share.linkUrl];
        } else if (buttonIndex == 5) {
            [[WG_QQTool shareInstance] shareToQzoneWithTitle:self.share.title content:self.share.content iconUrl:self.share.picUrl link:self.share.linkUrl];
        }
    } cancel:@"取消" others:titles];
    
}


- (void)wg_joinGroupWithGroupId:(NSString *)groupId competionHandle:(void (^)(EMGroup *))handle {
    if (groupId == nil) {
        if (handle) {
            handle(nil);
        }
    }
    NSDictionary *param = @{@"groupId":groupId,@"flag":@(1)};
    NSString *url = @"/linggb-ws/ws/0.1/person/addOrRemoveGroups";
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:url isPost:YES];
    request.wg_parameters = param;
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        if ([response.responseJSON isKindOfClass:[NSDictionary class]]) {
            NSString *messgae = response.responseJSON[@"content"];
            [MBProgressHUD wg_message:messgae];
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            EMError *error = nil;
            EMGroup *group = [[EMClient sharedClient].groupManager fetchGroupInfo:groupId includeMembersList:YES error:&error];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (handle) {
                    handle(group);
                }
            });
        });

    }];
}

@end
