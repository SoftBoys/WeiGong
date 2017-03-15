//
//  WGRequestManager.m
//  WGPublicClassDemo
//
//  Created by dfhb@rdd on 16/12/1.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WGRequestManager.h"
#import <AFNetworking.h>
#import <AFNetworkActivityIndicatorManager.h>

static NSString *kWGBaseUrl = nil;
static NSTimeInterval kTimeOut = 30.0f;
@interface AFHTTPSessionManager (Shared)
+ (instancetype)shareManager;
@end
@implementation AFHTTPSessionManager (Shared)
+ (instancetype)shareManager {
    static AFHTTPSessionManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[WGRequestManager baseUrl]]];
        
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
//#warning 有可能会不起作用
        _manager.requestSerializer.timeoutInterval = kTimeOut;
        
//        * 添加 SSL 认证 
//        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
//        //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO//如果是需要验证自建证书，需要设置为YES
//        securityPolicy.allowInvalidCertificates = YES;
//        //validatesDomainName 是否需要验证域名，默认为YES；
//        securityPolicy.validatesDomainName = NO;
//        _manager.securityPolicy = securityPolicy;
        
        _manager.operationQueue.maxConcurrentOperationCount = 3;
        
        // 设置支持接收类型
        NSSet *contentTypes = [NSSet setWithArray:@[@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*"]];
        _manager.responseSerializer.acceptableContentTypes = contentTypes;
        
       // [_manager.requestSerializer setValue:@"LmRlaxAOMj/RXDMT2iPyNa1HNjiZ7lIaoQyTI6pG8hWdV0bISQt3eoFpMyPvVie0zFfT7Zi6" forHTTPHeaderField:@"AccessToken"];
    });
    return _manager;
}
@end

@implementation WGRequestManager

+ (void)setTimeOut:(NSTimeInterval)timeOut {
    if (timeOut > 0) {
        kTimeOut = timeOut;
    }
}
+ (void)setBaseUrl:(NSString *)baseUrl {
    kWGBaseUrl = baseUrl;
}
+ (NSString *)baseUrl {
    
    return kBaseUrl;
    return kWGBaseUrl;
}

+ (void)configHttpHeaders:(NSDictionary *)httpHeaders {
    if ([httpHeaders isKindOfClass:[NSDictionary class]]) {
        for (NSString *key in [httpHeaders allKeys]) {
            if (key && httpHeaders[key]) {
                [[AFHTTPSessionManager shareManager].requestSerializer setValue:httpHeaders[key] forHTTPHeaderField:key];
            }
        }
    }
    
}

+ (WGSessionTask *)GET:(NSString *)URLString success:(WGResponseSuccessCallBack)success fail:(WGResponseFailCallBack)fail {
    return [self GET:URLString parameters:nil success:success fail:fail];
}
+ (WGSessionTask *)GET:(NSString *)URLString parameters:(id)parameters success:(WGResponseSuccessCallBack)success fail:(WGResponseFailCallBack)fail {
    return [self GET:URLString parameters:parameters responseSerializerType:WGResponseSerializerTypeJSON success:success fail:fail];
}
+ (WGSessionTask *)GET:(NSString *)URLString parameters:(id)parameters responseSerializerType:(WGResponseSerializerType)responseType success:(WGResponseSuccessCallBack)success fail:(WGResponseFailCallBack)fail {
    return [self requestWithUrl:URLString parameters:parameters responseSerializerType:responseType method:1 success:success fail:fail];
}

+ (WGSessionTask *)POST:(NSString *)URLString parameters:(id)parameters success:(WGResponseSuccessCallBack)success fail:(WGResponseFailCallBack)fail {
    return [self POST:URLString parameters:parameters responseSerializerType:WGResponseSerializerTypeJSON success:success fail:fail];
}
+ (WGSessionTask *)POST:(NSString *)URLString parameters:(id)parameters responseSerializerType:(WGResponseSerializerType)responseType success:(WGResponseSuccessCallBack)success fail:(WGResponseFailCallBack)fail {
    return [self requestWithUrl:URLString parameters:parameters responseSerializerType:responseType method:2 success:success fail:fail];
}

