//
//  WGChangeNewView.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/21.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WGChangeAccountHandle)(NSString *phone, NSString *authCode, NSString *newPassword);

@interface WGChangeNewView : UIView
@property (nonatomic, copy) WGChangeAccountHandle accountHandle;
@end
