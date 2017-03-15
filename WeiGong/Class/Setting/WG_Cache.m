//
//  WG_Cache.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/24.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_Cache.h"

#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
@implementation WG_Cache

+ (long long)wg_getCaches {
    
    NSString *path = CachePath;
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path]) {
        NSArray *subPaths = [manager subpathsAtPath:path];
        
        unsigned long long size = 0;
        //遍历所有子文件
        for (NSString *subPath in subPaths) {
            //1）.拼接完整路径
            NSString *filePath = [path stringByAppendingFormat:@"/%@",subPath];
            //2）.计算文件的大小
            long long fileSize = [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
            //3）.加载到文件的大小
            size += fileSize;
        }
        float size_m = size/(1024);
        return size_m;
        
    }
    return 0;
}
+ (BOOL)wg_clearCaches {
    NSString *path = CachePath;
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path]) {
        return [manager removeItemAtPath:path error:nil];
    } else{
        return nil;
    }
}

@end
