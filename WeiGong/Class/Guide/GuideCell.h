//
//  GuideCell.h
//  GJW_BaseViewController
//
//  Created by dfhb@rdd on 16/3/31.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GuideCellDelegate <NSObject>

- (void)nextFinished;

@end

@interface GuideCell : UICollectionViewCell

@property (nonatomic, weak) id<GuideCellDelegate> delegate;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, assign) BOOL isHiddenNextButton;
@end
