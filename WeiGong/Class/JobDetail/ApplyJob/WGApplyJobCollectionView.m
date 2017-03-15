//
//  WGApplyJobCollectionView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/2.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGApplyJobCollectionView.h"
#import "WGApplyJobCollectionHeader.h"
#import "WGApplyJobCollectionViewCell.h"



const CGFloat CalendarMinInteritemSpacing = 2.50f;
const CGFloat CalendarMinLineSpacing = 2.50f;
const CGFloat CalendarInsetTop = 2.0f;
const CGFloat CalendarInsetLeft = 10.0f;
const CGFloat CalendarInsetBottom = CalendarInsetTop;
const CGFloat CalendarInsetRight = CalendarInsetLeft;
const CGFloat CalendarHeaderHeight = 70.0f;

@interface WGApplyJobCollectionView ()
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation WGApplyJobCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    WGApplyJobCollectionLayout *applyLayout = [[WGApplyJobCollectionLayout alloc] init];
    if (self = [super initWithFrame:frame collectionViewLayout:applyLayout]) {
        
        
    }
    return self;
}






@end


@implementation WGApplyJobCollectionLayout

- (instancetype)init {
    if (self = [super init]) {
        self.minimumInteritemSpacing = CalendarMinInteritemSpacing;
        self.minimumLineSpacing = CalendarMinLineSpacing;
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.sectionInset = UIEdgeInsetsMake(CalendarInsetTop,
                                             CalendarInsetLeft,
                                             CalendarInsetBottom,
                                             CalendarInsetRight);
        self.headerReferenceSize = CGSizeMake(0, CalendarHeaderHeight);
        
        CGFloat itemWidth = floorf((kScreenWidth - CalendarInsetLeft - CalendarInsetRight - CalendarMinInteritemSpacing*6)/7);
        self.itemSize = CGSizeMake(itemWidth, itemWidth);
    }
    return self;
}

@end
