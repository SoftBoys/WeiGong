//
//  WGWorkExperienceItem.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/20.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGWorkExperienceItem : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSUInteger code;
/** 标签状态，是否选中 */
@property (nonatomic, assign) NSUInteger validate;

@end
