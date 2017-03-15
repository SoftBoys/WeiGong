//
//  WGStepScrollView.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/21.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGStepScrollView : UIScrollView

@property (nonatomic, copy) NSArray <UIView *>*contentViews;

- (void)stepToPage:(NSInteger)page;
- (void)stepToPage:(NSInteger)page animated:(BOOL)animated;
- (void)stepToPage:(NSInteger)page animated:(BOOL)animated completion:(void(^)())completion;
@end
