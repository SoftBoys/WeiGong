//
//  WG_MywalletHeadView.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/4.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WG_MywalletAccount;
@protocol WG_MywalletHeadViewDelegate <NSObject>

- (void)wg_tapDetail;
- (void)wg_tapCash;

@end
@interface WG_MywalletHeadView : UIView
@property (nonatomic, strong) WG_MywalletAccount *account;
@property (nonatomic, weak) id<WG_MywalletHeadViewDelegate> delegate;
@end
