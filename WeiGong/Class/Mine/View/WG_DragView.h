//
//  WG_DragView.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/18.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WG_DragView : UIView
/**
 *  视差的高度，默认为170
 */
@property (nonatomic,assign) float parallaxHeight;
/**
 *  背景图片
 */
@property (nonatomic,strong) UIImage *backImage;
/**
 *  向下拉是否产生抖动效果,默认为YES
 */
@property (nonatomic,assign) BOOL isStretch;

//滑动的代理方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;

@end
