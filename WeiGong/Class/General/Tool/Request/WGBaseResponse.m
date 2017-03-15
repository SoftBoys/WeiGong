//
//  WGBaseResponse.m
//  WGPublicClassDemo
//
//  Created by dfhb@rdd on 16/12/2.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WGBaseResponse.h"

@implementation WGBaseResponse

- (instancetype)initWithStatusCode:(NSInteger)statusCode responseData:(NSData *)responseData responseString:(NSString *)responseString responseJSON:(id)responseJSON error:(NSError *)error {
    if (self = [super init]) {
        _statusCode = statusCode;
        _responseData = responseData;
        _responseString = responseString;
        _responseJSON = responseJSON;
        _errorType = kWGResponseErrorTypeNone;
        if (error) {
            _errorType = [error code];
        }
        if (error) {
            id data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
            if ([data isKindOfClass:[NSData class]]) {
                _responseData = data;
                data = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            }
//            WGLog(@"errorData:%@",data);
            if (_responseJSON == nil) {
                _responseJSON = data;
            }
            _responseString = [_responseJSON wg_JSONString];
        }
        
        /** 特别处理 */
        if (_statusCode != 200) {
            if ([_responseJSON isKindOfClass:[NSArray class]]) {
                _responseJSON = [(NSArray *)_responseJSON firstObject];
            }
        }
        
        // 重新登陆
        if (_statusCode == 401) {
            if ([_responseJSON isKindOfClass:[NSDictionary class]]) {
                NSString *message = _responseJSON[@"content"];
                [MBProgressHUD wg_message:message];
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kNoti_LoginIsOutDate object:nil];
            
        }

    }
    return self;
}
- (NSString *)description {
    return [NSString stringWithFormat:@"%@", self.responseJSON];
}
@end
