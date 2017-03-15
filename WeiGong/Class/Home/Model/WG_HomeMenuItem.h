//
//  WG_HomeMenuItem.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/26.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WG_HomeMenuItem : NSObject

@property (nonatomic, assign) NSUInteger code;

@property (nonatomic, copy) NSString *title;


@property (nonatomic, strong) WG_HomeMenuItem *selectItem;

@property (nonatomic, copy) NSArray <WG_HomeMenuItem *>* menuItemList;

@end
