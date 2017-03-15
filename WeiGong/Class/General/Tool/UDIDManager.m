//
//  UDIDManager.m
//  UDIDManager
//
//  Created by dfhb@rdd on 16/9/5.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "UDIDManager.h"

static NSString *UDIDName = @"name";
static NSString *UDIDService = @"service";

@interface UDIDManager ()
@end
@implementation UDIDManager

+ (NSString *)UDID {
    
    NSData *udidData = [self searchKeychainCopyMatching:UDIDName];
    
    NSString *udid = nil;
    if (udidData) {
        NSString *temp = [[NSString alloc] initWithData:udidData encoding:NSUTF8StringEncoding];
        udid = [NSString stringWithFormat:@"%@", temp];
    }
//    if (udid.length == 0) {
//        udid =
//    }
    return udid;
}

+ (BOOL)saveUDID:(NSString *)udid {
    BOOL saveOk = NO;
    NSData *udidData = [self searchKeychainCopyMatching:UDIDName];
    if (udidData == nil) {
        saveOk = [self createKeychainValue:udid forIdentifier:UDIDName];
    }else{
        saveOk = [self updateKeychainValue:udid forIdentifier:UDIDName];
    }
//    if (!saveOk) {
//        [self createPasteBoradValue:udid forIdentifier:CTUDIDName];
//    }
    return saveOk;
}

+ (BOOL)clearUDID {
    BOOL isClear = NO;
    
    isClear = [self deleteKeychainValue:UDIDName];
    
    return isClear;
}

+ (NSData *)searchKeychainCopyMatching:(NSString *)identifier {
    NSMutableDictionary *searchDictionary = [self generalPassDictWithIdentifier:identifier];
    
    // Add search attributes
    [searchDictionary setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    
    // Add search return types
    [searchDictionary setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    
    CFDataRef result = nil;
    SecItemCopyMatching((__bridge CFDictionaryRef)searchDictionary,
                        (CFTypeRef *)&result);
    
    return (__bridge NSData *)result;
}

#pragma mark - 添加
+ (BOOL)createKeychainValue:(NSString *)value forIdentifier:(NSString *)identifier {
    NSMutableDictionary *dictionary = [self generalPassDictWithIdentifier:identifier];
    
    NSData *passwordData = [value dataUsingEncoding:NSUTF8StringEncoding];
    [dictionary setObject:passwordData forKey:(__bridge id)kSecValueData];
    
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)dictionary, NULL);
    
    if (status == errSecSuccess) {
        return YES;
    }
    return NO;
}
#pragma mark - 更新
+ (BOOL)updateKeychainValue:(NSString *)value forIdentifier:(NSString *)identifier {
    NSMutableDictionary *searchDictionary = [self generalPassDictWithIdentifier:identifier];
    NSMutableDictionary *updateDictionary = [[NSMutableDictionary alloc] init];
    NSData *passwordData = [value dataUsingEncoding:NSUTF8StringEncoding];
    [updateDictionary setObject:passwordData forKey:(__bridge id)kSecValueData];
    
    OSStatus status = SecItemUpdate((__bridge CFDictionaryRef)searchDictionary,
                                    (__bridge CFDictionaryRef)updateDictionary);
    if (status == errSecSuccess) {
        return YES;
    }
    return NO;
}
#pragma mark - 删除
+ (BOOL)deleteKeychainValue:(NSString *)identifier {
    NSMutableDictionary *searchDictionary = [self generalPassDictWithIdentifier:identifier];
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)searchDictionary);
    if (status == errSecSuccess) {
        return YES;
    }
    return NO;
}


+ (NSMutableDictionary *)generalPassDictWithIdentifier:(NSString *)identifier {
    NSMutableDictionary *muDict = [[NSMutableDictionary alloc] init];
    
    [muDict setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
    NSData *encodedIdentifier = [identifier dataUsingEncoding:NSUTF8StringEncoding];
    [muDict setObject:encodedIdentifier forKey:(__bridge id)kSecAttrGeneric];
    [muDict setObject:encodedIdentifier forKey:(__bridge id)kSecAttrAccount];
    [muDict setObject:UDIDService forKey:(__bridge id)kSecAttrService];
    
    return muDict;
}










@end
