//
//  WG_SinaTool.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/17.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WeiboSDK/WeiboSDK.h>

@interface WG_SinaTool : NSObject <WeiboSDKDelegate>

+ (instancetype)shareInstance;

@property (nonatomic, copy) NSString *access_token;

@property (nonatomic, copy) NSString *userID;

/**
 *  发起分享请求
 *
 *  @param content   分享内容
 *  @param imageData 分享图片
 */
- (void)shareContent:(NSString *)content imageData:(NSData *)imageData;

@end
