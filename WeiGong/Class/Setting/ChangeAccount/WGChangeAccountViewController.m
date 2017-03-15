//
//  WGChangeAccountViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/21.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGChangeAccountViewController.h"
#import "WGStepView.h"
#import "WGStepScrollView.h"
#import "WGChangeAuthView.h"
#import "WGChangeNewView.h"

#import "WG_UserDefaults.h"
#import "WGChangeAccountParam.h"

#import "WGRequestManager.h"
#import "WGHuanxinTool.h"

@interface WGChangeAccountViewController ()
@property (nonatomic, strong) WGStepView *stepView;
@property (nonatomic, strong) WGStepScrollView *scrollView;
@property (nonatomic, strong) WGChangeAuthView *authView;
@property (nonatomic, strong) WGChangeNewView *accountView;

@property (nonatomic, copy) NSString *password_old;
@end

@implementation WGChangeAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor wg_colorWithHexString:@"#f4f4f4"];
    WGStepView *stepView = [WGStepView stepViewWithTitles:nil];
    stepView.wg_top = kTopBarHeight;
    [self.view addSubview:stepView];
    self.stepView = stepView;
    NSArray *titles =  @[@"安全验证",@"设置新账号"];
    stepView.titles = titles;
    
    WGStepScrollView *scrollView = [WGStepScrollView new];
    [self.view addSubview:scrollView];
    scrollView.contentViews = @[self.authView,self.accountView];
    scrollView.wg_top = stepView.wg_bottom;
    scrollView.wg_width = self.view.wg_width;
    scrollView.wg_height = self.view.wg_height-scrollView.wg_top;
    self.scrollView = scrollView;
}
#pragma mark - 验证密码
- (void)authWithPassword:(NSString *)password {
    self.password_old = password;
//    [self.scrollView stepToPage:1 animated:YES completion:^{
//        self.stepView.currentIndex = 1;
//    }];
//    return;
    NSString *url = [self authPasswordUrl];
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:url isPost:YES];
    request.wg_parameters = @{@"password":[password wg_MD5]};
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        NSDictionary *data = response.responseJSON;
        if ([data isKindOfClass:[NSDictionary class]]) {
            NSInteger common = [data[@"common"] integerValue];
            if (common == 1) {
                [self.scrollView stepToPage:1 animated:YES completion:^{
                    self.stepView.currentIndex = 1;
                }];
            } else {
                NSString *message = data[@"content"];
                if (message) {
                    [MBProgressHUD wg_message:message];
                }
            }
        }
    }];
}

- (NSString *)authPasswordUrl {
    return @"/linggb-ws/ws/0.1/adminuser/checkPassword";
}

#pragma mark - 提交账号
- (void)submitWithPhone:(NSString *)phone authCode:(NSString *)authCode password:(NSString *)password {
    NSString *phone_old = [WG_UserDefaults shareInstance].loginPhoneNum;
    WGChangeAccountParam *param = [WGChangeAccountParam new];
    param.phone_old = phone_old;
    param.phone_new = phone;
    param.password_new = [password wg_MD5];
    param.password_old = [self.password_old wg_MD5];
    param.regCode = authCode;
    
    NSString *url = [self resetAccountUrl];
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:url isPost:YES];
    request.wg_parameters = [param wg_keyValues];
    
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        if ([response.responseJSON isKindOfClass:[NSDictionary class]]) {
            NSString *message = response.responseJSON[@"content"];
            if (message) {
                [MBProgressHUD wg_message:message];
            }
            if (response.statusCode == 200) {
//                [self performSelector:@selector(wg_pop) withObject:nil afterDelay:0.25];
                [[WG_UserDefaults shareInstance] loginOut];
                [WGHuanxinTool wg_loginout];
                [self performSelector:@selector(wg_popToRootVC) withObject:nil afterDelay:0.3];

            }
        }
    }];
}
- (NSString *)resetAccountUrl {
    return @"/linggb-ws/ws/0.1/adminuser/resetLoginName";
}
- (void)dealloc {
    [WGRequestManager cancelTaskWithUrl:[self resetAccountUrl]];
    [WGRequestManager cancelTaskWithUrl:[self authPasswordUrl]];
}
#pragma mark - getter && setter 
- (WGChangeAuthView *)authView {
    if (!_authView) {
        __weak typeof(self) weakself = self;
        _authView = [WGChangeAuthView new];
        _authView.authHandle = ^(NSString *password) {
            __strong typeof(weakself) strongself = weakself;
            [strongself authWithPassword:password];
        };
    }
    return _authView;
}
- (WGChangeNewView *)accountView {
    if (!_accountView) {
        __weak typeof(self) weakself = self;
        _accountView = [WGChangeNewView new];
//        _accountView.backgroundColor = kOrangeColor;
        _accountView.accountHandle = ^ (NSString *phone, NSString *authCode, NSString *newPassword) {
            __strong typeof(weakself) strongself = weakself;
            [strongself submitWithPhone:phone authCode:authCode password:newPassword];
        };
    }
    return _accountView;
}


@end
