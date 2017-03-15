//
//  WGRegisterInputPerfectView.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/1.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WGPickerCityItem, WGDataTypeItem;
@interface WGRegisterInputPerfectView : UIView

@property (nonatomic, copy) void (^cityHandle)(WGPickerCityItem *cityItem);

@property (nonatomic, copy) void (^typeHandle)(NSArray <WGDataTypeItem*> *typeItemList);

@property (nonatomic, copy) void (^submitHandle)(NSString *pass, NSString *name, WGPickerCityItem *cityItem, NSArray <WGDataTypeItem*> *typeItemList, NSString *address);

@property (nonatomic, strong) WGPickerCityItem *cityItem;
@property (nonatomic, copy) NSArray <WGDataTypeItem*> *typeItemList;

@end
