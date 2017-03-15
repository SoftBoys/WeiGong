//
//  UIImage+Addition.m
//  WGKitDemo
//
//  Created by dfhb@rdd on 16/11/25.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "UIImage+Addition.h"

@implementation UIImage (Addition)
+ (UIImage *)wg_resizedImageWithName:(NSString *)name {
    UIImage *normal = [UIImage imageNamed:name];
    return [normal wg_resizedImage];
//    UIImage *image = [normal stretchableImageWithLeftCapWidth:imageW topCapHeight:imageH];
}
- (UIImage *)wg_resizedImage {
    CGFloat imageW = self.size.width * 0.5;
    CGFloat imageH = self.size.height * 0.5;
    return [self wg_resizedImageWithCapInsets:UIEdgeInsetsMake(imageH, imageW, imageH, imageW)];
}
- (UIImage *)wg_resizedImageWithCapInsets:(UIEdgeInsets)capInsets {
    return [self resizableImageWithCapInsets:capInsets];
}
- (UIImage *)wg_resizedImageWithNewSize:(CGSize)newSize {
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, [UIScreen mainScreen].scale);
    [self drawInRect:(CGRect){0,0,newSize}];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end

@implementation UIImage (Color)

+ (UIImage *)wg_imageWithColor:(UIColor *)color {
    CGSize imageSize = CGSizeMake(1.0, 1.0);
    return [self wg_imageWithColor:color size:imageSize];
}
+ (UIImage *)wg_imageWithColor:(UIColor *)color size:(CGSize)size {
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (UIImage *)wg_circleImage {
    CGSize size = self.size;
    float corner = MIN(size.width, size.height);
    return [self wg_imageWithCornerRadius:corner];
}
- (UIImage *)wg_imageWithCornerRadius:(CGFloat)cornerRadius {
    return [self wg_imageWithCornerRadius:cornerRadius borderWidth:0 borderColor:nil];
}
- (UIImage *)wg_imageWithCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    return [self wg_imageWithCornerRadius:cornerRadius borderWidth:borderWidth borderColor:borderColor rectCorner:UIRectCornerAllCorners];
}
- (UIImage *)wg_imageWithCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor rectCorner:(UIRectCorner)rectCorner {
    
    CGRect rect = (CGRect){0, 0, self.size};
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (cornerRadius > 0) {
        rect = CGRectMake(borderWidth/2, borderWidth/2, self.size.width-borderWidth, self.size.height-borderWidth);
        // [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:rectCorner cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        CGContextAddPath(context, path.CGPath);
        if (borderWidth > 0) {
            CGContextSetLineWidth(context, borderWidth);
            CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
            CGContextDrawPath(context, kCGPathFillStroke);
        } else {
            
        }
        [path addClip];
    } else {
        if (borderWidth > 0) {
            rect = CGRectMake(borderWidth/2, borderWidth/2, self.size.width-borderWidth, self.size.height-borderWidth);
            CGContextSetLineWidth(context, borderWidth);
            CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
            CGContextStrokeRect(context, rect);
        } else {
            
        }
    }
    
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end

@implementation UIImage (QR)

+ (UIImage *)wg_imageWithQRString:(NSString *)qrString size:(CGSize)size {
    
    NSString *text = qrString;
    NSData *stringData = [text dataUsingEncoding: NSUTF8StringEncoding];
    //生成
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setDefaults];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    //    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    
    //上色
    //    UIColor *onColor = [UIColor redColor];
    //    UIColor *offColor = [UIColor blueColor];
    //    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
    //                                       keysAndValues:
    //                             @"inputImage",qrFilter.outputImage,
    //                             @"inputColor0",[CIColor colorWithCGColor:onColor.CGColor],
    //                             @"inputColor1",[CIColor colorWithCGColor:offColor.CGColor],
    //                             nil];
    
    CIImage *qrImage = qrFilter.outputImage;
    
    //绘制
    //    CGSize size = CGSizeMake(300, 300);
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRelease(cgImage);
    return codeImage;
}

@end

@implementation UIImage (View)

+ (UIImage *)wg_imageWithView:(UIView *)view {
    CGSize size = view.wg_size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

@implementation UIImage (Arrow)
+ (UIImage *)wg_arrowImageWithColor:(UIColor *)color size:(CGSize)size arrowType:(WGArrowImageType)arrowType {
    return [self wg_arrowImageWithColor:color size:size arrowW:kLineHeight arrowType:arrowType];
}
+ (UIImage *)wg_arrowImageWithColor:(UIColor *)color size:(CGSize)size arrowW:(CGFloat)arrowW arrowType:(WGArrowImageType)arrowType {
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat point1x = 0, point1y = 0, point2x = 0, point2y = 0, point3x = 0, point3y = 0;
    if (arrowType == WGArrowImageTypeTop) {
        point1y = size.height;
        point2x = size.width/2;
        point3x = size.width;
        point3y = size.height;
    } else if (arrowType == WGArrowImageTypeBottom) {
        point2x = size.width/2;
        point2y = size.height;
        point3x = size.width;
    } else if (arrowType == WGArrowImageTypeRight) {
        point2x = size.width;
        point2y = size.height/2;
        point3y = size.height;
    } else if (arrowType == WGArrowImageTypeLeft) {
        point1x = size.width;
        point2x = 0;
        point2y = size.height/2;
        point3x = size.width;
        point3y = size.height;
    }
    CGPoint point1 = CGPointMake(point1x, point1y);
    CGPoint point2 = CGPointMake(point2x, point2y);
    CGPoint point3 = CGPointMake(point3x, point3y);
    
    
    CGContextMoveToPoint(context, point1.x, point1.y);
    CGContextAddLineToPoint(context, point2.x, point2.y);
    CGContextAddLineToPoint(context, point3.x, point3.y);
    //    CGContextAddLineToPoint(context, point1.x, point1.y);
    
    //    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    
    //    CGContextDrawPath(context, kCGPathFill);
    CGContextSetLineWidth(context, arrowW);
    CGContextDrawPath(context, kCGPathStroke);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

@end
