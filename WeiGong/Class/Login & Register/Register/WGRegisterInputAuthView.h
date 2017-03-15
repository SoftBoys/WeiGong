//
//  WGRegisterInputAuthView.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/23.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WGRegisterInputAuthViewAuthHandle)(NSString *phone, NSString *code);
typedef void(^WGRegisterInputAuthViewGetCodeHandle)(NSString *phone);

@interface WGRegisterInputAuthView : UIView

@property (nonatomic, copy) NSString *phone;
/** 开始倒计时 */
- (void)startTiming;

@property (nonatomic, copy) WGRegisterInputAuthViewAuthHandle authHandle;
@property (nonatomic, copy) WGRegisterInputAuthViewGetCodeHandle getCodeHandle;

@end
