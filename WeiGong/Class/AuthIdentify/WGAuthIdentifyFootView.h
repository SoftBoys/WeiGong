//
//  WGAuthIdentifyFootView.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/19.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WGAuthIdentify;
@interface WGAuthIdentifyFootView : UIView
@property (nonatomic, strong) WGAuthIdentify *identify;
@property (nonatomic, copy) void (^tapHandle)();
@end
