//
//  WGUserDeedbackContactCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/1.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WG_BaseTableViewCell.h"
@class WGUserDeedbackContactItem;
@interface WGUserDeedbackContactCell : WG_BaseTableViewCell
@property (nonatomic, strong) WGUserDeedbackContactItem *item;
@end

@interface WGUserDeedbackContactItem : NSObject
@property (nonatomic, copy) NSString *name_left;

@property (nonatomic, copy) NSString *name_content;

@property (nonatomic, copy) NSString *placeholer;

@property (nonatomic, assign) NSInteger index;
@end
