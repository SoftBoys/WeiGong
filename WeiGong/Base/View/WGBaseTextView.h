//
//  WGBaseTextView.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/1.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGBaseTextView : UITextView
/** 提示文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 提示文字的颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
@end
