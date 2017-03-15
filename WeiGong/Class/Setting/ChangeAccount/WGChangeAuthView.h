//
//  WGChangeAuthView.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/21.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WGChangeAuthButtonHandle)(NSString *password);

@interface WGChangeAuthView : UIView
@property (nonatomic, strong, readonly) UITextField *field_pass;
@property (nonatomic, copy) WGChangeAuthButtonHandle authHandle;
@end
