//
//  WG_ChooseCityViewController.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/13.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_BaseTableViewController.h"

@class WG_CityItem;
@protocol WG_ChooseCityViewControllerDelegate <NSObject>

- (void)chooseCityItem:(WG_CityItem *)item;

@end

@interface WG_ChooseCityViewController : WG_BaseTableViewController
@property (nonatomic, weak) id<WG_ChooseCityViewControllerDelegate> delegate;

@property (nonatomic, strong) WG_CityItem *currentItem;
@end
