//
//  WGNearHeadView.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/7.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGNearHeadView : UIView

@property (nonatomic, copy) void (^searchHandle)(NSString *keywords);
@property (nonatomic, copy) void (^locationHandle)();

@property (nonatomic, copy) NSString *address;

@end
