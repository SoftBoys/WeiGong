//
//  WGRequestManager.h
//  WGPublicClassDemo
//
//  Created by dfhb@rdd on 16/12/1.
//  Copyright © 2016年 guojunwei. All rights reserved.
//  注意：ATS记得打开，添加字段 "App Transport Security Settings"

#import <Foundation/Foundation.h>

typedef NSURLSessionTask WGSessionTask;
typedef void(^WGResponseSuccessCallBack)(WGSessionTask *task, id responseObject);
typedef void(^WGResponseFailCallBack)(WGSessionTask *task, NSError *error);
typedef NS_ENUM(NSUInteger, WGResponseSerializerType) {
    /** 默认类型JSON */
    WGResponseSerializerTypeDefault,
    /** JSON类型 */
    WGResponseSerializerTypeJSON,
    /** XML类型 */
    WGResponseSerializerTypeXML,
    /** Plist类型 */
    WGResponseSerializerTypePlist,
    /** Image类型 */
    WGResponseSerializerTypeImage,
    /** Compound类型 */
    WGResponseSerializerTypeCompound,
    /** Data类型 (返回类型为二进制数据) */
    WGResponseSerializerTypeData,
};

@class WGFormData;
@interface WGRequestManager : NSObject
/** 设置 BaseUrl */
+ (void)setBaseUrl:(NSString *)baseUrl;
+ (NSString *)baseUrl;
/** 设置请求超时时间 (默认30s) */
+ (void)setTimeOut:(NSTimeInterval)timeOut;
/** 配置请求头 */
+ (void)configHttpHeaders:(NSDictionary *)httpHeaders;
/**
 *  发起GET请求
 *
 *  @param URLString 请求Url
 *  @param success   成功回调
 *  @param fail      失败回调
 */
+ (WGSessionTask *)GET:(NSString *)URLString success:(WGResponseSuccessCallBack)success fail:(WGResponseFailCallBack)fail;
/**
 *  发起GET请求
 *
 *  @param URLString 请求Url
 *  @param parameters 请求参数
 *  @param success   成功回调
 *  @param fail      失败回调
 */
+ (WGSessionTask *)GET:(NSString *)URLString parameters:(id)parameters success:(WGResponseSuccessCallBack)success fail:(WGResponseFailCallBack)fail;
/**
 *  发起GET请求
 *
 *  @param URLString 请求Url
 *  @param success   成功回调
 *  @param fail      失败回调
 *  @param responseType 返回类型（默认JSON）
 */
+ (WGSessionTask *)GET:(NSString *)URLString parameters:(id)parameters responseSerializerType:(WGResponseSerializerType)responseType success:(WGResponseSuccessCallBack)success fail:(WGResponseFailCallBack)fail;
/**
 *  发起POST请求
 *
 *  @param URLString 请求Url
 *  @param success   成功回调
 *  @param fail      失败回调
 */
+ (WGSessionTask *)POST:(NSString *)URLString parameters:(id)parameters success:(WGResponseSuccessCallBack)success fail:(WGResponseFailCallBack)fail;
/**
 *  发起POST请求
 *
 *  @param URLString 请求Url
 *  @param success   成功回调
 *  @param fail      失败回调
 *  @param responseType 返回类型（默认JSON）
 */
+ (WGSessionTask *)POST:(NSString *)URLString parameters:(id)parameters responseSerializerType:(WGResponseSerializerType)responseType success:(WGResponseSuccessCallBack)success fail:(WGResponseFailCallBack)fail;
/**
 *  发起图片POST请求
 *
 *  @param URLString 请求Url
 *  @param success   成功回调
 *  @param fail      失败回调
 */
+ (WGSessionTask *)POST:(NSString *)URLString parameters:(id)parameters imageDatas:(NSArray <WGFormData *> *)imageDatas success:(WGResponseSuccessCallBack)success fail:(WGResponseFailCallBack)fail;
/** 根据url取消网络请求 */
+ (void)cancelTaskWithUrl:(NSString *)url;
+ (void)cancelTask:(WGSessionTask *)task;
+ (void)cancelTaskId:(NSInteger)taskId;
+ (void)cancelAllTask;
/** 所有正在进行的Task */
+ (NSArray <WGSessionTask *> *)allTask;

@end

@interface WGFormData : NSObject
/** Image转为二进制数据 */
@property (nonatomic, strong) NSData *imageData;
/** 默认(file) */
@property (nonatomic, copy) NSString *name;
/** 文件名称 */
@property (nonatomic, copy) NSString *filename;
/** 默认(image/png) */
@property (nonatomic, copy) NSString *mimeType;

@end



