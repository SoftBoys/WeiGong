//
//  WG_TypeTool.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/26.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WGDataTypeItem;
@interface WG_TypeTool : NSObject
/** 岗位标签集合 */
+ (NSArray <WGDataTypeItem *>*)wg_typeJobPositionList;
/** 学历标签集合 */
+ (NSArray <WGDataTypeItem *>*)wg_typeEducationPositionList;
///** 岗位标签集合 */
//+ (NSArray <WGDataTypeItem *>*)wg_typeJobPositionList;
///** 岗位标签集合 */
//+ (NSArray <WGDataTypeItem *>*)wg_typeJobPositionList;

@end

