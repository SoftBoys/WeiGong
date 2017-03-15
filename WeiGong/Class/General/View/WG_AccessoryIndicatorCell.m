//
//  WG_AccessoryIndicatorCell.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/21.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_AccessoryIndicatorCell.h"

@implementation WG_AccessoryIndicatorCell

- (void)wg_setupSubViews {
    [super wg_setupSubViews];
    [self.contentView addSubview:self.arrowView];
    
    [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
}
- (UIButton *)arrowView {
    if (_arrowView == nil) {
        _arrowView = [UIButton new];
        
        [_arrowView setImage:[self arrowImage] forState:UIControlStateNormal];
    }
    return _arrowView;
}

- (UIImage *)arrowImage {
    CGSize size = CGSizeMake(8, 15);
    CGPoint point0 = CGPointMake(0, 0);
    CGPoint point1 = CGPointMake(size.width, size.height/2.0);
    CGPoint point2 = CGPointMake(0, size.height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    CGContextRef contenxt = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(contenxt, point0.x, point0.y);
    CGContextAddLineToPoint(contenxt, point1.x, point1.y);
    CGContextAddLineToPoint(contenxt, point2.x, point2.y);
    
    CGContextSetLineWidth(contenxt, kLineHeight);
    CGContextSetStrokeColorWithColor(contenxt, [UIColor wg_red:153 green:153 blue:153].CGColor);
    CGContextDrawPath(contenxt, kCGPathStroke);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

@end
