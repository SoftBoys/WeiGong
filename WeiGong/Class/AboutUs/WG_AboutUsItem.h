//
//  WG_AboutUsItem.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/24.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WG_AboutUsItem : NSObject

@property (nonatomic, copy) NSString *name_left;

@property (nonatomic, copy) NSString *name_right;

@property (nonatomic, copy) NSString *contentUrl;
/** 0:无作用 1:网页 2:打电话 */
@property (nonatomic, assign) NSUInteger type;
@end
