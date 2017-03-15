//
//  WG_DragView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/18.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_DragView.h"

@interface WG_DragView ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic,strong) UIImageView *imageView;
/** 设置偏移量 */
@property (nonatomic,assign) float offsetY;
@end
@implementation WG_DragView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setViews];
    }
    return self;
}
- (void)setViews {
    self.backView = [[UIView alloc] init];
    self.backView.clipsToBounds = YES;
    self.backView.layer.masksToBounds = YES;
    self.backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.backView];
    
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    [self.backView addSubview:self.imageView];
    
    self.isStretch = YES;
    self.parallaxHeight = 170;
    
    [self layoutSubviewsFrame];
}
#pragma mark 设置视差的高度
- (void)setParallaxHeight:(float)parallaxHeight {
    _parallaxHeight = parallaxHeight;
    [self layoutSubviewsFrame];
}
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self layoutSubviewsFrame];
}
#pragma mark 设置背景图片
- (void)setBackImage:(UIImage *)backImage {
    _backImage = backImage;
    if (_backImage) {
        self.imageView.image = _backImage;
    }
}
- (void)layoutSubviewsFrame {
    self.backView.frame = self.bounds;
    self.imageView.frame = CGRectMake(0, -self.parallaxHeight, CGRectGetWidth(self.frame), CGRectGetHeight(self.backView.frame) + self.parallaxHeight * 2);
}

#pragma mark 设置偏移量
- (void)setOffsetY:(float)offsetY {
    // 导航栏的高度
    float padding = 0;
    _offsetY = offsetY + padding;
    
    UIView *bannerSuper = _imageView.superview;
    CGRect bframe = bannerSuper.frame;
    
    //
    if(_offsetY < 0) {
        bframe.origin.y = _offsetY;
        bframe.size.height = -_offsetY + bannerSuper.superview.frame.size.height;
        bannerSuper.frame = bframe;
        CGPoint center =  _imageView.center;
        center.y = bannerSuper.frame.size.height / 2;
        _imageView.center = center;
        
        //设置放大效果
        if (self.isStretch) {
            CGFloat scale = fabsf(_offsetY) / self.parallaxHeight;
            _imageView.transform = CGAffineTransformMakeScale(1+scale, 1+scale);
        }
    }
    
    else {
        if(bframe.origin.y != 0) {
            bframe.origin.y = 0;
            bframe.size.height = _backView.superview.frame.size.height;
            _backView.frame = bframe;
        }
        if(_offsetY < bframe.size.height) {
            CGPoint center =  _imageView.center;
            center.y = _backView.frame.size.height/2 + 0.5 * _offsetY;
            _imageView.center = center;
        }
    }
    
}

#pragma mark 滑动的代理方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //    NSLog(@"即将开始拖拽");
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.offsetY = scrollView.contentOffset.y;
    //    NSLog(@"正在滑动");
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    //    NSLog(@"结束拖拽");
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //    NSLog(@"停止");
}


@end
