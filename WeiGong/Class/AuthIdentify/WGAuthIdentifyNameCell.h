//
//  WGAuthIdentifyNameCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/19.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WG_BaseTableViewCell.h"

@class WGAuthIdentifyNameItem;
@interface WGAuthIdentifyNameCell : WG_BaseTableViewCell
@property (nonatomic, strong) WGAuthIdentifyNameItem *item;
@end

@interface WGAuthIdentifyNameItem : NSObject
@property (nonatomic, copy) NSString *text_left;
@property (nonatomic, copy) NSString *text_right;
@property (nonatomic, assign) BOOL canInput;

@property (nonatomic, assign) NSInteger index;
@end
