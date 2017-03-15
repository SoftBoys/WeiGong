//
//  UIAlertController+Addition.m
//  WGKitDemo
//
//  Created by dfhb@rdd on 16/11/28.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "UIAlertController+Addition.h"
#import "NSObject+Addition.h"

@implementation UIAlertController (Addition)
+ (instancetype)wg_alertWithTitle:(NSString *)title message:(NSString *)message completion:(void (^)(UIAlertController *, NSInteger))completion cancel:(NSString *)cancel sure:(NSString *)sure {
    return [self private_alertWithTitle:title message:message style:UIAlertControllerStyleAlert completion:completion cancel:cancel others:sure];
}
+ (instancetype)wg_actionSheetWithTitle:(NSString *)title message:(NSString *)message completion:(void (^)(UIAlertController *, NSInteger))completion cancel:(NSString *)cancel others:(NSArray<NSString *> *)others {
    return [self private_alertWithTitle:title message:message style:UIAlertControllerStyleActionSheet completion:completion cancel:cancel others:others];
}

#pragma mark - private
+ (instancetype)private_alertWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style completion:(void (^)(UIAlertController *, NSInteger))completion cancel:(NSString *)cancel others:(id)others {
    if (cancel == nil && others == nil) return nil;
    UIAlertController *alert = [[self class] alertControllerWithTitle:title message:message preferredStyle:style];
    __weak typeof(alert) weakself = alert;
    if (cancel && cancel.length) {
        // UIAlertControllerStyleAlert
        UIAlertActionStyle cancelStyle = (style == UIAlertControllerStyleActionSheet) ? UIAlertActionStyleCancel:UIAlertActionStyleDefault;
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancel style:cancelStyle handler:^(UIAlertAction * _Nonnull action) {
            if (completion) {
                completion(weakself, 0);
            }
        }];
        [alert addAction:cancelAction];
    }
    
    if (others) {
        if ([others isKindOfClass:[NSString class]] && [others length]) {
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:others style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (completion) {
                    completion(weakself, 1);
                }
            }];
            [alert addAction:sureAction];
        }
        if ([others isKindOfClass:[NSArray class]] && [others count]) {
            [others enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[NSString class]] && [obj length]) {
                    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        if (completion) {
                            completion(weakself, idx+1);
                        }
                    }];
                    [alert addAction:sureAction];
                }
            }];
        }
    }
    [[alert wg_topViewController] presentViewController:alert animated:YES completion:nil];
    return alert;
}

@end
