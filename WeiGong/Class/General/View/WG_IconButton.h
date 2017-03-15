//
//  WG_IconButton.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/8.
//  Copyright © 2016年 guojunwei. All rights reserved.
//  图片与文本左右布局 Horizontal

#import <UIKit/UIKit.h>

@interface WG_IconButton : UIButton
/** 图标与文本之间间距(默认0) */
@property (nonatomic, assign) CGFloat space;
/** 0(图标在左) 1(图标在右) */
@property (nonatomic, assign) NSInteger type;
@end
