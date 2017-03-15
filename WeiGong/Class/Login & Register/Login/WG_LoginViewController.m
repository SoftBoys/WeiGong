//
//  WG_LoginViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/19.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_LoginViewController.h"
#import "WG_LoginBackView.h"

#import "WG_LoginUser.h"
#import "WG_UserDefaults.h"
#import "WG_LoginParam.h"

#import "WGHuanxinTool.h"

#import "WGRegisterViewController.h"
#import "WGForgetPassViewController.h"

@interface WG_LoginViewController () <WG_LoginBackViewDelegate>
@property (nonatomic, strong) WG_LoginBackView *backView;

@property (nonatomic, assign) NSUInteger requestId;
@end

@implementation WG_LoginViewController
- (UIColor *)navbarTitleColor {
    return kColor_White;
}
- (BOOL)navbarLineHidden {
    return YES;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.backView.phoneField becomeFirstResponder];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.backButton.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navBar.hidden = YES;
//    self.title = @"登录";
    
    self.statusBarStyle = UIStatusBarStyleDefault;
    [self login_navBar];
    
}
- (void)login_navBar {
    self.navBar.backgroundColor = [UIColor clearColor];
    
    // 重定义返回按钮
    UIButton *backBtn = self.backButton;
    backBtn.hidden = NO;
    
    [backBtn setImage:[UIImage imageNamed:@"nav_white_back"] forState:UIControlStateNormal];
    // 获取点击事件方法名
    
    backBtn.tintColor = kColor_White;
    
    __weak typeof(self) weakself = self;
    [backBtn setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        __strong typeof(weakself) strongself = weakself;
        [strongself wg_dismiss];
    }];
    
    
    //
    [self.view insertSubview:self.backView belowSubview:self.navBar];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)loginWithPhone:(NSString *)phone pass:(NSString *)pass {
    NSString *url = self.requestUrl;
    WG_LoginParam *param = [WG_LoginParam new];
    param.userName = phone;
    param.passWord = [pass wg_MD5];
    param.automaticLogin = 1;
    param.deviceType = 2;
    param.deviceToken = [[WG_UserDefaults shareInstance] deviceToken];
    
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:url isPost:YES];
    request.wg_parameters = [param mj_keyValues];
    [MBProgressHUD wg_showHub_CanTap];
    self.backView.isLoging = YES;
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        [MBProgressHUD wg_hideHub];
        self.backView.isLoging = NO;
        if (response.statusCode == 200) {
            if ([response.responseJSON isKindOfClass:[NSDictionary class]]) {
                WG_LoginUser *user = [WG_LoginUser mj_objectWithKeyValues:response.responseJSON];
                [WG_UserDefaults shareInstance].userId = [NSString stringWithFormat:@"%@", @(user.personalInfoId)];
                [WG_UserDefaults shareInstance].userName = user.personalName;
                [WG_UserDefaults shareInstance].loginPhoneNum = user.adminUserName;
                [WG_UserDefaults shareInstance].adminUserId = user.adminUserId;
                [WG_UserDefaults shareInstance].huanxinUserName = user.huanxinUserName;
                [WG_UserDefaults shareInstance].iconUrl = user.picUrl;
                
                NSString *pass = kStringAppend(user.adminUserId, @"@WeiGongRdd");
                [WGHuanxinTool wg_loginWithName:user.huanxinUserName pass:[pass wg_MD5]];
                
                [self successWithResponse:response];
            }
        } else {
            NSString *content = response.responseJSON[@"content"];
            if (content) {
                [MBProgressHUD wg_message:content];
            }
        }
        // TODO: 解析登陆成功数据
        
        
    }];
}


#pragma mark - WG_LoginBackViewDelegate
- (void)wg_loginWithPhone:(NSString *)phone pass:(NSString *)pass {
    if (phone.length == 0) {
        [self.backView.phoneField becomeFirstResponder];
        [MBProgressHUD wg_message:@"请输入手机号"];
        return;
    }
    if (![phone wg_isPhone]) {
        [self.backView.phoneField becomeFirstResponder];
        
        [MBProgressHUD wg_message:@"请输入正确手机号"];
        return;
    }
    if ([pass length] == 0) {
        [self.backView.passField becomeFirstResponder];

        [MBProgressHUD wg_message:@"请输入密码"];
        return;
    }
    
    
    [self.view endEditing:YES];
    [self loginWithPhone:phone pass:pass];
}
- (void)successWithResponse:(WGBaseResponse *)response {
    
    if (self.loginSuccessHandle) {
        self.loginSuccessHandle(response);
    }
    [self wg_dismiss];
}
- (void)wg_delegateRegister {
    // TODO:跳转注册页面
    __weak typeof(self) weakself = self;
    WGRegisterViewController *registerVC = [WGRegisterViewController new];
    registerVC.successHandle = ^(NSString *phone, NSString *pass) {
        __strong typeof(weakself) strongself = weakself;
        [strongself wg_popToVC:strongself];
        [strongself loginWithPhone:phone pass:pass];
    };
    [self wg_pushVC:registerVC];
}
- (void)wg_delegateForget {
    // TODO:跳转忘记密码
    WGForgetPassViewController *forgetPassVC = [WGForgetPassViewController new];
    [self wg_pushVC:forgetPassVC];
}
#pragma mark - getter && setter
- (WG_LoginBackView *)backView {
    if (!_backView) {
        _backView = [WG_LoginBackView new];
        _backView.wg_delegate = self;
    }
    return _backView;
}

- (NSString *)requestUrl {
    return @"/linggb-ws/ws/0.1/person/login";
}

@end
