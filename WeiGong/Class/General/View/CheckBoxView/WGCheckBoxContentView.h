//
//  WGCheckBoxContentView.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/10.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>


@class WGCheckBoxItem;
@interface WGCheckBoxContentView : UIView
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray <WGCheckBoxItem*>*boxItems;

@property (nonatomic, copy) void (^sureHandle)(NSArray <WGCheckBoxItem*>*boxItems);

@end
