//
//  WG_LoginNetTool.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/20.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WG_LoginParam : NSObject
/** 传1 */
@property (nonatomic, assign) NSInteger automaticLogin;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *passWord;
@property (nonatomic, copy) NSString *deviceToken;
/** 设备类型（2表示ios）*/
@property (nonatomic, assign) NSInteger deviceType;
@end
