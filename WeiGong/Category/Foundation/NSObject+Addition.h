//
//  NSObject+Addition.h
//  WGKitDemo
//
//  Created by dfhb@rdd on 16/11/28.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (Addition)

@end

@interface NSObject (AppInfo)
/** App版本号 */
- (NSString *)wg_appVersion;
/** App构造版本 */
- (NSInteger)wg_appBuild;
/** App构造版本 */
- (NSString *)wg_appIdentifier;
@end

@interface NSObject (UIKit)
/** 当前视图控制器 */
+ (UIViewController *)wg_topViewController;
- (UIViewController *)wg_topViewController;

/** 根据名称获取ViewController */
- (UIViewController *)controllerWithClassString:(NSString *)name;
//static UIViewController * UIViewControllerWithClassString(id name);
@end

@interface NSObject (JSON)

/** 将属性名换为其他key去字典中取值 (新Key:被替换的Key) */
+ (void)wg_setupModelReplacedKeyWithDict:(NSDictionary *)dict;
+ (NSDictionary *)wg_dictWithModelReplacedKey;

/** 字典转模型 */
+ (instancetype)wg_modelWithDictionry:(NSDictionary *)dict;
/** 字典数组转模型数组 */
+ (NSArray *)wg_modelArrayWithDictArray:(NSArray *)dictArray;
/** 模型转字典 */
- (NSDictionary *)wg_keyValues;
/** 模型数组转字典数组 */
+ (NSArray *)wg_dictArrayWithModelArray:(NSArray *)modelArray;

/** 将存储Dict的array 转为 Model 的array (Key:model的class) */
+ (void)wg_setupModelClassInArray:(NSDictionary *)dict;
+ (NSDictionary *)wg_dictWithModelClassInArray;

/** 转换为字典或者数组 */
- (id)wg_JSONObject;
/** 转换为JSON字符串 */
- (NSString *)wg_JSONString;

@end






