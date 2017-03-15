//
//  WGMessageGroupCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/26.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WG_BaseTableViewCell.h"

@class WGMessageGroupItem;
@interface WGMessageGroupCell : WG_BaseTableViewCell
@property (nonatomic, strong) WGMessageGroupItem *item;
@end


@interface WGMessageGroupItem : NSObject
/** 标记 1:单聊  2:群聊 */
@property (nonatomic, assign) NSInteger flag;
/** 群组ID */
@property (nonatomic, copy) NSString *groupid;
/** 群组名称 */
@property (nonatomic, copy) NSString *groupname;

@property (nonatomic, copy) NSString *enterpriseName;

@property (nonatomic, copy) NSString *jobName;

@end
