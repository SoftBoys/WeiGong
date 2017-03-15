//
//  MBProgressHUD+WG_Extension.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/20.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "MBProgressHUD+WG_Extension.h"

@implementation MBProgressHUD (WG_Extension)

+ (MBProgressHUD *)wg_message:(NSString *)message {
    [self wg_hideHub];
    if (message == nil)  return nil;
    return [self wg_message:message toView:nil];
}

+ (MBProgressHUD *)wg_message:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    NSString *text = [NSString stringWithFormat:@"%@",message];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
//    hud.label.textColor = [UIColor whiteColor];
    // 1.0.0
//    hud.label.text = text;
    hud.labelText = text;
    
    // 设置背景框颜色
//    hud.bezelView.backgroundColor = [UIColor redColor];

    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
//    hud.dimBackground = NO;
    

    hud.mode = MBProgressHUDModeText;
    // 边缘
    hud.margin = 15.f;
    
    // 设置距离中心点的Y方向上的偏移量
    //    hud.yOffset = IS_IPHONE_5?200.f:150.f;
    hud.userInteractionEnabled = NO;
    
//    [hud hideAnimated:YES afterDelay:0.8];
    [hud hide:YES afterDelay:0.8];
    
    return hud;
}

+ (MBProgressHUD *)wg_showHub_CanTap {
    return [self wg_showHubWithCanTap:YES];
}
+ (MBProgressHUD *)wg_showHub_CannotTap {
    return [self wg_showHubWithCanTap:NO];
}
+ (MBProgressHUD *)wg_showHubWithCanTap:(BOOL)canTap {
    [self wg_hideHub];
    UIView *view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hub.userInteractionEnabled = !canTap;
    return hub;
}
+ (void)wg_hideHub {
    UIView *view = [UIApplication sharedApplication].keyWindow;
    [MBProgressHUD hideHUDForView:view animated:YES];
}
@end
