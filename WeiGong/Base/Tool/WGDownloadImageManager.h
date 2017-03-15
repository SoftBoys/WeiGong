//
//  WGDownloadImageManager.h
//  WGPublicClassDemo
//
//  Created by dfhb@rdd on 16/12/1.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^WGCompleteHandle)(BOOL finished, UIImage *image);
typedef void(^WGProgressHandle)(CGFloat progress);
@interface WGDownloadImageManager : NSObject

+ (void)downloadImageWithUrl:(NSString *)url completeHandle:(WGCompleteHandle)completeHandle;
+ (void)downloadImageWithUrl:(NSString *)url completeHandle:(WGCompleteHandle)completeHandle progressHandle:(WGProgressHandle)progressHandle;

+ (UIImage *)cacheImageWithUrl:(NSString *)url;

@end
