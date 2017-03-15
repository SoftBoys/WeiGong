//
//  GJWNetwork.m
//  GJWNetworkDemo
//
//  Created by dfhb@rdd on 16/7/21.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "GJWNetwork.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"

@interface GJWHTTPSessionManager : AFHTTPSessionManager
+ (instancetype)shareInstance;
@property (nonatomic, strong) NSMutableArray *arrayOfTasks;
@end
@implementation GJWHTTPSessionManager

+ (instancetype)shareInstance {
    static GJWHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([GJWNetwork baseUrl]) {
            manager = [[GJWHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[GJWNetwork baseUrl]]];
        } else {
            manager = [GJWHTTPSessionManager manager];
        }
    });
    return manager;
}

- (NSMutableArray *)arrayOfTasks {
    if (_arrayOfTasks == nil) {
        _arrayOfTasks = [NSMutableArray new];
    }
    return _arrayOfTasks;
}

@end

void GJWLog(NSString *format) {
#ifdef DEBUG
    //    va_list argptr;
    //    va_start(argptr, format);
    NSLog(format, nil);
    //    va_end(argptr);
#endif
}

static NSString *gjw_baseUrl = nil;

static NSDictionary *gjw_httpHeads = nil;
static GJWRequestType gjw_requestType = kGJWRequestTypeJSON;
static GJWResponseType gjw_responseType = kGJWResponseTypeJSON;
static NSTimeInterval gjw_timeout = 30.0f;
@implementation GJWNetwork

+ (void)updateBaseUrl:(NSString *)baseUrl {
    gjw_baseUrl = baseUrl;
}
+ (NSString *)baseUrl {
    return gjw_baseUrl;
}

+ (void)configHttpHeaders:(NSDictionary *)httpHeads {
    gjw_httpHeads = httpHeads;
}
+ (void)configRequestType:(GJWRequestType)requestType responseType:(GJWResponseType)responseType {
    gjw_requestType = requestType;
    gjw_responseType = responseType;
}
+ (void)setTimeout:(NSTimeInterval)timeout {
    if (timeout <= 0) {
        return;
    }
    gjw_timeout = timeout;
}
+ (void)cancelAllRequest {
    for (NSURLSessionTask *task in [self manager].arrayOfTasks) {
        if ([task isKindOfClass:[NSURLSessionTask class]]) {
            [task cancel];
        }
    }
    [[self manager].arrayOfTasks removeAllObjects];
//    [[self manager].operationQueue cancelAllOperations];
}
+ (void)cancelTask:(GJWURLSessionTask *)task {
    if (task == nil) {
        return;
    }
    if ([[self manager].arrayOfTasks containsObject:task]) {
        [[self manager].arrayOfTasks removeObject:task];
    }
}

+ (void)cancelTaskWithUrl:(NSString *)url {
    if (url == nil) {
        return;
    }
    [[self manager].arrayOfTasks enumerateObjectsUsingBlock:^(GJWURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([task isKindOfClass:[GJWURLSessionTask class]]) {
            NSString *path = task.currentRequest.URL.absoluteString;
            if ([path hasSuffix:url]) {
                [task cancel];
                [[self manager].arrayOfTasks removeObject:task];
            }
        }
    }];
}

+ (GJWHTTPSessionManager *)manager {
    // 开启转圈圈
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    GJWHTTPSessionManager *manager = [GJWHTTPSessionManager shareInstance];
    
    // 设置请求类型
    switch (gjw_requestType) {
        case kGJWRequestTypeJSON:
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        case kGJWRequestTypePlainText:
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
            
        default:
            break;
    }
    
    // 设置响应类型
    switch (gjw_responseType) {
        case kGJWResponseTypeJSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case kGJWResponseTypeXML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        case kGJWResponseTypeData:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
            
        default:
            break;
    }
    
    // 设置请求头
    if ([gjw_httpHeads isKindOfClass:[NSDictionary class]]) {
        for (NSString *key in [gjw_httpHeads allKeys]) {
            if ([key isKindOfClass:[NSString class]] && key.length) {
                [manager.requestSerializer setValue:gjw_httpHeads[key] forHTTPHeaderField:key];
            }
        }
    }
    
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = gjw_timeout;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    // 最多同时请求三个
    manager.operationQueue.maxConcurrentOperationCount = 3;
    
    // 设置支持接收类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    
    return manager;
}

+ (GJWURLSessionTask *)getWithUrl:(NSString *)url success:(GJWResponseSuccess)success fail:(GJWResponseFail)fail {
    return [self getWithUrl:url param:nil success:success fail:fail];
}
+ (GJWURLSessionTask *)getWithUrl:(NSString *)url param:(NSDictionary *)param success:(GJWResponseSuccess)success fail:(GJWResponseFail)fail {
    return [self _requestWithUrl:url httpMethod:1 param:param success:success fail:fail];
}
+ (GJWURLSessionTask *)postWithUrl:(NSString *)url param:(NSDictionary *)param success:(GJWResponseSuccess)success fail:(GJWResponseFail)fail {
    return [self _requestWithUrl:url httpMethod:2 param:param success:success fail:fail];
}

