//
//  WGBaseRequest.m
//  WGPublicClassDemo
//
//  Created by dfhb@rdd on 16/12/2.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WGBaseRequest.h"
#import "WGRequestManager.h"

@interface WGBaseRequest ()
@property (nonatomic, copy) WGBaseResponseCompletion completion;
@end
@implementation WGBaseRequest

+ (instancetype)wg_request {
    return [self wg_requestWithUrl:nil];
}
+ (instancetype)wg_requestWithUrl:(NSString *)wg_url {
    return [self wg_requestWithUrl:wg_url isPost:NO];
}

+ (instancetype)wg_requestWithUrl:(NSString *)wg_url isPost:(BOOL)wg_isPost {
    return [self wg_requestWithUrl:wg_url isPost:wg_isPost delegate:nil];
}
+ (instancetype)wg_requestWithUrl:(NSString *)wg_url isPost:(BOOL)wg_isPost delegate:(id<WGBaseRequestResponseDelegate>)wg_delegate {
    WGBaseRequest *request = [[self alloc] init];
    request.wg_url = wg_url;
    request.wg_isPost = wg_isPost;
    request.wg_delegate = wg_delegate;
    return request;
}


- (void)wg_sendRequest {
    [self wg_sendRequestWithCompletion:nil];
}
- (void)wg_sendRequestWithCompletion:(WGBaseResponseCompletion)completion {
    
    if (self.wg_url == nil) {
#ifdef DEBUG
        NSLog(@"请求链接不能为空");
#endif
        return;
    }
    /** 先取消之前相同的请求 */
//    [WGRequestManager cancelTaskWithUrl:self.wg_url];
    self.completion = completion;
    /** 拼接请求参数 */
    NSMutableDictionary *publicParam = [self wg_publicParameter].mutableCopy;
    if (self.wg_parameters) {
        [publicParam addEntriesFromDictionary:self.wg_parameters];
    }
    self.wg_parameters = [publicParam copy];
    /** GET */
    if (self.wg_isPost == NO) {
        [WGRequestManager GET:self.wg_url parameters:self.wg_parameters success:^(WGSessionTask *task, id responseObject) {
            [self handleTask:task responseObject:responseObject error:nil];
        } fail:^(WGSessionTask *task, NSError *error) {
            [self handleTask:task responseObject:nil error:error];
        }];
    } else {
        /** POST */
        if (self.wg_imageArray == nil || self.wg_imageArray.count == 0) {
            [WGRequestManager POST:self.wg_url parameters:self.wg_parameters success:^(WGSessionTask *task, id responseObject) {
                [self handleTask:task responseObject:responseObject error:nil];
            } fail:^(WGSessionTask *task, NSError *error) {
                [self handleTask:task responseObject:nil error:error];
            }];
        } else {
            NSMutableArray *imageDatas = @[].mutableCopy;
            for (UIImage *image in self.wg_imageArray) {
                WGFormData *data = [WGFormData new];
                data.imageData = UIImageJPEGRepresentation(image, 1.0);
                data.filename = [self fileName];
                [imageDatas addObject:data];
            }
            [WGRequestManager POST:self.wg_url parameters:self.wg_parameters imageDatas:[imageDatas copy] success:^(WGSessionTask *task, id responseObject) {
                [self handleTask:task responseObject:responseObject error:nil];
            } fail:^(WGSessionTask *task, NSError *error) {
                [self handleTask:task responseObject:nil error:error];
            }];
        }
    }
    
}


#pragma mark - pravite
- (void)handleTask:(WGSessionTask *)task responseObject:(id)responseObject error:(NSError *)error {
    /** 响应状态吗 */
    NSInteger statusCode = [(NSHTTPURLResponse *)task.response statusCode];
    /** 响应数据 */
    id responseData = nil;
    /** 响应String */
    id responseString = nil;
    /** 响应JSON */
    id responseJSON = nil;
    if (responseObject) {
        if ([responseObject isKindOfClass:[NSData class]]) {
            responseData = responseObject;
        } else {
            responseData = [NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil];
        }
        if (responseData) {
            responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        }
        if (responseData) {
            responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        }
    }
    
    WGBaseResponse *response = [[WGBaseResponse alloc] initWithStatusCode:statusCode
                                                             responseData:responseData
                                                           responseString:responseString
                                                             responseJSON:responseJSON
                                                                    error:error];
    if (self.completion) {
        self.completion(response);
    }
    
    /** 防止造成死循环 */
    self.completion = nil;
    
    if ([self.wg_delegate respondsToSelector:@selector(wg_requestCompletionWithResponse:)]) {
        [self.wg_delegate wg_requestCompletionWithResponse:response];
    }
}

- (NSString *)fileName {
    NSString *name = [[WGBaseRequest dateFormatter] stringFromDate:[NSDate date]];
    return name;
}
+ (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd,HH-mm-ss";
    });
    return formatter;
}

@end

#import "WG_UserDefaults.h"
@implementation WGBaseRequest (PublicParam)

- (NSDictionary *)wg_publicParameter {
    NSMutableDictionary *muParam = @{}.mutableCopy;
    WG_UserDefaults *user = [WG_UserDefaults shareInstance];
    if (user.userId) {
        muParam[@"personalInfoId"] = user.userId;
    }
    return [muParam copy];
}

@end
