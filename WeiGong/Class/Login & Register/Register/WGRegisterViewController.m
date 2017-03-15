//
//  WGRegisterViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/23.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGRegisterViewController.h"
#import "WG_WebViewController.h"
#import "WGStepView.h"
#import "WGStepScrollView.h"
#import "WGRegisterInputPhoneView.h"
#import "WGRegisterInputAuthView.h"
#import "WGRegisterInputPerfectView.h"

#import "WGGetAuthCodeParam.h"
#import "WGCheckCodeParam.h"
#import "WGRegisterParam.h"

#import "WGDataTypeItem.h"
#import "WG_CityItem.h"
#import "WGDataBaseTool.h"

#import "WGActionSheet.h"

#import "WG_LoginParam.h"
#import "WG_UserDefaults.h"

#import "WGRequestManager.h"
#import "WGCheckBoxView.h"
#import "WGPickerCityView.h"

@interface WGRegisterViewController ()
@property (nonatomic, strong) WGStepView *stepView;
@property (nonatomic, strong) WGStepScrollView *scrollView;
@property (nonatomic, strong) WGRegisterInputPhoneView *phoneView;
@property (nonatomic, strong) WGRegisterInputAuthView *authView;
@property (nonatomic, strong) WGRegisterInputPerfectView *perfectView;

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSArray <WGPickerCityItem *> *cityItemList;
@property (nonatomic, copy) NSArray <WGDataTypeItem *> *typeItemList;
@end

@implementation WGRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor wg_colorWithHexString:@"#f4f4f4"];
    self.title = @"注册";
    NSArray *titles = @[@"输入手机号", @"输入验证码", @"完善信息"];
    WGStepView *stepView = [WGStepView stepViewWithTitles:titles];
    stepView.wg_top = kTopBarHeight;
    [self.view addSubview:stepView];
    self.stepView = stepView;
    
    WGStepScrollView *scrollView = [WGStepScrollView new];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    CGFloat scrollViewY = self.stepView.wg_bottom;
    self.scrollView.frame = CGRectMake(0, scrollViewY, kScreenWidth, kScreenHeight-scrollViewY);
    
    self.scrollView.contentViews = @[self.phoneView, self.authView, self.perfectView];
    
    
//    [self.scrollView stepToPage:2 animated:YES completion:^{
//        self.stepView.currentIndex = 2;
//    }];
}

