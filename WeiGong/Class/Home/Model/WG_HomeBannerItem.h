//
//  WG_HomeBannerItem.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/25.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WG_HomeBannerItem : NSObject
/** 图片url */
@property (nonatomic, copy) NSString *imgUrl;
/** 链接 */
@property (nonatomic, copy) NSString *linkUrl;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 0:无动作，1:打开linkUrl，2:进入职位详情(linkurl为职位id) */
@property (nonatomic, assign) NSUInteger actFlag;
/** 是否是默认图片 0否 1是 */
@property (nonatomic, assign) NSUInteger defaultFlag;

@end
