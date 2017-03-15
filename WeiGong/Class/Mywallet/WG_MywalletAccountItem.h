//
//  WG_MywalletAccountItem.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/4.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WG_MywalletAccountItem : NSObject

@property (nonatomic, assign) float accountBalance;
@property (nonatomic, copy) NSString *accountDateStr;
@property (nonatomic, assign) NSUInteger personalAccountId;
/** yyyyMMdd */
@property (nonatomic, copy) NSString *accountDate;
@property (nonatomic, assign) float accountMoney;
@property (nonatomic, copy) NSString *accountName;
@end
