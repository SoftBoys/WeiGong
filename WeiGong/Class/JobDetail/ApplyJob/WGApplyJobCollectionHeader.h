//
//  WGApplyJobCollectionHeader.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/3.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGApplyJobCollectionHeader : UICollectionReusableView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) void (^previousHandle)();
@property (nonatomic, copy) void (^nextHandle)();
@end
