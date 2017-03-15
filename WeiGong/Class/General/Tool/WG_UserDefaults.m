//
//  WG_UserDefaults.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/12.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_UserDefaults.h"

NSString *const kIsFirstOpenKey = @"kIsFirstOpenKey";
NSString *const kUserIdKey = @"kUserIdKey";
NSString *const kUserNameKey = @"kUserNameKey";
NSString *const kPhoneNumKey = @"kPhoneNumKey";
NSString *const kIsLoginKey = @"kIsLoginKey";
NSString *const kDeviceTokenKey = @"kDeviceTokenKey";
NSString *const kHelpUrlKey = @"kHelpUrlKey";
NSString *const kProtocolUrlKey = @"kProtocolUrlKey";

@implementation WG_UserDefaults

- (NSUserDefaults *)userDefault {
    return [NSUserDefaults standardUserDefaults];
}

+ (instancetype)shareInstance {
    static WG_UserDefaults *user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[WG_UserDefaults alloc] init];
    });
    return user;
}

- (void)setIsFirstOpen:(BOOL)isFirstOpen {
    if (!isFirstOpen) {
        [self.userDefault setObject:kIsFirstOpenKey forKey:kIsFirstOpenKey];
    } else {
        [self.userDefault removeObjectForKey:kIsFirstOpenKey];
    }
    [self.userDefault synchronize];
}
- (BOOL)isFirstOpen {
    return [self.userDefault objectForKey:kIsFirstOpenKey] == nil;
}

- (void)setUserId:(NSString *)userId {
    if (userId) {
        [self.userDefault setObject:userId forKey:kUserIdKey];
        [self.userDefault synchronize];
    }
}
- (NSString *)userId {
    return [self.userDefault objectForKey:kUserIdKey];
}
- (void)setUserName:(NSString *)userName {
    if (userName) {
        [self.userDefault setObject:userName forKey:kUserNameKey];
        [self.userDefault synchronize];
    }
}
- (NSString *)userName {
    return [self.userDefault objectForKey:kUserNameKey];
}

- (void)setLoginPhoneNum:(NSString *)loginPhoneNum {
    if (loginPhoneNum) {
        [self.userDefault setObject:loginPhoneNum forKey:kPhoneNumKey];
        [self.userDefault synchronize];
    }
}
- (NSString *)loginPhoneNum {
    return [self.userDefault objectForKey:kPhoneNumKey];
}

- (BOOL)isLogin {
    return [self.userDefault objectForKey:kUserIdKey] != nil;
}
- (void)setHuanxinUserName:(NSString *)huanxinUserName {
    [[self userDefault] setObject:huanxinUserName forKey:@"huanxinUserName"];
}
- (NSString *)huanxinUserName {
    return [[self userDefault] objectForKey:@"huanxinUserName"];
}
- (void)setAdminUserId:(NSString *)adminUserId {
    [self.userDefault setObject:adminUserId forKey:@"adminUserId"];
}
- (NSString *)adminUserId {
    return [self.userDefault objectForKey:@"adminUserId"];
}
- (void)setIconUrl:(NSString *)iconUrl {
    [[self userDefault] setObject:iconUrl forKey:@"iconUrl"];
}
- (NSString *)iconUrl {
    return [[self userDefault] objectForKey:@"iconUrl"];
}
- (void)setDeviceToken:(NSString *)deviceToken {
    if (deviceToken) {
        [self.userDefault setObject:deviceToken forKey:kDeviceTokenKey];
        [self.userDefault synchronize];
    }
}
- (NSString *)deviceToken {
    return [self.userDefault objectForKey:kDeviceTokenKey];
}

- (void)loginOut {
    [self.userDefault removeObjectForKey:kUserIdKey];
}

- (void)setHelpUrl:(NSString *)helpUrl {
    if (helpUrl != nil) {
        [self.userDefault setObject:helpUrl forKey:kHelpUrlKey];
        [self.userDefault synchronize];
    }
}
- (NSString *)helpUrl {
    return [self.userDefault objectForKey:kHelpUrlKey];
}
- (void)setProtocolUrl:(NSString *)protocolUrl {
    if (protocolUrl != nil) {
        [self.userDefault setObject:protocolUrl forKey:kProtocolUrlKey];
        [self.userDefault synchronize];
    }
}
- (NSString *)protocolUrl {
    return [self.userDefault objectForKey:kProtocolUrlKey];
}
@end
