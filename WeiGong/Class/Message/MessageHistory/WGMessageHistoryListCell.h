//
//  WGMessageHistoryListCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/27.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WG_BaseTableViewCell.h"

@class WGMessageHistoryListItem;
@interface WGMessageHistoryListCell : WG_BaseTableViewCell
@property (nonatomic, strong) WGMessageHistoryListItem *item;
@end


@interface WGMessageHistoryListItem : NSObject

/** 头像的Url */
@property (nonatomic,copy) NSString *icanUrl;
/** 标题 */
@property (nonatomic,copy) NSString *name;
/** 副标题 */
@property (nonatomic,copy) NSString *detail;
/** 时间 */
@property (nonatomic,copy) NSString *time;
/** 未读数 */
@property (nonatomic,assign) NSInteger unreadCount;
/** 群组ID */
@property (nonatomic,copy) NSString *groupID;
/** 是否是群组 */
@property (nonatomic,assign) BOOL isGroup;

@end
