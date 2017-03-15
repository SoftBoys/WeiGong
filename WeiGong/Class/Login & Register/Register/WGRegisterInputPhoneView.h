//
//  WGRegisterInputPhoneView.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/23.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WGRegisterPhoneCallBack)(NSString *phone);
@interface WGRegisterInputPhoneView : UIView
@property (nonatomic, copy) WGRegisterPhoneCallBack getCodeHandle;
@property (nonatomic, copy) void (^protocolHandle)();

@property (nonatomic, assign) BOOL isRegister;
@end
