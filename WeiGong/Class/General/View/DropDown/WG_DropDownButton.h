//
//  WG_DropDownButton.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/25.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WG_DropDownButton : UIButton
/** 位于第几列 */
@property (nonatomic, assign) NSInteger column;
/** 是否处于伸展状态 */
@property (nonatomic, assign) BOOL isStretch;

@property (nonatomic, strong, readonly) UIView *line;
@end