+ (GJWURLSessionTask *)_requestWithUrl:(NSString *)url httpMethod:(NSInteger)method param:(NSDictionary *)param success:(GJWResponseSuccess)success fail:(GJWResponseFail)fail {
    GJWHTTPSessionManager *manager = [self manager];
    
    if (![url isKindOfClass:[NSString class]] || url == nil) {
        GJWLog(@"url不对");
        return nil;
    }
    
    NSString *absolutePath = [[NSURL URLWithString:url relativeToURL:[NSURL URLWithString:[self baseUrl]]] absoluteString];

    if (absolutePath.length == 0) {
        GJWLog(@"url不对");
        return nil;
    }
    GJWURLSessionTask *task = nil;
    if (method == 1) {
        task = [manager GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [[self manager].arrayOfTasks removeObject:task];
            [self successWithTask:task response:responseObject callBack:success];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [[self manager].arrayOfTasks removeObject:task];
            [self failWithTask:task error:error callBack:fail];
        }];
    } else if (method == 2) {
        task = [manager POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [[self manager].arrayOfTasks removeObject:task];
            [self successWithTask:task response:responseObject callBack:success];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [[self manager].arrayOfTasks removeObject:task];
            [self failWithTask:task error:error callBack:fail];
        }];
    }
    
    if (task) {
        [[self manager].arrayOfTasks addObject:task];
    }
    
    return task;
}
+ (GJWURLSessionTask *)postImageWithUrl:(NSString *)url param:(NSDictionary *)param formData:(GJWFormData *)formData success:(GJWResponseSuccess)success fail:(GJWResponseFail)fail {
    if (formData == nil || ![formData isKindOfClass:[GJWFormData class]]) {
        GJWLog(@"");
        return nil;
    }
    return [self postImageWithUrl:url param:param formDatas:@[formData] success:success fail:fail];
}
+ (GJWURLSessionTask *)postImageWithUrl:(NSString *)url param:(NSDictionary *)param formDatas:(NSArray<GJWFormData *> *)formDatas success:(GJWResponseSuccess)success fail:(GJWResponseFail)fail {
    GJWHTTPSessionManager *manager = [self manager];
    
    if (![url isKindOfClass:[NSString class]] || url == nil) {
        GJWLog(@"url不对");
        return nil;
    }
    
    NSString *absolutePath = [[NSURL URLWithString:url relativeToURL:[NSURL URLWithString:[self baseUrl]]] absoluteString];
    
    if (absolutePath.length == 0) {
        GJWLog(@"url不对");
        return nil;
    }
    
    GJWURLSessionTask *task = nil;
    task = [manager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (GJWFormData *postData in formDatas) {
            
            if ([postData isKindOfClass:[GJWFormData class]]) {
                
                NSData *imageData = [self imageDataWithData:postData.imageData];
                NSString *name = postData.name == nil ? @"file":postData.name;
                NSString *fileName = [self fileNameWithName:postData.filename];
                
                if (imageData && fileName && postData.mimeType) {
                    [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:postData.mimeType];
                }
                
            }
        }
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[self manager].arrayOfTasks removeObject:task];
        [self successWithTask:task response:responseObject callBack:success];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[self manager].arrayOfTasks removeObject:task];
        [self failWithTask:task error:error callBack:fail];
    }];
    
    if (task) {
        [[self manager].arrayOfTasks addObject:task];
    }
    
    return task;
}

+ (NSData *)imageDataWithData:(NSData *)data {
    if ([data isKindOfClass:[UIImage class]]) {
        return UIImageJPEGRepresentation((UIImage *)data, 1);
    } else if ([data isKindOfClass:[NSData class]]) {
        return (NSData *)data;
    }
    GJWLog(@"上传图片为空");
    return nil;
}
+ (NSString *)fileNameWithName:(NSString *)name {
    if (name == nil || ![name isKindOfClass:[NSString class]] || name.length == 0) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        name = [NSString stringWithFormat:@"%@.jpg", str];
    }
    return name;
}
#pragma mark - 成功回调
+ (void)successWithTask:(GJWURLSessionTask *)task response:(id)response callBack:(GJWResponseSuccess)success {

    if (success) {
        success(task, [self tryToParseData:response]);
    }
}
#pragma mark - 失败回调
+ (void)failWithTask:(GJWURLSessionTask *)task error:(NSError *)error callBack:(GJWResponseFail)fail {
    
    if (fail) {
        fail(task, error);
    }
}
// 尝试解析数据
+ (id)tryToParseData:(id)responseData {
    if ([responseData isKindOfClass:[NSData class]]) {
        
        NSError *error = nil;
        id response = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
        if (error == nil) {
            return response;
        }
    }
    return responseData;
}

+ (NSArray<NSURLSessionTask *> *)manageTasks {
    return [self manager].arrayOfTasks;
}
@end

@implementation GJWFormData

- (instancetype)init {
    self = [super init];
    if (self) {
        _name = @"file";
        _mimeType = @"multipart/form-data";
    }
    return self;
}

@end
