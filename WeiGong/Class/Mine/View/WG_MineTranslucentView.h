//
//  WG_MineTranslucentView.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/18.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WG_MineUser;
@interface WG_MineTranslucentView : UIView


@property (nonatomic, strong, readonly) UIButton *collectButton;
@property (nonatomic, strong, readonly) UIButton *creditButton;
@property (nonatomic, strong, readonly) UIButton *rejectButton;

@property (nonatomic, strong) WG_MineUser *user;
@end
