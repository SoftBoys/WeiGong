//
//  GuideViewController.h
//  GJW_BaseViewController
//
//  Created by dfhb@rdd on 16/3/31.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AnimationType) {
    AnimationType1,
    AnimationType2,
    AnimationType3,
};
@interface GuideViewController : UIViewController 

+ (instancetype)guideViewWithImages:(NSArray <UIImage *> *)images complete:(void(^)())complete;

@property (nonatomic, assign) AnimationType type;
@end
