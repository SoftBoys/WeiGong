//
//  WGChangePassAuthView.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/23.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WGChangeAuthView.h"

@interface WGChangePassAuthView : UIView
@property (nonatomic, strong, readonly) UITextField *field_pass;
@property (nonatomic, copy) WGChangeAuthButtonHandle authHandle;
@end
