//
//  WGChangeConfirmPassView.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/23.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WGChangeConfirmPassHandle)(NSString *pass1, NSString *pass2);

@interface WGChangeConfirmPassView : UIView
@property (nonatomic, copy) WGChangeConfirmPassHandle handle;
@end
