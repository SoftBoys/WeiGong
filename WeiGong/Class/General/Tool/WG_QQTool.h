//
//  WG_QQTool.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/13.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>

@interface WG_QQTool : NSObject <TencentSessionDelegate>

/** 检测是否安装了微信 */
+ (BOOL)isInstalledQQ;

+ (instancetype)shareInstance;

@property (nonatomic, strong) TencentOAuth *tencentOAuth;

/**
 *  分享到QQ好友
 *
 *  @param title   标题
 *  @param content 文本
 *  @param icon    图标
 *  @param link    链接
 */
- (void)shareToSessionWithTitle:(NSString *)title content:(NSString *)content icon:(UIImage *)icon link:(NSString *)link;
/**
 *  分享到QQ空间
 *
 *  @param title   标题
 *  @param content 文本
 *  @param icon    图标
 *  @param link    链接
 */
- (void)shareToQzoneWithTitle:(NSString *)title content:(NSString *)content iconUrl:(NSString *)iconUrl link:(NSString *)link;

@end
