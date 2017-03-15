//
//  WGBaseResponse.h
//  WGPublicClassDemo
//
//  Created by dfhb@rdd on 16/12/2.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, WGResponseErrorType) {
    /** 请求正常 (0) */
    kWGResponseErrorTypeNone = 0,
    /** 未知错误 (-1) */
    kWGResponseErrorTypeUnknown = NSURLErrorUnknown,
    /** 请求超时 (-1001) */
    kWGResponseErrorTypeTimedOut = NSURLErrorTimedOut,
    /** 网络异常 (-1005) */
    kWGResponseErrorTypeNotNetwork = NSURLErrorNetworkConnectionLost,
    /** 无网络 (-1009) */
    kWGResponseErrorTypeNotInternet = NSURLErrorNotConnectedToInternet,
    /** 服务器无响应 (-1011) */
    kWGResponseErrorTypeBadServer = NSURLErrorBadServerResponse,
    /** ATS问题 (-1022) */
    kWGResponseErrorTypeATS = NSURLErrorAppTransportSecurityRequiresSecureConnection
    /** NSURLErrorAppTransportSecurityRequiresSecureConnection */
};

@interface WGBaseResponse : NSObject
/** 响应码 (0表示取消请求) */
@property (nonatomic, assign, readonly) NSInteger statusCode;

@property (nonatomic, strong, readonly) NSData *responseData;

@property (nonatomic, copy, readonly) NSString *responseString;

@property (nonatomic, strong, readonly) id responseJSON;

@property (nonatomic, assign, readonly) WGResponseErrorType errorType;

- (instancetype)initWithStatusCode:(NSInteger)statusCode responseData:(NSData *)responseData responseString:(NSString *)responseString responseJSON:(id)responseJSON error:(NSError *)error;

@end
