//
//  WGHuanxinTool.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/28.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGHuanxinTool : NSObject

+ (void)wg_loginWithName:(NSString *)name pass:(NSString *)pass;

+ (void)wg_loginout;
@end
