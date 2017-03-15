//
//  GJWNetwork.h
//  GJWNetworkDemo
//
//  Created by dfhb@rdd on 16/7/21.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GJWResponseType) {
    kGJWResponseTypeJSON = 1, // 默认
    kGJWResponseTypeXML  = 2, // XML
    // 特殊情况下，一转换服务器就无法识别的，默认会尝试转换成JSON，若失败则需要自己去转换
    kGJWResponseTypeData = 3
};

typedef NS_ENUM(NSUInteger, GJWRequestType) {
    kGJWRequestTypeJSON = 1, // 默认
    kGJWRequestTypePlainText = 2 // 普通text/html
};

typedef NSURLSessionTask GJWURLSessionTask;
typedef void(^GJWResponseSuccess)(GJWURLSessionTask *task, id response);
typedef void(^GJWResponseFail)(GJWURLSessionTask *task, NSError *error);

@class GJWFormData;
@interface GJWNetwork : NSObject
/**
 *  设置请求接口的BaseUrl
 *
 *  @param baseUrl 网络接口的基础url
 */
+ (void)updateBaseUrl:(NSString *)baseUrl;
+ (NSString *)baseUrl;
/**
 *  配置请求头
 *
 *  @param httpHeads 请求头信息，只需在appDelegate中设置一次即可
 */
+ (void)configHttpHeaders:(NSDictionary *)httpHeads;
/**
 *  配置请求类型
 *
 *  @param requestType  请求类型
 *  @param responseType 响应类型
 */
+ (void)configRequestType:(GJWRequestType)requestType
             responseType:(GJWResponseType)responseType;
/**
 *  设置请求超时时间，默认30秒
 *
 *  @param timeout 超时时间
 */
+ (void)setTimeout:(NSTimeInterval)timeout;
/**
 *  取消所有请求
 */
+ (void)cancelAllRequest;
/**
 *  取消task请求
 */
+ (void)cancelTask:(GJWURLSessionTask *)task;
/**
 *  根据url取消请求
 */
+ (void)cancelTaskWithUrl:(NSString *)url;
/**
 *  发送get请求
 *
 *  @param url     请求url
 *  @param success 成功回调
 *  @param fail    失败回调
 *
 *  @return 返回当前sessiontask
 */
+ (GJWURLSessionTask *)getWithUrl:(NSString *)url
                          success:(GJWResponseSuccess)success
                             fail:(GJWResponseFail)fail;
/**
 *  发送get请求
 *
 *  @param url     请求url
 *  @param param   请求参数
 *  @param success 成功回调
 *  @param fail    失败回调
 *
 *  @return 返回当前sessiontask
 */
+ (GJWURLSessionTask *)getWithUrl:(NSString *)url
                            param:(NSDictionary *)param
                          success:(GJWResponseSuccess)success
                             fail:(GJWResponseFail)fail;
/**
 *  发送post请求
 *
 *  @param url     请求url
 *  @param param   请求参数
 *  @param success 成功回调
 *  @param fail    失败回调
 *
 *  @return 返回当前sessiontask
 */
+ (GJWURLSessionTask *)postWithUrl:(NSString *)url
                            param:(NSDictionary *)param
                          success:(GJWResponseSuccess)success
                             fail:(GJWResponseFail)fail;
/**
 *  上传图片
 *
 *  @param url      url
 *  @param param    参数
 *  @param formData 图片参数
 *  @param success  成功回调
 *  @param fail     失败回调
 *
 *  @return 返回当前sessiontask
 */
+ (GJWURLSessionTask *)postImageWithUrl:(NSString *)url
                                  param:(NSDictionary *)param
                               formData:(GJWFormData *)formData
                                success:(GJWResponseSuccess)success
                                   fail:(GJWResponseFail)fail;
/**
 *  上传多张图片
 */
+ (GJWURLSessionTask *)postImageWithUrl:(NSString *)url
                                  param:(NSDictionary *)param
                              formDatas:(NSArray <GJWFormData *>*)formDatas
                                success:(GJWResponseSuccess)success
                                   fail:(GJWResponseFail)fail;

//+ (NSArray<NSURLSessionTask*>*)manageTasks;
@end

@interface GJWFormData : NSObject

/**
 *  <#Description#>
 */
@property (nonatomic, strong) NSData *imageData;
/**
 *  图片参数名（默认为file,name是指服务器端的文件夹名字）
 */
@property (nonatomic, copy) NSString *name;
/**
 *  文件名 (默认以时间戳命名.jpg/png)
 */
@property (nonatomic, copy) NSString *filename;
/**
 *  文件类型（默认为multipart/form-data,）
 */
@property (nonatomic, copy) NSString *mimeType;

@end

