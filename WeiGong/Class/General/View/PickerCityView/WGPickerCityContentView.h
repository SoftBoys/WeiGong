//
//  WGPickerCityContentView.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/10.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WGPickerCityItem;
@interface WGPickerCityContentView : UIView
@property (nonatomic, copy) NSArray <WGPickerCityItem*>*cityItems;
@property (nonatomic, strong) WGPickerCityItem *currentCityItem;

@property (nonatomic, copy) void (^sureHandle)(WGPickerCityItem *currentCityItem);
@end
