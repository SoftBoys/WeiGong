//
//  JYRadarChart.m
//  JYRadarChart
//
//  Created by jy on 13-10-31.
//  Copyright (c) 2013年 wcode. All rights reserved.
//

#import "JYRadarChart.h"
#import "JYLegendView.h"

#define PADDING 13
#define LEGEND_PADDING 3
#define ATTRIBUTE_TEXT_SIZE 10
#define COLOR_HUE_STEP 5
#define MAX_NUM_OF_COLOR 17

@interface JYRadarChart ()

@property (nonatomic, assign) NSUInteger numOfV;
@property (nonatomic, strong) JYLegendView *legendView;
@property (nonatomic, strong) UIFont *scaleFont;
@property (nonatomic, strong) UIColor *textColor;
/** 圆的线条颜色 （默认grayColor） */
@property (nonatomic, strong) UIColor *scaleCircleLineColor;
/** 圆的线条宽度 （默认1.0） */
@property (nonatomic, strong) NSNumber *scaleCircleLineW;
/** 绘制线条的宽度 （默认1.0） */
@property (nonatomic, strong) NSNumber *scaleLineW;
/** 绘制小圆的实心或虚心 （默认NO） */
@property (nonatomic, strong) NSNumber *scaleFullCircle;
/** 0（默认样式） 1（旋转为水平模式）  */
@property (nonatomic, strong) NSNumber *scaleType;
@end

@implementation JYRadarChart

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
        [self setDefaultValues];
	}
	return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setDefaultValues];
    }
    return self;
}

- (void)setDefaultValues {
    self.backgroundColor = [UIColor whiteColor];
    _maxValue = 100.0;
    _centerPoint = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    _r = MIN(self.frame.size.width / 2 - PADDING, self.frame.size.height / 2 - PADDING);
    _steps = 1;
    _drawPoints = NO;
    _showLegend = NO;
    _showStepText = NO;
    _fillArea = NO;
    _minValue = 0;
    _colorOpacity = 1.0;
    _backgroundLineColorRadial = [UIColor darkGrayColor];
    _backgroundFillColor = [UIColor whiteColor];

    _legendView = [[JYLegendView alloc] init];
    _legendView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    _legendView.backgroundColor = [UIColor clearColor];
    _legendView.colors = [NSMutableArray array];
    _attributes = @[@"you", @"should", @"set", @"these", @"data", @"titles,",
                        @"this", @"is", @"just", @"a", @"placeholder"];

    _scaleFont = [UIFont systemFontOfSize:ATTRIBUTE_TEXT_SIZE];
    
    _textColor = [UIColor blackColor];
    
    _scaleCircleLineColor = [UIColor grayColor];
    
    _scaleCircleLineW = @(1.0);
    _scaleLineW = @(1.0);
    
    _scaleFullCircle = @(NO);
    
    _scaleType = @(0);
    
    _clockwise = YES;
}

- (void)setShowLegend:(BOOL)showLegend {
	_showLegend = showLegend;
	if (_showLegend) {
		[self addSubview:self.legendView];
	}
	else {
		for (UIView *subView in self.subviews) {
			if ([subView isKindOfClass:[JYLegendView class]]) {
				[subView removeFromSuperview];
			}
		}
	}
}

- (void)setTitles:(NSArray *)titles {
	self.legendView.titles = titles;
}

- (void)setColors:(NSArray *)colors {
    [self.legendView.colors removeAllObjects];
    for (UIColor *color in colors) {
        [self.legendView.colors addObject:[color colorWithAlphaComponent:self.colorOpacity]];
    }
}

- (void)setNeedsDisplay {
	[super setNeedsDisplay];
	[self.legendView sizeToFit];
	[self.legendView setNeedsDisplay];
}

- (void)setDataSeries:(NSArray *)dataSeries {
	_dataSeries = dataSeries;
	NSArray *arr = _dataSeries[0];
	_numOfV = [arr count];
	if (self.legendView.colors.count < _dataSeries.count) {
		for (int i = 0; i < _dataSeries.count; i++) {
			UIColor *color = [UIColor colorWithHue:1.0 * (i * COLOR_HUE_STEP % MAX_NUM_OF_COLOR) / MAX_NUM_OF_COLOR
			                            saturation:1
			                            brightness:1
			                                 alpha:self.colorOpacity];
			self.legendView.colors[i] = color;
		}
	}
}

