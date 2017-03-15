//
//  WG_HomeBanner.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/17.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WG_HomeClassItem, WG_HomeBannerItem;
@protocol WG_HomeBannerDelegate <NSObject>

@optional

- (void)tapScrollImageWithItem:(WG_HomeBannerItem *)item;
- (void)tapClassButtonWithItem:(WG_HomeClassItem *)item;

@end


@interface WG_HomeBanner : UIView

+ (CGFloat)bannerHeight;
+ (CGFloat)classHeight;

@property (nonatomic, weak) id<WG_HomeBannerDelegate> delegate;

- (void)setupBannerItems:(NSArray <WG_HomeBannerItem *>*)bannerItems;

- (void)setupClassItems:(NSArray <WG_HomeClassItem *>*)classItems;
@end

@interface WG_HomeClassButton : UIView

@property (nonatomic, strong) WG_HomeClassItem *item;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, copy) void(^tapHandle)(WG_HomeClassItem *item);

@end
