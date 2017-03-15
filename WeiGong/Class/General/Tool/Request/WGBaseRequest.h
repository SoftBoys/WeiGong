//
//  WGBaseRequest.h
//  WGPublicClassDemo
//
//  Created by dfhb@rdd on 16/12/2.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WGBaseResponse.h"

@protocol WGBaseRequestResponseDelegate <NSObject>

@optional
- (void)wg_requestCompletionWithResponse:(WGBaseResponse *)response;

@end

typedef void(^WGBaseResponseCompletion)(WGBaseResponse *response);
@interface WGBaseRequest : NSObject
/** 请求Url */
@property (nonatomic, copy) NSString *wg_url;
/** 请求参数 */
@property (nonatomic, copy) NSDictionary *wg_parameters;
/** 是否为POST请求 (默认为GET) */
@property (nonatomic, assign) BOOL wg_isPost;

@property (nonatomic, weak) id<WGBaseRequestResponseDelegate> wg_delegate;
/** 上传图片的Image集合 */
@property (nonatomic, copy) NSArray<UIImage *> *wg_imageArray;
/** 默认为GET请求 */
+ (instancetype)wg_request;
/** 创建网络请求 */
+ (instancetype)wg_requestWithUrl:(NSString *)wg_url;
+ (instancetype)wg_requestWithUrl:(NSString *)wg_url isPost:(BOOL)wg_isPost;
+ (instancetype)wg_requestWithUrl:(NSString *)wg_url isPost:(BOOL)wg_isPost delegate:(id<WGBaseRequestResponseDelegate>)wg_delegate;
/** 发起请求 */
- (void)wg_sendRequest;
/** 发起请求 回调 */
- (void)wg_sendRequestWithCompletion:(WGBaseResponseCompletion)completion;
@end

@interface WGBaseRequest (PublicParam)
/** 添加公共请求参数 */
- (NSDictionary *)wg_publicParameter;
@end
