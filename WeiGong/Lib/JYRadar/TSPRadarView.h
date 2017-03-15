//
//  TSPRadarView.h
//  雷达图Demo
//
//  Created by dfhb@rdd on 16/8/8.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "JYRadarChart.h"

@interface TSPRadarView : JYRadarChart
/** 标签字体 （默认14号字） */
@property (nonatomic, strong) UIFont *nameFont;
/** 标签颜色 （默认black） */
@property (nonatomic, strong) UIColor *nameColor;
/** 圆的线条颜色 （默认grayColor） */
@property (nonatomic, strong) UIColor *circleLineColor;
/** 圆的线条宽度 （默认1.0） */
@property (nonatomic, assign) float circleLineW;
/** 绘制线条的宽度 （默认1.0） */
@property (nonatomic, assign) float lineW;
/** 绘制线条连线之间为实心圆 （默认YES） */
@property (nonatomic, assign) BOOL showFullCircle;

/** 0（默认样式） 1（旋转为水平模式）  */
@property (nonatomic, assign) NSInteger type;

@end
