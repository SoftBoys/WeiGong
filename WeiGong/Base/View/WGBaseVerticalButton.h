//
//  WGBaseVerticalButton.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/15.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WGBaseButton.h"

@interface WGBaseVerticalButton : UIButton
/** 图标与文字之间的纵向间距 */
@property (nonatomic, assign) float spaceY;

@property (nonatomic, assign) DMBaseButtonType type;
@property (nonatomic, strong) UIFont *font;
@end
