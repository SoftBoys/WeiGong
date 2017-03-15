//
//  WGCheckBoxView.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/10.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WGCheckBoxItem;
typedef void(^WGCheckBoxHandle)(NSArray<WGCheckBoxItem*> *boxItems);

@interface WGCheckBoxView : UIView

+ (instancetype)boxViewWithTitle:(NSString *)title boxItems:(NSArray <WGCheckBoxItem*>*)boxItems completionHandle:(WGCheckBoxHandle)handle;

@end

@interface WGCheckBoxItem : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) NSInteger code;
@end
