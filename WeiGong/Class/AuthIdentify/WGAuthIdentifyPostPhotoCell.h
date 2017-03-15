//
//  WGAuthIdentifyPostPhotoCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/19.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WG_BaseTableViewCell.h"

@class WGAuthIdentify;
@interface WGAuthIdentifyPostPhotoCell : WG_BaseTableViewCell
@property (nonatomic, strong) WGAuthIdentify *identify;

@property (nonatomic, copy, readonly) NSArray *photoItems;
@end