#pragma mark - getter && setter
- (WGStepScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [WGStepScrollView new];
    }
    return _scrollView;
}
- (WGRegisterInputPhoneView *)phoneView {
    if (!_phoneView) {
        __weak typeof(self) weakself = self;
        _phoneView = [WGRegisterInputPhoneView new];
        _phoneView.getCodeHandle = ^(NSString *phone) {
            __strong typeof(weakself) strongself = weakself;
            [strongself getCodeWithPhone:phone];
        };
        
        _phoneView.protocolHandle = ^() {
            NSString *protocolUrl = [WG_UserDefaults shareInstance].protocolUrl;
            __strong typeof(weakself) strongself = weakself;
            WG_WebViewController *webVC = [WG_WebViewController new];
            webVC.webUrl = protocolUrl;
            webVC.title = @"微工协议";
            [strongself wg_pushVC:webVC];
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
- (WGRegisterInputPerfectView *)perfectView {
    if (!_perfectView) {
        _perfectView = [WGRegisterInputPerfectView new];
        __weak typeof(self) weakself = self;
        _perfectView.cityHandle = ^(WGPickerCityItem *cityItem) {
            __strong typeof(weakself) strongself = weakself;
            [strongself tapCityItem:cityItem];
        };
        _perfectView.typeHandle = ^(NSArray <WGDataTypeItem *> *typeItemList) {
            __strong typeof(weakself) strongself = weakself;
            [strongself tapTypeItemList:typeItemList];
        };
        _perfectView.submitHandle = ^(NSString *pass, NSString *name, WGPickerCityItem *cityItem,  NSArray<WGDataTypeItem *> *typeItemList, NSString *address) {
            __strong typeof(weakself) strongself = weakself;
            [strongself submitWithPass:pass name:name cityItem:cityItem typeItemList:typeItemList address:address];
        };
    }
    return _perfectView;
}

- (void)tapCityItem:(WGPickerCityItem *)cityItem {
    [self.view endEditing:YES];
    
    [WGPickerCityView pickerWithCityItems:self.cityItemList currentCityItem:cityItem completionHandle:^(WGPickerCityItem *item) {
        if (item) {
//            WGPickerCityItem *subcityItem = item.subItems[item.index_sel];
            self.perfectView.cityItem = item;
        }
    }];
    
    
    
}
- (void)tapTypeItemList:(NSArray <WGDataTypeItem *> *)typeItemList {
    [self.view endEditing:YES];
    NSString *title = @"工作岗位";
    NSMutableArray *boxItems = @[].mutableCopy;
    for (NSInteger i = 0; i < self.typeItemList.count; i++) {
        WGDataTypeItem *item = self.typeItemList[i];
        WGCheckBoxItem *boxItem = [WGCheckBoxItem new];
        boxItem.code = item.code;
        boxItem.name = item.name;
        BOOL selected = NO;
        for (NSInteger j = 0; j < typeItemList.count; j++) {
            WGDataTypeItem *item_sel = typeItemList[j];
            if (item.code == item_sel.code) {
                selected = YES;
                break;
            }
        }
        boxItem.selected = selected;
        [boxItems wg_addObject:boxItem];
    }
    
    [WGCheckBoxView boxViewWithTitle:title boxItems:boxItems completionHandle:^(NSArray<WGCheckBoxItem *> *boxItems) {
        if (boxItems) {
            NSMutableArray *typeItemList = @[].mutableCopy;
            for (WGCheckBoxItem *boxItem in boxItems) {
                if (boxItem.selected) {
                    WGDataTypeItem *item = [WGDataTypeItem new];
                    item.code = boxItem.code;
                    item.name = boxItem.name;
                    [typeItemList wg_addObject:item];
                }
            }
            self.perfectView.typeItemList = typeItemList;
        }
    }];
    
}

#pragma mark - 获取验证码
- (void)getCodeWithPhone:(NSString *)phone {
    self.phone = phone;
    
    WGGetAuthCodeParam *param = [WGGetAuthCodeParam new];
    param.phoneNum = phone;
    param.tag = 1;
    
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
    param.tag = 1;
    
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
#pragma mark - 注册
- (void)submitWithPass:(NSString *)pass name:(NSString *)name cityItem:(WGPickerCityItem *)cityItem typeItemList:(NSArray <WGDataTypeItem *>*)typeItemList address:(NSString *)address {
    WGPickerCityItem *subcityItem = [cityItem.subItems wg_objectAtIndex:cityItem.index_sel];
    WGRegisterParam *param = [WGRegisterParam new];
    param.passWord = [pass wg_MD5];
    param.phoneNum = self.phone;
    param.regCode = self.code;
    param.cityCode = subcityItem.cityCode;
    param.cityName = subcityItem.city;
    param.address = address;
    param.personalName = name;
    
    NSMutableArray *markIdList = @[].mutableCopy;
    NSMutableArray *markNameList = @[].mutableCopy;
    for (WGDataTypeItem *item in typeItemList) {
        [markIdList wg_addObject:@(item.code)];
        [markNameList wg_addObject:item.name];
    }
    
    param.markId = [markIdList componentsJoinedByString:@","];
    param.markName = [markNameList componentsJoinedByString:@","];
    
    WGLog(@"注册：%@",[param wg_keyValues]);
    
    [MBProgressHUD wg_showHub_CanTap];
    NSString *url = [self registerUrl];
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:url isPost:YES];
    request.wg_parameters = [param wg_keyValues];
    
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        [MBProgressHUD wg_hideHub];
        if ([response.responseJSON isKindOfClass:[NSDictionary class]]) {
            NSString *message = response.responseJSON[@"content"];
            if (message) {
                [MBProgressHUD wg_message:message];
            }
            if (response.statusCode == 200) {
                [self loginWithPhone:param.phoneNum pass:pass];
            }
        }
    }];
}

- (NSString *)registerUrl {
    return @"/linggb-ws/ws/0.1/person/regist";
}

#pragma mark - 登陆
- (void)loginWithPhone:(NSString *)phone pass:(NSString *)pass {
    
    if (self.successHandle) {
        self.successHandle(phone, pass);
    }
    return;
    WG_LoginParam *param = [WG_LoginParam new];
    param.userName = phone;
    param.passWord = [pass wg_MD5];
    param.automaticLogin = 1;
    param.deviceType = 2;
    param.deviceToken = [[WG_UserDefaults shareInstance] deviceToken];
    
    NSString *url = [self loginUrl];
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:url isPost:YES];
    request.wg_parameters = [param wg_keyValues];
    
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        if ([response.responseJSON isKindOfClass:[NSDictionary class]]) {
            NSString *message = response.responseJSON[@"content"];
            if (message) {
                [MBProgressHUD wg_message:message];
            }
            if (response.statusCode == 200) {
                [self wg_dismissWithCompletion:^{
                    
                }];
            } else {
                [self wg_popToRootVC];
            }
        }
    }];
    
}
- (NSString *)loginUrl {
    return @"/linggb-ws/ws/0.1/person/login";
}

- (NSArray<WGPickerCityItem *> *)cityItemList {
    if (!_cityItemList) {
        NSArray *array = [WGDataBaseTool getObjectById:kCityListKey];
        NSArray *list = [WGPickerCityItem wg_modelArrayWithDictArray:array];
        _cityItemList = list;
    }
    return _cityItemList;
}
- (NSArray<WGDataTypeItem *> *)typeItemList {
    if (!_typeItemList) {
        NSArray *array = [WGDataBaseTool getObjectById:kDataCodeKey];
        NSArray <WGDataTypeItem *> *list = [WGDataTypeItem wg_modelArrayWithDictArray:array];
        
        NSMutableArray *muArray = @[].mutableCopy;
        [list enumerateObjectsUsingBlock:^(WGDataTypeItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.typeId == 11) {
                [muArray wg_addObject:obj];
            }
        }];
        
        _typeItemList = [muArray copy];
    }
    return _typeItemList;
}

- (void)dealloc {
    [WGRequestManager cancelTaskWithUrl:[self authCodeUrl]];
    [WGRequestManager cancelTaskWithUrl:[self registerUrl]];
    [WGRequestManager cancelTaskWithUrl:[self loginUrl]];
}
@end
