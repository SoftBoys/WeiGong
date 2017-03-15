//
//  WG_HomeClassItem.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/15.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WG_HomeClassItem : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *nameUrl;

@property (nonatomic, copy) NSString *nameContent;
@property (nonatomic, copy) NSString *remarks;
@property (nonatomic, copy) NSString *nameUrlDefault;
@property (nonatomic, copy) NSString *nameUrlSm;
@property (nonatomic, strong) NSNumber *code;
@property (nonatomic, strong) NSNumber *cityDictId;
@property (nonatomic, strong) NSNumber *dataDictionaryId;


@end
