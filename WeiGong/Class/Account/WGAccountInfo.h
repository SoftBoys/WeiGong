//
//  WGAccountInfo.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/22.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WGAccountBankInfo;
@interface WGAccountInfo : NSObject

@property (nonatomic, copy) NSString *accountType;

@property (nonatomic, copy) NSString *accountTypeName;

@property (nonatomic, copy) NSArray <WGAccountBankInfo *> *bankInfo;

@end

@interface WGAccountBankInfo : NSObject

@property (nonatomic, copy) NSString *bankId;

@property (nonatomic, copy) NSString *bankName;

@end
