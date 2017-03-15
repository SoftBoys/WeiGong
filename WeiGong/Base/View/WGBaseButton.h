//
//  WGBaseButton.h
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/14.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, DMBaseButtonType) {
    /** 图标 标题 */
    kDMBaseButtonTypeImageTitle,
    /** 标题 图标 */
    kDMBaseButtonTypeTitleImage,
};
@interface WGBaseButton : UIButton
/** 图标与文字之间的横向间距 */
@property (nonatomic, assign) float spaceX;
/** 图标与文字之间的纵向间距 */
//@property (nonatomic, assign) float spaceY;

@property (nonatomic, assign) DMBaseButtonType type;
@end
