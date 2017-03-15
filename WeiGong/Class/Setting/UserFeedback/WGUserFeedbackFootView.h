//
//  WGUserFeedbackFootView.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/1.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGUserFeedbackFootView : UIView
@property (nonatomic, copy) void (^submitHandle)();
@end
