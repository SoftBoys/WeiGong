//
//  NSFileManager+Paths.m
//  WGKitDemo
//
//  Created by dfhb@rdd on 16/11/28.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "NSFileManager+Paths.h"

@implementation NSFileManager (Paths)
/** NSCachesDirectory  NSLibraryDirectory */
+ (NSString *)wg_documentsPath {
    return [self wg_pathForDirectory:NSDocumentDirectory];
}
+ (NSString *)wg_libraryPath {
    return [self wg_pathForDirectory:NSLibraryDirectory];
}
+ (NSString *)wg_cachesPath {
    return [self wg_pathForDirectory:NSCachesDirectory];
}
#pragma mark - private
+ (NSString *)wg_pathForDirectory:(NSSearchPathDirectory)directory {
    return [NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES) firstObject];
}

@end
