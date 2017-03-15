//
//  WGRewardItem.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/15.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGRewardItem : NSObject
@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL canClick;
@property (nonatomic, assign) BOOL isWXSession;
/** 二维码Url */
@property (nonatomic, copy) NSString *scanUrl;
@property (nonatomic, assign) BOOL isScan;

@end
