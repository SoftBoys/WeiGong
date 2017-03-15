//
//  WGForgetPassViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/2.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGForgetPassViewController.h"

#import "WGStepView.h"
#import "WGStepScrollView.h"
#import "WGRegisterInputPhoneView.h"
#import "WGRegisterInputAuthView.h"
#import "WGForgetPassSetPassView.h"

#import "WGForgetPassResetPassParam.h"
#import "WG_UserDefaults.h"

#import "WGGetAuthCodeParam.h"
#import "WGCheckCodeParam.h"

#import "WGRequestManager.h"

@interface WGForgetPassViewController ()
@property (nonatomic, strong) WGStepView *stepView;
@property (nonatomic, strong) WGStepScrollView *scrollView;
@property (nonatomic, strong) WGRegisterInputPhoneView *phoneView;
@property (nonatomic, strong) WGRegisterInputAuthView *authView;
@property (nonatomic, strong) WGForgetPassSetPassView *setpassView;

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *pass;

@end

@implementation WGForgetPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    self.view.backgroundColor = [UIColor wg_colorWithHexString:@"#f4f4f4"];
    
    NSArray *titles = @[@"输入手机号", @"输入验证码", @"设置密码"];
    WGStepView *stepView = [WGStepView stepViewWithTitles:titles];
    stepView.wg_top = kTopBarHeight;
    [self.view addSubview:stepView];
    self.stepView = stepView;
    
    WGStepScrollView *scrollView = [WGStepScrollView new];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    CGFloat scrollViewY = self.stepView.wg_bottom;
    self.scrollView.frame = CGRectMake(0, scrollViewY, kScreenWidth, kScreenHeight-scrollViewY);
    
    self.scrollView.contentViews = @[self.phoneView, self.authView, self.setpassView];
    
    
}

#pragma mark - getter && setter
- (WGRegisterInputPhoneView *)phoneView {
    if (!_phoneView) {
        __weak typeof(self) weakself = self;
        _phoneView = [WGRegisterInputPhoneView new];
        _phoneView.isRegister = NO;
        _phoneView.getCodeHandle = ^(NSString *phone) {
            __strong typeof(weakself) strongself = weakself;
            [strongself getCodeWithPhone:phone];
        };
    }
    return _phoneView;
}
- (WGRegisterInputAuthView *)authView {
    if (!_authView) {
        _authView = [WGRegisterInputAuthView new];
        __weak typeof(self) weakself = self;
        _authView.authHandle = ^(NSString *phone, NSString *code) {
            __strong typeof(weakself) strongself = weakself;
            [strongself authWithPhone:phone code:code];
            
        };
        _authView.getCodeHandle = ^(NSString *phone) {
            __strong typeof(weakself) strongself = weakself;
            [strongself getCodeWithPhone:phone];
        };
    }
    return _authView;
}
- (WGForgetPassSetPassView *)setpassView {
    if (!_setpassView) {
        _setpassView = [WGForgetPassSetPassView new];
        __weak typeof(self) weakself = self;
        _setpassView.handle = ^(NSString *pass1, NSString *pass2) {
            __strong typeof(weakself) strongself = weakself;
            [strongself submitWithNewPassword:pass1];
        };
    }
    return _setpassView;
}


#pragma mark - 获取验证码
- (void)getCodeWithPhone:(NSString *)phone {
    self.phone = phone;
    
    WGGetAuthCodeParam *param = [WGGetAuthCodeParam new];
    param.phoneNum = phone;
    param.tag = 3;
    
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:[self authCodeUrl]];
    request.wg_parameters = [param wg_keyValues];
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        
        if ([response.responseJSON isKindOfClass:[NSDictionary class]]) {
            NSString *content = response.responseJSON[@"content"];
            [MBProgressHUD wg_message:content];
        }
        
        if (response.statusCode == 200) {
            self.authView.phone = phone;
            [self.authView startTiming];
            [self.scrollView stepToPage:1 animated:YES completion:^{
                self.stepView.currentIndex = 1;
            }];
        }
    }];
}
- (NSString *)authCodeUrl {
    return @"/linggb-ws/ws/0.1/regcode/getcode";
}
#pragma mark - 验证
- (void)authWithPhone:(NSString *)phone code:(NSString *)code {
    self.phone = phone;
    self.code = code;
    
    WGCheckCodeParam *param = [WGCheckCodeParam new];
    param.phoneNum = phone;
    param.regCode = code;
    param.tag = 3;
    
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:[self checkCodeUrl]];
    request.wg_parameters = [param wg_keyValues];
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        
        if ([response.responseJSON isKindOfClass:[NSDictionary class]]) {
            NSString *content = response.responseJSON[@"content"];
            [MBProgressHUD wg_message:content];
        }
        
        if (response.statusCode == 200) {
            [self.scrollView stepToPage:2 animated:YES completion:^{
                self.stepView.currentIndex = 2;
            }];
        }
    }];
    
    
}
- (NSString *)checkCodeUrl {
    return @"/linggb-ws/ws/0.1/regcode/checkRegCode";
}

#pragma mark - 提交密码
- (void)submitWithNewPassword:(NSString *)newPassword {
    
    WGForgetPassResetPassParam *param = [WGForgetPassResetPassParam new];
    param.passWord = [newPassword wg_MD5];
    param.phoneNum = self.phone;
    param.regCode = self.code;
    
    NSString *url = [self resetPassUrl];
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:url isPost:YES];
    request.wg_parameters = [param wg_keyValues];
    
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        if ([response.responseJSON isKindOfClass:[NSDictionary class]]) {
            NSString *message = response.responseJSON[@"content"];
            if (message) {
                [MBProgressHUD wg_message:message];
            }
            if (response.statusCode == 200) {
                
                [[WG_UserDefaults shareInstance] loginOut];
                [self performSelector:@selector(wg_popToRootVC) withObject:nil afterDelay:0.3];
                
            }
        }
    }];
}

- (NSString *)resetPassUrl {
    return @"/linggb-ws/ws/0.1/person/reset";
}

- (void)dealloc {
    [WGRequestManager cancelTaskWithUrl:[self authCodeUrl]];
    [WGRequestManager cancelTaskWithUrl:[self checkCodeUrl]];
    [WGRequestManager cancelTaskWithUrl:[self resetPassUrl]];
}
@end
