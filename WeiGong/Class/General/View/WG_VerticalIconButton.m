//
//  WG_VerticalIconButton.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/9.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_VerticalIconButton.h"

@interface WG_VerticalIconButton ()
@property (nonatomic, assign) CGFloat titleLabelH;
@end
@implementation WG_VerticalIconButton
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addObserver:self forKeyPath:@"titleLabel.font" options:NSKeyValueObservingOptionNew context:nil];
//        WGLog(@"log0----");
        self.titleLabel.font = kFont_15;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:kColor_Black forState:UIControlStateNormal];
//        WGLog(@"log1----");
    }
    return self;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"titleLabel.font"]) {
        UIFont *newFont = change[NSKeyValueChangeNewKey];
        self.titleLabelH = [newFont lineHeight];
//        WGLog(@"log2----%@", @(self.titleLabelH));
    }
}
- (void)setSpace:(CGFloat)space {
    _space = space;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGSize size = self.currentImage.size;
    float imageY = CGRectGetHeight(self.frame)/2.0 - size.height - self.space/2.0;
    float imageX = (CGRectGetWidth(self.frame)-size.width)/2.0;
    return (CGRect){imageX, imageY, size};
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
//    WGLog(@"log21212----");
    CGRect imageF = [self imageRectForContentRect:CGRectZero];
    float titleX = 0;
    float titleY = CGRectGetMaxY(imageF) + self.space;
    //    UILabel
    float titleW = CGRectGetWidth(self.frame);
    float titleH = CGRectGetHeight(self.frame)-titleY;
    titleH = self.titleLabelH;
//    titleW = contentRect.size.width;
//    titleX =  (CGRectGetWidth(self.frame) - titleW)/2.0;
    return (CGRect){titleX, titleY, titleW, titleH};
}
- (void)setHighlighted:(BOOL)highlighted {}
- (void)dealloc {
    [self removeObserver:self forKeyPath:@"titleLabel.font"];
}
@end
