//
//  NSObject+Addition.m
//  WGKitDemo
//
//  Created by dfhb@rdd on 16/11/28.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "NSObject+Addition.h"

#import <MJExtension.h>

@implementation NSObject (Addition)

@end

@implementation NSObject (AppInfo)

- (NSString *)wg_appVersion {
    return [self wg_info][@"CFBundleShortVersionString"];
}
- (NSInteger)wg_appBuild {
    return [[self wg_info][@"CFBundleVersion"] integerValue];
}
- (NSString *)wg_appIdentifier {
    return [self wg_info][@"CFBundleIdentifier"];
}
#pragma mark - private
- (NSDictionary *)wg_info {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return infoDictionary;
}

@end

@implementation NSObject (UIKit)
- (UIViewController *)wg_topViewController {
    return [NSObject wg_topViewController];
}
+ (UIViewController *)wg_topViewController {
    UIViewController *topViewController = nil;
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    topViewController = rootViewController;
    // rootViewController == tabbar
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UIViewController *selectedVC = [(UITabBarController *)rootViewController selectedViewController];
        if ([selectedVC isKindOfClass:[UINavigationController class]]) {
            topViewController = [(UINavigationController *)selectedVC topViewController];
        } else {
            topViewController = selectedVC;
        }
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        topViewController = [(UINavigationController *)rootViewController topViewController];
    }
    
    return topViewController;
}
- (UIViewController *)controllerWithClassString:(NSString *)name {
    return UIViewControllerWithClassString(name);
}
static UIViewController * UIViewControllerWithClassString(id name) {
    if (name == nil) {
        return nil;
    }
    Class class = NSClassFromString(name);
    UIViewController *vc = [class new];
    if (![vc isKindOfClass:[UIViewController class]]) {
        return nil;
    } else {
        return vc;
    }
}

@end

@implementation NSObject (JSON)

#pragma mark - MJExtension

+ (void)wg_setupModelReplacedKeyWithDict:(NSDictionary *)dict {
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
        [self mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return dict;
        }];
    }
}

+ (void)wg_setupModelClassInArray:(NSDictionary *)dict {
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
        [self mj_setupObjectClassInArray:^NSDictionary *{
            return dict;
        }];
    }
}
// mj_replacedKeyFromPropertyName
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    if ([self respondsToSelector:@selector(wg_dictWithModelReplacedKey)]) {
        return [self wg_dictWithModelReplacedKey];
    }
    return nil;
}
+ (NSDictionary *)mj_objectClassInArray {
    if ([self respondsToSelector:@selector(wg_dictWithModelClassInArray)]) {
        return [self wg_dictWithModelClassInArray];
    }
    return nil;
}
+ (instancetype)wg_modelWithDictionry:(NSDictionary *)dict {
    if (dict == nil || ![dict isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    return [self mj_objectWithKeyValues:dict];
}
+ (NSArray *)wg_modelArrayWithDictArray:(NSArray *)dictArray {
    if (dictArray && [dictArray isKindOfClass:[NSArray class]]) {
        NSMutableArray *modelArray = [self mj_objectArrayWithKeyValuesArray:dictArray];
        return [modelArray copy];
    }
    return nil;
}

+ (NSArray *)wg_dictArrayWithModelArray:(NSArray *)modelArray {
    if (modelArray && [modelArray isKindOfClass:[NSArray class]]) {
        NSMutableArray *dictArray = [self mj_keyValuesArrayWithObjectArray:modelArray];
        return [dictArray copy];
    }
    return nil;
}
- (NSDictionary *)wg_keyValues {
    return [[self mj_keyValues] copy];
}
- (id)wg_JSONObject {
    return [self mj_JSONObject];
}
- (NSString *)wg_JSONString {
    return [self mj_JSONString];
}



@end
