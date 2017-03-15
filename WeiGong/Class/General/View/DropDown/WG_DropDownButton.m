//
//  WG_DropDownButton.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/25.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_DropDownButton.h"

@interface WG_DropDownButton ()
@property (nonatomic, strong) UIView *line;
@property (nonatomic, assign) CGFloat labelW;
@end
@implementation WG_DropDownButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:kColor_Blue forState:UIControlStateSelected];
        [self setTitleColor:kColor_Black_Sub forState:UIControlStateNormal];
        self.titleLabel.font = kFont_15;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
//        self.titleLabel.backgroundColor = [UIColor redColor];
        
        
        
        CGSize size = CGSizeMake(9, 6);
        [self setImage:[self iconImageWithColor:kColor_Black_Sub size:size isStretch:NO] forState:UIControlStateNormal];
        
        [self setImage:[self iconImageWithColor:kColor_Blue size:size isStretch:YES] forState:UIControlStateSelected];
        
        self.line = [UIView new];
        [self addSubview:self.line];
        self.line.backgroundColor = kColor_Line;
    }
    return self;
}
- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    self.labelW = [title wg_widthWithFont:kFont_15 maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    [super setTitle:title forState:state];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    float lineH = [kFont_15 lineHeight];
    self.line.frame = CGRectMake(0, (CGRectGetHeight(self.frame)-lineH)/2.0, kLineHeight, lineH);
}
- (void)setHighlighted:(BOOL)highlighted {}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGSize size = self.currentImage.size;
    
    float imageX = (CGRectGetWidth(self.frame) - size.width + self.labelW+5)/2;
    float imageY = (CGRectGetHeight(self.frame) - size.width)/2.0;
    return (CGRect){imageX, imageY + 2, size};
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGRect imageF = [self imageRectForContentRect:CGRectZero];
    CGFloat titleX = CGRectGetMinX(imageF)-5-self.labelW;
    CGRect titleF = (CGRect){titleX,0,self.labelW,CGRectGetHeight(self.frame)};
    return titleF;
}

- (void)setIsStretch:(BOOL)isStretch {
    _isStretch = isStretch;
    self.selected = isStretch;
    
}

- (UIImage *)iconImageWithColor:(UIColor *)color size:(CGSize)size isStretch:(BOOL)isStretch {
    
//    CGSize size = CGSizeMake(12, 8);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    float offsexY = 0;
    if (isStretch) {
        offsexY = size.height;
    }
    CGPoint point1 = CGPointMake(0, offsexY);
    CGPoint point2 = CGPointMake(size.width, offsexY);
    CGPoint point3 = CGPointMake(size.width/2, size.height-offsexY);
    
    
    CGContextMoveToPoint(context, point1.x, point1.y);
    CGContextAddLineToPoint(context, point2.x, point2.y);
    CGContextAddLineToPoint(context, point3.x, point3.y);
    CGContextAddLineToPoint(context, point1.x, point1.y);
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    CGContextDrawPath(context, kCGPathFill);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
