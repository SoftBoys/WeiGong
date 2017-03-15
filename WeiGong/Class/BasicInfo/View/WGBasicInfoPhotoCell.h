//
//  WGBasicInfoPhotoCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/6.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGBasicInfoBaseCell.h"

@class WGBasicInfoPhotoItem;
@protocol WGBasicInfoPhotoCellDelegate <NSObject>

- (void)wg_deletePicLifeWithItem:(WGBasicInfoPhotoItem *)item;

- (void)wg_addPicLife;

- (void)wg_clickPicLifeWithItem:(WGBasicInfoPhotoItem *)item;

@end

@interface WGBasicInfoPhotoCell : WGBasicInfoBaseCell
@property (nonatomic, weak) id<WGBasicInfoPhotoCellDelegate> delegate;
@end
