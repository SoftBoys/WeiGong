//
//  NSAttributedString+Addition.h
//  WGPublicClassDemo
//
//  Created by dfhb@rdd on 16/12/2.
//  Copyright © 2016年 guojunwei. All rights reserved.
//  富文本

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WGAttributedSearchType) {
    /** 搜索全部关键字 */
    kAttributedSearchTypeAll,
    /** 只搜第一个关键字 */
    kAttributedSearchTypeSingle,
};
@interface NSAttributedString (Addition)

+ (NSAttributedString *)wg_attStringWithString:(NSString *)string
                                       keyWord:(NSString *)keyWord;

+ (NSAttributedString *)wg_attStringWithString:(NSString *)string
                                       keyWord:(NSString *)keyWord
                                          font:(UIFont *)font
                                highlightColor:(UIColor *)highlightColor
                                     textColor:(UIColor *)textColor;

+ (NSAttributedString *)wg_attStringWithString:(NSString *)string
                                       keyWord:(NSString *)keyWord
                                 highlightFont:(UIFont *)highlightFont
                                          font:(UIFont *)font
                                highlightColor:(UIColor *)highlightColor
                                     textColor:(UIColor *)textColor;

+ (NSAttributedString *)wg_attStringWithString:(NSString *)string
                                       keyWord:(NSString *)keyWord
                                 highlightFont:(UIFont *)highlightFont
                                          font:(UIFont *)font
                                highlightColor:(UIColor *)highlightColor
                                     textColor:(UIColor *)textColor
                                     lineSpace:(CGFloat)lineSpace
                                     searhType:(WGAttributedSearchType)searhType;

+ (NSAttributedString *)wg_attStringWithString:(NSString *)string
                                       keyWord:(NSString *)keyWord
                                 highlightFont:(UIFont *)highlightFont
                                          font:(UIFont *)font
                                highlightColor:(UIColor *)highlightColor
                                     textColor:(UIColor *)textColor
                                     lineSpace:(CGFloat)lineSpace
                                     alignment:(NSTextAlignment)alignment
                                     searhType:(WGAttributedSearchType)searhType;

@end

@interface NSAttributedString (Size)
- (CGFloat)wg_widthWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
- (CGFloat)wg_heightWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
- (CGSize)wg_sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
@end
