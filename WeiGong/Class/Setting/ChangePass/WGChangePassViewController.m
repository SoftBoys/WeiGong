//
//  WGChangePassViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/23.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGChangePassViewController.h"
#import "WGStepView.h"
#import "WGStepScrollView.h"
#import "WGChangePassAuthView.h"
#import "WGChangeConfirmPassView.h"

#import "WGChangeAccountParam.h"

#import "WGRequestManager.h"
#import "WG_UserDefaults.h"
#import "WGHuanxinTool.h"

@interface WGChangePassViewController ()
@property (nonatomic, strong) WGStepView *stepView;
@property (nonatomic, strong) WGStepScrollView *scrollView;
@property (nonatomic, strong) WGChangePassAuthView *authView;
@property (nonatomic, strong) WGChangeConfirmPassView *passView;
@property (nonatomic, copy) NSString *password_old;
@end

@implementation WGChangePassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor wg_colorWithHexString:@"#f4f4f4"];
    
    NSArray *titles = @[@"输入当前密码", @"输入新密码"];
    WGStepView *stepView = [WGStepView stepViewWithTitles:titles];
    stepView.wg_top = kTopBarHeight;
    [self.view addSubview:stepView];
    self.stepView = stepView;
    
    self.scrollView = [WGStepScrollView new];
    [self.view addSubview:self.scrollView];
    CGFloat scrollViewY = self.stepView.wg_bottom;
    self.scrollView.frame = CGRectMake(0, scrollViewY, kScreenWidth, kScreenHeight-scrollViewY);
    
    
    self.scrollView.contentViews = @[self.authView, self.passView];
    
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
- (void)submitWithNewPassword:(NSString *)newPassword {
    
    WGChangeAccountParam *param = [WGChangeAccountParam new];
    param.password_new = [newPassword wg_MD5];
    param.password_old = [self.password_old wg_MD5];
    
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
                [WGHuanxinTool wg_loginout];
                [self performSelector:@selector(wg_popToRootVC) withObject:nil afterDelay:0.3];
                
            }
        }
    }];
}
- (NSString *)resetPassUrl {
    return @"/linggb-ws/ws/0.1/adminuser/updatePwd";
}
- (void)dealloc {
    [WGRequestManager cancelTaskWithUrl:[self resetPassUrl]];
    [WGRequestManager cancelTaskWithUrl:[self authPasswordUrl]];
}
#pragma mark - getter && setter
- (WGChangePassAuthView *)authView {
    if (!_authView) {
        __weak typeof(self) weakself = self;
        _authView = [WGChangePassAuthView new];
        _authView.authHandle = ^(NSString *password) {
            __strong typeof(weakself) strongself = weakself;
            [strongself authWithPassword:password];
        };
    }
    return _authView;
}
- (WGChangeConfirmPassView *)passView {
    if (!_passView) {
        _passView = [WGChangeConfirmPassView new];
        __weak typeof(self) weakself = self;
        _passView.handle = ^(NSString *pass1, NSString *pass2) {
            __strong typeof(weakself) strongself = weakself;
            [strongself submitWithNewPassword:pass1];
        };
    }
    return _passView;
}

@end
