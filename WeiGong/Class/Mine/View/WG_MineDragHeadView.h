//
//  WG_MineDragHeadView.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/18.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WG_DragView, WG_MineUser;
@protocol WG_MineDragHeadViewDelegate <NSObject>
/** 点击登录 */
- (void)tapLoginInDragView;
/** 点击设置 */
- (void)tapSettingInDragView;
/** 点击头像 */
- (void)tapIconInDragView;
/** 点击收藏 */
- (void)tapCollectionInDragView;
/** 点击信誉 */
- (void)tapCreditInDragView;
/** 点击放鸽子 */
- (void)tapRejectInDragView;

@end

@interface WG_MineDragHeadView : UIView
@property (nonatomic, weak) id<WG_MineDragHeadViewDelegate> delegate;

@property (nonatomic, strong, readonly) WG_DragView *backView;

@property (nonatomic, strong) WG_MineUser *user;

@end
