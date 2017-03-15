//
//  WGAuthIdentifyPostPhotoView.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/19.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WGAuthIdentifyPostPhotoItem;
@protocol WGAuthIdentifyPostPhotoViewDelegate <NSObject>

- (void)didClickImageWithItem:(WGAuthIdentifyPostPhotoItem *)item;
- (void)didClickUpdateButtonWithItem:(WGAuthIdentifyPostPhotoItem *)item;

@end


@interface WGAuthIdentifyPostPhotoView : UIView
@property (nonatomic, strong, readonly) UIImageView *imageView;
@property (nonatomic, strong) WGAuthIdentifyPostPhotoItem *item;
@property (nonatomic, weak) id<WGAuthIdentifyPostPhotoViewDelegate> delegate;
@end

@interface WGAuthIdentifyPostPhotoItem : NSObject
@property (nonatomic, strong) UIImage *placeholderImage;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *title;
/** 0:正面 1:背面 2:手持 */
@property (nonatomic, assign) NSInteger index;
/** 是否显示按钮 */
@property (nonatomic, assign) BOOL showButton;
/** image高度 */
@property (nonatomic, assign) CGFloat imageH;
@end
