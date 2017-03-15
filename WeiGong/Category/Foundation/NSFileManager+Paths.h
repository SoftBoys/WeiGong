//
//  NSFileManager+Paths.h
//  WGKitDemo
//
//  Created by dfhb@rdd on 16/11/28.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Paths)
/** 文档目录 */
+ (NSString *)wg_documentsPath;
/** 临时文件目录 */
+ (NSString *)wg_libraryPath;
/** 缓存目录 */
+ (NSString *)wg_cachesPath;

@end
