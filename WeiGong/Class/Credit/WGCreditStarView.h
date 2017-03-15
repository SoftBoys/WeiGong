//
//  WGCreditStarView.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/25.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGCreditStarView : UIView

@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, copy) NSString *title;
/** 0-5 */
@property (nonatomic, assign) NSInteger star;

@end
