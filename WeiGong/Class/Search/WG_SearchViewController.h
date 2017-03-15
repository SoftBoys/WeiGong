//
//  WG_SearchViewController.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/28.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_BaseTableViewController.h"

@class WG_HomeMenuView;
@interface WG_SearchViewController : WG_BaseTableViewController
@property (nonatomic, strong) WG_HomeMenuView *menuView;
/** 搜索关键词 */
@property (nonatomic, copy) NSString *keyWords;
@end
