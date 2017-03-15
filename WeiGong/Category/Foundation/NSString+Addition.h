//
//  NSString+Addition.h
//  WGKitDemo
//
//  Created by dfhb@rdd on 16/11/28.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Addition)
/** MD5加密 */
- (NSString *)wg_MD5;
/** 数字0-9 */
- (BOOL)wg_isNumber;
/** 验证手机号 */
- (BOOL)wg_isPhone;
/** 验证身份证号码 */
- (BOOL)wg_isIdentifyCard;
/** 验证邮箱 */
- (BOOL)wg_isEmail;
@end

#pragma mark - 版本号之间的比较
@interface NSString (Version)
/** 比较版本号 (旧) */
- (BOOL)wg_isOlderVersionThan:(NSString *)otherVersion;
/** 比较版本号 (新) */
- (BOOL)wg_isNewerVersionThan:(NSString *)otherVersion;
@end

@interface NSString (Size)
- (CGFloat)wg_widthWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
- (CGFloat)wg_heightWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
- (CGSize)wg_sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
@end

