//
//  DMLoginTool.h
//  DMPartTime
//
//  Created by dfhb@rdd on 17/2/13.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGLoginTool : NSObject

+ (void)loginWithCompleteHandle:(void(^)(WGBaseResponse *response))handle;

@end
