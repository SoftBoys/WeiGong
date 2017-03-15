//
//  TSPRadarView.m
//  雷达图Demo
//
//  Created by dfhb@rdd on 16/8/8.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "TSPRadarView.h"

@implementation TSPRadarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaultData];
    }
    return self;
}

- (void)setDefaultData {
    
    self.backgroundColor = [UIColor whiteColor];
    self.minValue = 0;
    self.maxValue = 5;
//    self.dataSeries = @[a1];
    self.colorOpacity = 1.0;
    self.drawPoints = YES;
    self.r = 80;
    self.steps = 5;
    self.showStepText = NO;
    
    
    NSMutableArray *colors = [NSMutableArray arrayWithArray: @[[UIColor orangeColor]]];
    [self setValue:colors forKeyPath:@"legendView.colors"];
    
    self.nameFont = [UIFont systemFontOfSize:14];
    self.nameColor = [UIColor blackColor];
    self.showFullCircle = YES; // 显示小圆圈为实心
    self.circleLineW = 1.0;
    self.lineW = 1.0;
    self.circleLineColor = [UIColor lightGrayColor];
    self.backgroundLineColorRadial = [UIColor lightGrayColor];
    self.clockwise = YES; // 是否为顺时针方向
    
    self.type = 0;
}

- (void)setNameFont:(UIFont *)nameFont {
    [self setValue:nameFont forKey:@"scaleFont"];
}

- (void)setNameColor:(UIColor *)nameColor {
    [self setValue:nameColor forKey:@"textColor"];
}

- (void)setCircleLineColor:(UIColor *)circleLineColor {
    [self setValue:circleLineColor forKey:@"scaleCircleLineColor"];
}
- (void)setCircleLineW:(float)circleLineW {
    [self setValue:[NSNumber numberWithFloat:circleLineW] forKey:@"scaleCircleLineW"];
}
- (void)setLineW:(float)lineW {
    [self setValue:[NSNumber numberWithFloat:lineW] forKey:@"scaleLineW"];
}

- (void)setShowFullCircle:(BOOL)showFullCircle {
    [self setValue:[NSNumber numberWithBool:showFullCircle] forKey:@"scaleFullCircle"];
}
- (void)setType:(NSInteger)type {
    [self setValue:[NSNumber numberWithInteger:type] forKey:@"scaleType"];
}
@end
