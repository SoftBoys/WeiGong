//
//  WGDownloadImageManager.m
//  WGPublicClassDemo
//
//  Created by dfhb@rdd on 16/12/1.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WGDownloadImageManager.h"
#import <UIImageView+WebCache.h>

@implementation WGDownloadImageManager

+ (void)downloadImageWithUrl:(NSString *)url completeHandle:(WGCompleteHandle)completeHandle {
    [self downloadImageWithUrl:url completeHandle:completeHandle progressHandle:nil];
}
+ (void)downloadImageWithUrl:(NSString *)url completeHandle:(WGCompleteHandle)completeHandle progressHandle:(WGProgressHandle)progressHandle {
    if (url == nil) {
        WGLog(@"imageUrl is nil...");
        if (completeHandle) {
            completeHandle(NO, nil);
        }
//        return;
    }
    UIImage *image = [self cacheImageWithUrl:url];
    if (image) {
        if (completeHandle) {
            completeHandle(YES, image);
        }
        if (progressHandle) {
            progressHandle(1.0);
        }
    } else {  // 调用第三方库下载图片, 本类以SDWebImage为例
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:[NSURL URLWithString:url] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            if (progressHandle) {
                progressHandle(receivedSize * 1.0 / expectedSize);
            }
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (completeHandle) {
                completeHandle(finished, image);
            }
        }];
        
    }
    
}

+ (UIImage *)cacheImageWithUrl:(NSString *)url {
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    NSString *key = [manager cacheKeyForURL:[NSURL URLWithString:url]];
    SDImageCache *cache = [SDImageCache sharedImageCache];
    UIImage *cacheImage = [cache imageFromDiskCacheForKey:key];
    return cacheImage;
}
@end
