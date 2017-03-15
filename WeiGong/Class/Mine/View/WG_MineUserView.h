//
//  WG_MineUserView.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/18.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WG_MineUser;
@interface WG_MineUserView : UIView
@property (nonatomic, strong, readonly) UIButton *settingBtn;
@property (nonatomic, strong, readonly) UIImageView *iconView;
@property (nonatomic, strong) WG_MineUser *user;
@end
