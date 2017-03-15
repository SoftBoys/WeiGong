//
//  NSString+Addition.m
//  WGKitDemo
//
//  Created by dfhb@rdd on 16/11/28.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "NSString+Addition.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Addition)

- (NSString *)wg_MD5 {
    if (self == nil || self.length == 0) {
        return nil;
    }
    NSData *inputData = [self dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char outputData[CC_MD5_DIGEST_LENGTH];
    CC_MD5([inputData bytes], (CC_LONG)inputData.length, outputData);
    NSMutableString *md5Str = @"".mutableCopy;
    for (NSUInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [md5Str appendFormat:@"%02x", outputData[i]];
    }
    return md5Str;
}
- (BOOL)wg_isNumber {
    NSString *regex = @"^[0-9]*$";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pre evaluateWithObject:self];
}

- (BOOL)wg_isPhone {
    NSString *Regex = @"^(0|86|17951)?(13[0-9]|15[012356789]|16[0123456789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [phoneTest evaluateWithObject:self];
}

- (BOOL)wg_isIdentifyCard {
    NSString *Regex = nil;
    if (self.length == 15) {
        Regex = @"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
    } else if (self.length == 18) {
        Regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    } else {
        return NO;
    }
    NSPredicate *identifyPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [identifyPre evaluateWithObject:self];
}
- (BOOL)wg_isEmail {
    NSString *Regex = @"[\\w!#$%&'*+/=?^_`{|}~-]+(?:\\.[\\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\\w](?:[\\w-]*[\\w])?\\.)+[\\w](?:[\\w-]*[\\w])?";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [phoneTest evaluateWithObject:self];
}
@end

@implementation NSString (Version)

- (BOOL)wg_isOlderVersionThan:(NSString *)otherVersion {
    NSComparisonResult result = [self compare:otherVersion options:NSNumericSearch];
    return (result == NSOrderedAscending || result == NSOrderedSame);
}
- (BOOL)wg_isNewerVersionThan:(NSString *)otherVersion {
    NSComparisonResult result = [self compare:otherVersion options:NSNumericSearch];
    return (result == NSOrderedDescending || result == NSOrderedSame);
}

@end

@implementation NSString (Size)
- (CGFloat)wg_widthWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    return [self wg_sizeWithFont:font maxSize:maxSize].width;
}
- (CGFloat)wg_heightWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    return [self wg_sizeWithFont:font maxSize:maxSize].height;
}
- (CGSize)wg_sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    
    CGRect bound = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return bound.size;
}

@end
