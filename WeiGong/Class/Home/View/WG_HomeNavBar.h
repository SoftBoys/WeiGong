//
//  WG_HomeNavBar.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/14.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WG_HomeNavBarDelegate <NSObject>

@required
- (void)didClickCityButton;
- (void)didClickSearchButton;
@end

typedef NS_ENUM(NSUInteger, WGHomeCityType) {
    WGHomeCityTypeWhite,
    WGHomeCityTypeLightGray,
};

@interface WG_HomeNavBar : UIView

@property (nonatomic, assign) WGHomeCityType type;
/** 城市名称 */
@property (nonatomic, copy) NSString *city;
@property (nonatomic, weak) id<WG_HomeNavBarDelegate> delegate;

@end
