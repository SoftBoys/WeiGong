//
//  WG_SearchHisttoryTool.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/28.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WG_SearchHistoryItem;
@interface WG_SearchHistoryTool : NSObject
+ (NSArray<WG_SearchHistoryItem *> *)wg_historyItems;

+ (void)wg_saveHistoryItem:(WG_SearchHistoryItem *)item;

+ (void)wg_clearHistory;
@end

@interface WG_SearchHistoryItem : NSObject

@property (nonatomic, assign) NSTimeInterval timeStamp;

@property (nonatomic, copy) NSString *key;

@property (nonatomic, copy) NSString *name;
@end