//
//  MBProgressHUD+WG_Extension.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/20.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (WG_Extension)

+ (MBProgressHUD *)wg_message:(NSString *)message;
/** 可以点击 */
+ (MBProgressHUD *)wg_showHub_CanTap;
/** 不可以点击 */
+ (MBProgressHUD *)wg_showHub_CannotTap;

+ (void)wg_hideHub;
@end
