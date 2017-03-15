//
//  WGApplyJobCollectionViewCell.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/3.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WGApplyJobCollectionItem;
@interface WGApplyJobCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) WGApplyJobCollectionItem *item;
@end

@interface WGApplyJobCollectionItem : NSObject

@property (nonatomic, strong) NSDate *date;

@property (nonatomic, copy) NSString *day;

@property (nonatomic, assign) BOOL isToday;

@property (nonatomic, assign) BOOL enabled;

@property (nonatomic, assign, getter=isSelected) BOOL selected;



@end
