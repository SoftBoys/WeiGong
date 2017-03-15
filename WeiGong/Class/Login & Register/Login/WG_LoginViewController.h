//
//  WG_LoginViewController.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/19.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_BaseViewController.h"

@interface WG_LoginViewController : WG_BaseViewController

@property (nonatomic, copy) void (^loginSuccessHandle)(WGBaseResponse *response);

@end
