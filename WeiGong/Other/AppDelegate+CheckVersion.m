//
//  AppDelegate+CheckVersion.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/24.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "AppDelegate+CheckVersion.h"
#import <objc/runtime.h>

#import "WG_UserDefaults.h"
#import "WGDataBaseTool.h"

@interface WG_CheckVersion : NSObject
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *dbVersion;
@property (nonatomic, assign) NSUInteger forceUpdate;
@property (nonatomic, copy) NSString *help;
@property (nonatomic, copy) NSString *protocol;
@property (nonatomic, copy) NSString *lowestVersion;
@property (nonatomic, copy) NSString *version;
@end


@implementation WG_CheckVersion
@end

@interface AppDelegate ()
@property (nonatomic, copy) NSString *up_message;
@property (nonatomic, strong) UIAlertController *wg_alert;
@end
const void *itemKey, *messageKey, *alertKey;
@implementation AppDelegate (CheckVersion)
- (void)setWg_updateItem:(WG_UpdateItem *)wg_updateItem {
    objc_setAssociatedObject(self, &itemKey, wg_updateItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (WG_UpdateItem *)wg_updateItem {
    return objc_getAssociatedObject(self, &itemKey);
}
- (void)setUp_message:(NSString *)up_message {
    objc_setAssociatedObject(self, &messageKey, up_message, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)up_message {
    return objc_getAssociatedObject(self, &messageKey);
}
- (void)setWg_alert:(UIAlertController *)wg_alert {
    objc_setAssociatedObject(self, &alertKey, wg_alert, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIAlertController *)wg_alert {
    return objc_getAssociatedObject(self, &alertKey);
}
- (void)wg_checkVersion {
    
    WG_UserDefaults *user = [WG_UserDefaults shareInstance];
    if (user.helpUrl == nil) {
        user.helpUrl = @"http://m.vvgong.com/client/p_help.html";
    }
    if (user.protocolUrl == nil) {
        user.protocolUrl = @"http://m.vvgong.com/client/protocol.html";
    }
    
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:@"/linggb-ws/ws/0.1/clientVersion/versionForIOS"];
    request.wg_parameters = @{@"flag":@1};
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        if (response.responseJSON) {
            
            WG_CheckVersion *version = [WG_CheckVersion mj_objectWithKeyValues:response.responseJSON];
            user.helpUrl = version.help;
            user.protocolUrl = version.protocol;
            NSInteger updateType = 0;
            if ([kAppVersion wg_isNewerVersionThan:version.lowestVersion]) {
                if ([kAppVersion wg_isOlderVersionThan:version.version]) {
                    updateType = 1;
                }
            } else if ([kAppVersion wg_isOlderVersionThan:version.lowestVersion]) {
                updateType = 2;
            }
            WG_UpdateItem *item = [WG_UpdateItem new];
            item.updateType = updateType;
            
            self.wg_updateItem = item;
            self.up_message = version.content;
            //            self.wg_updateItem.updateType = 2;
            if (item.updateType != 0) {
                [self wg_showAlert];
            }
        }
    }];
    
}
- (void)wg_showAlert {
    NSString *title = @"升级提示";
    NSString *message = self.up_message;
    NSString *cancel = @"取消";
    NSString *sure = @"更新";
    
    if (self.wg_updateItem.updateType == 2) {
        cancel = nil;
    }
    self.wg_alert = [UIAlertController wg_alertWithTitle:title message:message completion:^(UIAlertController *alert, NSInteger buttonIndex) {
        if (buttonIndex) {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:kAppStoreUrl]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kAppStoreUrl]];
            }
        }
    } cancel:cancel sure:sure];
}

#pragma mark - UIApplicationDelegate
- (void)applicationDidEnterBackground:(UIApplication *)application {
    if (self.wg_alert) {
        [self.wg_alert dismissViewControllerAnimated:NO completion:nil];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    if (self.wg_updateItem.updateType == 2) {
        [self wg_showAlert];
    }
}

@end

@implementation AppDelegate (GetBaseData)

- (void)wg_updateLocalData {
    NSString *url = @"/linggb-ws/ws/0.1/common/locationAndDataCode";
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:url];
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        if (response.statusCode == 200) {
            NSArray *location = response.responseJSON[@"location"];
            [WGDataBaseTool putObject:location withId:kCityListKey];
            
            NSArray *dataCode = response.responseJSON[@"dataCode"];
            [WGDataBaseTool putObject:dataCode withId:kDataCodeKey];
            
        }
    }];
    
}
@end

@implementation WG_UpdateItem

+ (instancetype)wg_checkNewVersion:(NSString *)newVersion localVersion:(NSString *)localVersion lowVersion:(NSString *)lowVersion {
    NSArray *newList = [newVersion componentsSeparatedByString:@"."];
    NSArray *localList = [localVersion componentsSeparatedByString:@"."];
    NSArray *lowList = [lowVersion componentsSeparatedByString:@"."];
    
    NSUInteger maxCount = MAX(MAX(newList.count, localList.count), lowList.count);
    NSMutableString *muNewVersion = [@"" mutableCopy];
    NSMutableString *muLocalVersion = [@"" mutableCopy];
    NSMutableString *muLowVersion = [@"" mutableCopy];
    for (NSUInteger i = 0; i < maxCount; i++) {
        
        if (i < newList.count) {
            [muNewVersion appendFormat:@"%@.",newList[i]];
        } else {
            [muNewVersion appendFormat:@"0."];
        }
        
        if (i < localList.count) {
            [muLocalVersion appendFormat:@"%@.",localList[i]];
        } else {
            [muLocalVersion appendFormat:@"0."];
        }
        
        if (i < lowList.count) {
            [muLowVersion appendFormat:@"%@.",lowList[i]];
        } else {
            [muLowVersion appendFormat:@"0."];
        }
    }
    
    NSUInteger type = 0;
    if ([muNewVersion compare:muLocalVersion] == NSOrderedDescending) {
        type = 1;
        if ([muLocalVersion compare:muLowVersion] == NSOrderedAscending) {
            type = 2;
        }
    }
    
    WG_UpdateItem *item = [WG_UpdateItem new];
    item.updateType = type;
    return item;
}

@end
