//
//  WG_MywalletAccount.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/4.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WG_MywalletAccount : NSObject

@property (nonatomic, assign) NSInteger addAccountFlag;

@property (nonatomic, assign) NSInteger cashRecord;

@property (nonatomic, assign) NSInteger checkFlag;

@property (nonatomic, assign) NSInteger payPwdFlag;

@property (nonatomic, assign) NSInteger offline;

@property (nonatomic, assign) double total;

@property (nonatomic, assign) double balance;

@property (nonatomic, assign) double totalOnline;
@end
