//
//  WG_JobDetailViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/21.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_JobDetailViewController.h"
#import "WG_JobDetailViewController+WG_Extension.h"
#import "UIViewController+Loading.h"
#import "WG_MoreAddressViewController.h"
#import "WG_TrafficPathViewController.h"
#import "WGChatViewController.h"
#import "WGApplyJobViewController.h"

#import "MBProgressHUD+WG_Extension.h"

#import "WGJobDetailParam.h"
#import "WG_JobDetail.h"
#import "WG_JobDetailShare.h"

#import "WG_JobNumberCell.h"
#import "WG_JobPlatformCell.h"
#import "WG_JobAddressCell.h"
#import "WG_JobContentCell.h"
#import "WG_JobPublishCell.h"
#import "WG_JobReminderCell.h"

#import "WG_JobFootView.h"

#import "WG_UserDefaults.h"

#import <SDWebImageManager.h>
#import "WG_RealReachability.h"

#import "WGRequestManager.h"

#import <WebViewJavascriptBridge/WKWebViewJavascriptBridge.h>



@interface WG_JobDetailViewController () <WG_JobFootViewDelegate>
@property (nonatomic, assign) NSUInteger requestId;
@property (nonatomic, strong) WG_JobDetail *detail;
@property (nonatomic, strong) WG_JobFootView *footView;
@property (nonatomic, strong) WKWebViewJavascriptBridge *bridge;
@end
@implementation WG_JobDetailViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    
    if (self.homeItem.jobDetailUrl) {
        self.webUrl = kStringAppend(self.homeItem.jobDetailUrl, @"&dtype=2");
    }
//    self.webUrl = @"";
    
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"nav_back_circle"];
    [self.backButton setImage:image forState:UIControlStateNormal];
    [self.backButton setImage:image forState:UIControlStateHighlighted];
    
    [self wg_setRightItem];
    
    self.webView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-49);
    self.webView.scrollView.contentSize = CGSizeZero;
    [self.webView sizeToFit];
    
    [self wg_setFootView];
    self.footView.hidden = self.detail == nil;
    
    [self setupJS];
    
}
- (void)setupJS {
    
    [WKWebViewJavascriptBridge enableLogging];
    self.bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.webView];
    
    [self.bridge registerHandler:@"locationWithData" handler:^(id data, WVJBResponseCallback responseCallback) {
//        WGLog(@"JS交互：%@", data);
        WGLog(@"JS交互定位");
        NSDictionary *jsonData = [data wg_JSONObject];
        if ([jsonData isKindOfClass:[NSDictionary class]]) {
            NSArray *jobplaces = jsonData[@"jobplaces"];
            NSArray <WG_JobAddressItem *> *addressItemList = [WG_JobAddressItem wg_modelArrayWithDictArray:jobplaces];
            if (addressItemList.count == 1) {
                WG_TrafficPathViewController *trafficVC = [WG_TrafficPathViewController new];
                trafficVC.item = [addressItemList firstObject];
                [self wg_pushVC:trafficVC];
            } else if (addressItemList.count > 1) {
                WG_MoreAddressViewController *addressVC = [WG_MoreAddressViewController new];
                addressVC.joblist = addressItemList;
                [self wg_pushVC:addressVC];
            }
        }
    }];
    
}

- (void)wg_loadData {
    
    if (self.homeItem == nil && self.jobId == nil) {
        WGLog(@"item and jobId is nil");
        return;
    }
   
    WG_HomeItem *item = self.homeItem;
    NSString *enterpriseJobId = item.enterpriseJobId ?: self.jobId;
    WGJobDetailParam *param = [WGJobDetailParam new];
    param.enterpriseJobId = enterpriseJobId;
    param.sign = [[NSString stringWithFormat:@"Dfhb@Rdd%@", enterpriseJobId] wg_MD5];
    param.personalInfoId = [WG_UserDefaults shareInstance].userId;
    
    NSString *url = self.requestUrl;
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:url];
    request.wg_parameters = [param wg_keyValues];
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        WGLog(@"stateCode:%@", @(response.statusCode));
        if (response.responseJSON) {
            
            WG_JobDetail *detail = [WG_JobDetail mj_objectWithKeyValues:response.responseJSON];
            self.detail = detail;
            self.footView.detail = detail;
            
            if (self.webUrl == nil) {
                self.webUrl = kStringAppend(detail.jobDetailUrl, @"&dtype=2");
                [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
            }
            
            self.title = detail.jobName;
            
            // 分享相关
            NSDictionary *jobShare = response.responseJSON[@"jobShare"];
            if (jobShare) {
                WG_JobDetailShare *share = [WG_JobDetailShare wg_modelWithDictionry:jobShare];
                share.content_sina = [NSString stringWithFormat:@"%@ %@ %@", share.title, share.content, share.linkUrl];
                
                [WGDownloadImageManager downloadImageWithUrl:share.picUrl completeHandle:^(BOOL finished, UIImage *image) {
                    if (image) {
                        share.icon = image;
                        share.imageData = UIImageJPEGRepresentation(image, 1);
                    }
                    self.share = share;
                }];
                
            }
            
        }
    }];
    
}


