//
//  WG_JobDetailShare.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/7.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WG_JobDetailShare : NSObject
/** 微信标题 */
@property (nonatomic, copy) NSString *title;
/** 微信文本 */
@property (nonatomic, copy) NSString *content;
/** 微信link */
@property (nonatomic, copy) NSString *linkUrl;
/** 图标Url */
@property (nonatomic, copy) NSString *picUrl;

/** 新浪文本(title content link) */
@property (nonatomic, copy) NSString *content_sina;

/** 微信图标 */
@property (nonatomic, strong) UIImage *icon;
/** 新浪图片 */
@property (nonatomic, strong) NSData *imageData;

@end
