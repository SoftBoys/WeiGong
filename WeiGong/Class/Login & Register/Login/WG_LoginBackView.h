//
//  WG_LoginBackView.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/20.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WG_LoginBackViewDelegate <NSObject>

- (void)wg_loginWithPhone:(NSString *)phone pass:(NSString *)pass;

- (void)wg_delegateRegister;

- (void)wg_delegateForget;

@end

@interface WG_LoginBackView : UIImageView
@property (nonatomic, strong, readonly) UITextField *phoneField;
@property (nonatomic, strong, readonly) UITextField *passField;
/** 正在登陆 */
@property (nonatomic, assign) BOOL isLoging;

@property (nonatomic, weak) id<WG_LoginBackViewDelegate> wg_delegate;
@end