- (void)wg_setFootView {
    
    WG_JobFootView *footView = [WG_JobFootView new];
    footView.delegate = self;
    [self.view addSubview:footView];
    self.footView = footView;
    
    float footH = 49;
    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(footH);
    }];
}
#pragma mark - WG_JobFootViewDelegate
#pragma mark - 咨询
- (void)wg_consult {
    NSString *groupId = self.detail.huanXinGroupId;
    if (groupId.length) {
        
        [self wg_joinGroupWithGroupId:groupId competionHandle:^(EMGroup *group) {
            if (group) {
                NSString *title = group.subject;
                WGChatViewController *chatVC = [WGChatViewController wg_chatWithChatter:groupId];
                chatVC.title = title;
                [self wg_pushVC:chatVC];
            }
        }];
        
    } else {
        [MBProgressHUD wg_message:@"该职位未开通咨询功能"];
    }
}
- (void)wg_applyOrNot {
    
    // 立即申请
    if (_detail.postFlag == 0) {
        [self apply];
    } else if (_detail.postFlag == 1) { // 撤销申请
        NSString *title = @"提醒", *message = @"是否确认撤销申请";
        [UIAlertController wg_alertWithTitle:title message:message completion:^(UIAlertController *alert, NSInteger index) {
            if (index) {
                [self cancelApply];
            }
        } cancel:@"取消" sure:@"确认"];
        
    }
}
#pragma mark - 申请职位
- (void)apply {
    __weak typeof(self) weakself = self;
    WGApplyJobViewController *applyVC = [WGApplyJobViewController new];
    applyVC.detail = self.detail;
    applyVC.submitSuccessHandle = ^ () {
        __strong typeof(weakself) strongself = weakself;
        [strongself wg_loadData];
        [strongself wg_popToVC:self];
    };
    [self wg_pushVC:applyVC];
}
#pragma mark - 撤销申请
- (void)cancelApply {
    
    NSDictionary *param = @{@"personalJobId":@(self.detail.personalJobId)};
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:[self cancelApplyUrl] isPost:YES];
    request.wg_parameters = param;
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        if (response.statusCode == 200) {
            [self wg_loadData];
        }
        if ([response.responseJSON isKindOfClass:[NSDictionary class]]) {
            NSString *content = response.responseJSON[@"content"];
            [MBProgressHUD wg_message:content];
        }
    }];
}
- (NSString *)cancelApplyUrl {
    return @"/linggb-ws/ws/0.1/person/callBackPostJob";
}
#pragma mark - Private
- (UIColor *)navbarBackgroundColor {
    return kClearColor;
}
- (UIColor *)navbarTitleColor {
    return kClearColor;
}
- (BOOL)navbarLineHidden {
    return YES;
}
- (NSString *)requestUrl {
    return @"/linggb-ws/ws/0.1/job/jobDetail_v2";
}
- (void)dealloc {
    
    /** 取消请求 */
    NSString *url1 = @"/linggb-ws/ws/0.1/job/jobDetail_v2";
    NSString *url2 = @"/linggb-ws/ws/0.1/job/setJobfavorite";
//    NSString *url = @"/linggb-ws/ws/0.1/job/jobDetail_v2";
    
    [WGRequestManager cancelTaskWithUrl:url1];
    [WGRequestManager cancelTaskWithUrl:url2];
    [WGRequestManager cancelTaskWithUrl:[self cancelApplyUrl]];
}

@end