- (void)layoutSubviews {
	[self.legendView sizeToFit];
	CGRect r = self.legendView.frame;
	r.origin.x = self.frame.size.width - self.legendView.frame.size.width - LEGEND_PADDING;
	r.origin.y = LEGEND_PADDING;
	self.legendView.frame = r;
	[self bringSubviewToFront:self.legendView];
}

- (void)drawRect:(CGRect)rect {
	NSArray *colors = [self.legendView.colors copy];
	CGFloat radPerV = M_PI * 2 / _numOfV;
    
    if (_clockwise) {
        radPerV =  - (M_PI * 2 / _numOfV);
    }
    else
    {
        radPerV = (M_PI * 2 / _numOfV);
    }
    
	CGContextRef context = UIGraphicsGetCurrentContext();
    
	//draw attribute text
	CGFloat height = [self.scaleFont lineHeight];
	CGFloat padding = 2.0;
    CGFloat needChangeRadPerV = 0;
    if ([_scaleType integerValue] == 1) {
        needChangeRadPerV = -radPerV/2.0;
    }
	for (int i = 0; i < _numOfV; i++) {
		NSString *attributeName = _attributes[i];
		CGPoint pointOnEdge = CGPointMake(_centerPoint.x - _r * sin(i * radPerV + needChangeRadPerV), _centerPoint.y - _r * cos(i * radPerV + needChangeRadPerV));
        
		CGSize attributeTextSize = JY_TEXT_SIZE(attributeName, self.scaleFont);
		NSInteger width = attributeTextSize.width;
        
		CGFloat xOffset = pointOnEdge.x >= _centerPoint.x ? width / 2.0 + padding : -width / 2.0 - padding;
		CGFloat yOffset = pointOnEdge.y >= _centerPoint.y ? height / 2.0 + padding : -height / 2.0 - padding;
		CGPoint legendCenter = CGPointMake(pointOnEdge.x + xOffset, pointOnEdge.y + yOffset);

        if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 70000) {
            NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
            [paragraphStyle setLineBreakMode:NSLineBreakByClipping];
            [paragraphStyle setAlignment:NSTextAlignmentCenter];

            NSDictionary *attributes = @{ NSFontAttributeName: self.scaleFont,
                                          NSForegroundColorAttributeName: self.textColor,
                                          NSParagraphStyleAttributeName: paragraphStyle };

            [attributeName drawInRect:CGRectMake(legendCenter.x - width / 2.0,
                                                 legendCenter.y - height / 2.0,
                                                 width,
                                                 height)
                       withAttributes:attributes];
        }
        else {
            [attributeName drawInRect:CGRectMake(legendCenter.x - width / 2.0,
                                                 legendCenter.y - height / 2.0,
                                                 width,
                                                 height)
                             withFont:self.scaleFont
                        lineBreakMode:NSLineBreakByClipping
                            alignment:NSTextAlignmentCenter];
        }
    }

    //draw background fill color
    [_backgroundFillColor setFill];
    CGContextMoveToPoint(context, _centerPoint.x, _centerPoint.y - _r);
    for (int i = 1; i <= _numOfV; ++i) {
        CGContextAddLineToPoint(context, _centerPoint.x - _r * sin(i * radPerV + needChangeRadPerV),
                                _centerPoint.y - _r * cos(i * radPerV + needChangeRadPerV));
    }
    CGContextFillPath(context);

	//draw steps line
	//static CGFloat dashedPattern[] = {3,3};
	//TODO: make this color a variable
	[[UIColor lightGrayColor] setStroke];
    [self.scaleCircleLineColor setStroke];

	CGContextSaveGState(context);
	for (int step = 1; step <= _steps; step++) {
		for (int i = 0; i <= _numOfV; ++i) {
			if (i == 0) {
//				CGContextMoveToPoint(context, _centerPoint.x, _centerPoint.y - _r * step / _steps);
                CGContextMoveToPoint(context, _centerPoint.x - _r * sin(i * radPerV + needChangeRadPerV) * step / _steps,
                                     _centerPoint.y - _r * cos(i * radPerV + needChangeRadPerV) * step / _steps);
			}
			else {
				//                CGContextSetLineDash(context, 0, dashedPattern, 2);
				CGContextAddLineToPoint(context, _centerPoint.x - _r * sin(i * radPerV + needChangeRadPerV) * step / _steps,
				                        _centerPoint.y - _r * cos(i * radPerV + needChangeRadPerV) * step / _steps);
			}
		}
		CGContextStrokePath(context);
	}
	CGContextRestoreGState(context);
    
	//draw lines from center
	[_backgroundLineColorRadial setStroke];
	for (int i = 0; i < _numOfV; i++) {
		CGContextMoveToPoint(context, _centerPoint.x, _centerPoint.y);
		CGContextAddLineToPoint(context, _centerPoint.x - _r * sin(i * radPerV + needChangeRadPerV),
		                        _centerPoint.y - _r * cos(i * radPerV + needChangeRadPerV));
		CGContextStrokePath(context);
	}
	//end of base except axis label
    
    
	CGContextSetLineWidth(context, [self.scaleLineW floatValue]);
    
	//draw lines
    if (_numOfV > 0) {
        for (int serie = 0; serie < [_dataSeries count]; serie++) {
            if (self.fillArea) {
                [colors[serie] setFill];
            }
            else {
                [colors[serie] setStroke];
            }
            for (int i = 0; i < _numOfV; ++i) {
                CGFloat value = [_dataSeries[serie][i] floatValue];
                if (i == 0) {
//                    CGContextMoveToPoint(context, _centerPoint.x, _centerPoint.y - (value - _minValue) / (_maxValue - _minValue) * _r);
                    CGContextMoveToPoint(context, _centerPoint.x - (value - _minValue) / (_maxValue - _minValue) * _r * sin(i * radPerV + needChangeRadPerV), _centerPoint.y - (value - _minValue) / (_maxValue - _minValue) * _r * cos(i * radPerV + needChangeRadPerV));
                }
                else {
                    CGContextAddLineToPoint(context, _centerPoint.x - (value - _minValue) / (_maxValue - _minValue) * _r * sin(i * radPerV + needChangeRadPerV),
                            _centerPoint.y - (value - _minValue) / (_maxValue - _minValue) * _r * cos(i * radPerV + needChangeRadPerV));
                }
            }
            int i = 0;
            CGFloat value = [_dataSeries[serie][i] floatValue];
//            CGContextAddLineToPoint(context, _centerPoint.x, _centerPoint.y - (value - _minValue) / (_maxValue - _minValue) * _r);
            CGContextAddLineToPoint(context, _centerPoint.x - (value - _minValue) / (_maxValue - _minValue) * _r * sin(i * radPerV + needChangeRadPerV), _centerPoint.y - (value - _minValue) / (_maxValue - _minValue) * _r * cos(i * radPerV + needChangeRadPerV));

            if (self.fillArea) {
                CGContextFillPath(context);
            }
            else {
                CGContextStrokePath(context);
            }


            //draw data points
            if (_drawPoints) {
                for (int i = 0; i < _numOfV; i++) {
                    CGFloat value = [_dataSeries[serie][i] floatValue];
                    CGFloat xVal = _centerPoint.x - (value - _minValue) / (_maxValue - _minValue) * _r * sin(i * radPerV + needChangeRadPerV);
                    CGFloat yVal = _centerPoint.y - (value - _minValue) / (_maxValue - _minValue) * _r * cos(i * radPerV+ needChangeRadPerV);

                    [colors[serie] setFill];
                    float circleW = 8.0;
                    float circleW2 = 6.0;
                    CGContextFillEllipseInRect(context, CGRectMake(xVal - circleW/2.0, yVal - circleW/2.0, circleW, circleW));
                    [self.backgroundColor setFill];
                    if (![_scaleFullCircle boolValue]) {
                        CGContextFillEllipseInRect(context, CGRectMake(xVal - circleW2/2, yVal - circleW2/2, circleW2, circleW2));
                    }
                }
            }
        }
    }
    
	if (self.showStepText) {
		//draw step label text, alone y axis
		//TODO: make this color a variable
		[[UIColor blackColor] setFill];
		for (int step = 0; step <= _steps; step++) {
			CGFloat value = _minValue + (_maxValue - _minValue) * step / _steps;
			NSString *currentLabel = [NSString stringWithFormat:@"%.0f", value];
			JY_DRAW_TEXT_IN_RECT(currentLabel,
			                     CGRectMake(_centerPoint.x + 3,
			                                _centerPoint.y - _r * step / _steps - 3,
			                                20,
			                                10),
			                     self.scaleFont);
		}
	}
}

@end
