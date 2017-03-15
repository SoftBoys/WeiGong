//
//  WGPickerCityView.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/10.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>


@class WGPickerCityItem;
typedef void(^WGPickerCityHandle)(WGPickerCityItem *item);
@interface WGPickerCityView : UIView

+ (instancetype)pickerWithCityItems:(NSArray <WGPickerCityItem*>*)items currentCityItem:(WGPickerCityItem *)currentCityItem completionHandle:(WGPickerCityHandle)handle;

@end

@interface WGPickerCityItem : NSObject

@property (nonatomic, assign) NSUInteger cityCode;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, assign) NSInteger index_sel;

@property (nonatomic, copy) NSArray <WGPickerCityItem *> *subItems;


@end
