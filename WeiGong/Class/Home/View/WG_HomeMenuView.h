//
//  WG_HomeMenuView.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/25.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WG_HomeMenuViewDelegate <NSObject>

- (void)wg_updateData;

@end

@class WG_HomeMenuItem;
@interface WG_HomeMenuView : UIView

+ (CGFloat)menuHeight;

@property (nonatomic, copy) NSArray <WG_HomeMenuItem *>* items;

@property (nonatomic, weak) id<WG_HomeMenuViewDelegate> delegate;

//- (void)reloadData;

- (void)wg_tapBackView;
@end
