//
//  WGDataTypeItem.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/2.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGDataTypeItem : NSObject

@property (nonatomic, assign) NSInteger code;
/** 11:岗位 12:薪酬 13:支付周期 14:支付方式 15:学历 16:账户 */
@property (nonatomic, assign) NSInteger typeId;

@property (nonatomic, copy) NSString *name;

@end
