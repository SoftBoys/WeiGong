//
//  UIImage+Addition.h
//  WGKitDemo
//
//  Created by dfhb@rdd on 16/11/25.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Addition)
/** 返回一张自由拉伸的图片(以中心点延伸) */
+ (UIImage *)wg_resizedImageWithName:(NSString *)name;
/** 返回一张自由拉伸的图片(以中心点延伸) */
- (UIImage *)wg_resizedImage;
- (UIImage *)wg_resizedImageWithCapInsets:(UIEdgeInsets)capInsets;
/** 返回指定size的图片 */
- (UIImage *)wg_resizedImageWithNewSize:(CGSize)newSize;
@end

@interface UIImage (Color)
/** 根据颜色返回一张图片(默认size为(1,1)) */
+ (UIImage *)wg_imageWithColor:(UIColor *)color;
/** 根据颜色返回一张图片 */
+ (UIImage *)wg_imageWithColor:(UIColor *)color size:(CGSize)size;
/** 返回一张圆图片 */
- (UIImage *)wg_circleImage;
/** 返回一个带圆角的图片 */
- (UIImage *)wg_imageWithCornerRadius:(CGFloat)cornerRadius;
/** 返回一个带圆角,边框的图片 */
- (UIImage *)wg_imageWithCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/** 返回一个带圆角,边框的图片 */
- (UIImage *)wg_imageWithCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor rectCorner:(UIRectCorner)rectCorner;
@end

@interface UIImage (QR)
/** 生成二维码 */
+ (UIImage *)wg_imageWithQRString:(NSString *)qrString size:(CGSize)size;
@end

@interface UIImage (View)
/** View 转 Image */
+ (UIImage *)wg_imageWithView:(UIView *)view;
@end

typedef NS_ENUM(NSUInteger, WGArrowImageType) {
    WGArrowImageTypeTop,
    WGArrowImageTypeRight,
    WGArrowImageTypeBottom,
    WGArrowImageTypeLeft
};

@interface UIImage (Arrow)
/** 设置箭头 */
+ (UIImage *)wg_arrowImageWithColor:(UIColor *)color size:(CGSize)size arrowType:(WGArrowImageType)arrowType;
/** 设置箭头 */
+ (UIImage *)wg_arrowImageWithColor:(UIColor *)color size:(CGSize)size arrowW:(CGFloat)arrowW arrowType:(WGArrowImageType)arrowType;
@end
