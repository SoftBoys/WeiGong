//
//  WGUserFeedbackTextViewCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/1.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WG_BaseTableViewCell.h"

@class WGUserDeedbackContactItem;
@interface WGUserFeedbackTextViewCell : WG_BaseTableViewCell
@property (nonatomic, strong) WGUserDeedbackContactItem *item;
@end
