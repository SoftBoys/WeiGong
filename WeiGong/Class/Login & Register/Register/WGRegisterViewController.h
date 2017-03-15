//
//  WGRegisterViewController.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/23.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WG_BaseViewController.h"

typedef void(^WGRegisterSuccessHandle)(NSString *phone, NSString *pass);

@interface WGRegisterViewController : WG_BaseViewController
@property (nonatomic, copy) WGRegisterSuccessHandle successHandle;
@end