+ (WGSessionTask *)requestWithUrl:(NSString *)URLString parameters:(id)parameters responseSerializerType:(WGResponseSerializerType)responseType method:(NSInteger)method success:(WGResponseSuccessCallBack)success fail:(WGResponseFailCallBack)fail {
    
    // 开启转圈圈
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager shareManager];
    manager.responseSerializer = [self responseSerializerWithType:responseType];
    WGSessionTask *sessionTask = nil;
    if (method == 1) {
        sessionTask = [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(task, responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (fail) {
                fail(task, error);
            }
        }];
    } else if (method == 2) {
        sessionTask = [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(task, responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (fail) {
                fail(task, error);
            }
        }];
    }
    
    return sessionTask;
}

+ (WGSessionTask *)POST:(NSString *)URLString parameters:(id)parameters imageDatas:(NSArray<WGFormData *> *)imageDatas success:(WGResponseSuccessCallBack)success fail:(WGResponseFailCallBack)fail {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager shareManager];
    manager.responseSerializer = [self responseSerializerWithType:WGResponseSerializerTypeJSON];
    WGSessionTask *sessionTask = nil;
    sessionTask = [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (WGFormData *_form in imageDatas) {
            
            [formData appendPartWithFileData:_form.imageData name:_form.name fileName:_form.filename mimeType:_form.mimeType];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(task, error);
        }
    }];
    return sessionTask;
}

+ (AFHTTPResponseSerializer *)responseSerializerWithType:(WGResponseSerializerType)type {
    switch (type) {
        case WGResponseSerializerTypeDefault:
            return [AFJSONResponseSerializer serializer];
            break;
        case WGResponseSerializerTypeJSON:
            return [AFJSONResponseSerializer serializer];
            break;
        case WGResponseSerializerTypeXML:
            return [AFXMLParserResponseSerializer serializer];
            break;
        case WGResponseSerializerTypePlist:
            return [AFPropertyListResponseSerializer serializer];
            break;
        case WGResponseSerializerTypeImage:
            return [AFImageResponseSerializer serializer];
            break;
        case WGResponseSerializerTypeCompound:
            return [AFCompoundResponseSerializer serializer];
            break;
        case WGResponseSerializerTypeData:
            return [AFHTTPResponseSerializer serializer];
            break;
            
        default:
            return [AFJSONResponseSerializer serializer];
            break;
    }
    return nil;
}


+ (void)cancelTaskWithUrl:(NSString *)url {
    if (url == nil) {
        return;
    }
    NSArray <WGSessionTask *> *dataTasks = [self allTask];
    for (WGSessionTask *_task in dataTasks) {
        if ([_task isKindOfClass:[NSURLSessionTask class]]) {
            if ([_task.currentRequest.URL.absoluteString hasPrefix:url]) {
                [_task cancel];
            }
        }
    }
}
+ (void)cancelTask:(WGSessionTask *)task {
    [self cancelTaskId:task.taskIdentifier];
}

+ (void)cancelTaskId:(NSInteger)taskId {
    NSArray <WGSessionTask *> *dataTasks = [self allTask];
    for (WGSessionTask *_task in dataTasks) {
        if ([_task isKindOfClass:[NSURLSessionTask class]]) {
            if (_task.taskIdentifier == taskId) {
                [_task cancel];
            }
        }
    }
}
+ (void)cancelAllTask {
    NSArray <WGSessionTask *> *dataTasks = [self allTask];
    for (WGSessionTask *_task in dataTasks) {
        [_task cancel];
    }
}
+ (NSArray<WGSessionTask *> *)allTask {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager shareManager];
    NSArray <WGSessionTask *> *dataTasks = manager.dataTasks;
    return dataTasks;
}
@end


@implementation WGFormData
- (instancetype)init {
    if (self = [super init]) {
        _name = @"file";
        _mimeType = @"image/png";
        
        _mimeType = @"multipart/form-data";
        _name = @"file";
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *name = [NSString stringWithFormat:@"%@.jpg",[formatter stringFromDate:date]];
        _filename = name;
    }
    return self;
}
@end
