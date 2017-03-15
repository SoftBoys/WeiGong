//
//  WG_MineCellItem.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/21.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WG_MineCellItem : NSObject
/** 0:无箭头,不可点,右侧无文字  1:有箭头,可点,右侧无文字  2:有箭头,可点,右侧有文字 */
@property (nonatomic, assign) NSUInteger cellType;

@property (nonatomic, strong) UIImage *icon;

@property (nonatomic, copy) NSString *name_left;

@property (nonatomic, copy) NSString *name_right;
/** 0:账户 1:灵活就业 2:身份认证 3:基本信息 4:签到签退 5:我的工作 6:费用确认 */
@property (nonatomic, assign) NSInteger type;
@end
