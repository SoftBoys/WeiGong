//
//  WGStepView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/21.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGStepView.h"
#import "WGBaseButton.h"

@interface WGStepView ()
@property (nonatomic, strong) NSMutableArray *buttonList;
@property (nonatomic, strong) UIView *line;
@end
@implementation WGStepView
+ (instancetype)stepViewWithTitles:(NSArray<NSString *> *)titles {
    CGRect frame = CGRectMake(0, 0, kScreenWidth, 35);
    WGStepView *step = [[[self class] alloc] initWithFrame:frame];
    step.titles = titles;
    return step;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.buttonList = @[].mutableCopy;
        _titleFont = kFont(13);
        
        _colorNor = kColor_Gray_Sub;
        _colorSel = kColor_Blue;
        _colorLine = kColor_Line;
        
    }
    return self;
}
- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    if (_currentIndex >= self.buttonList.count) _currentIndex = 0;
    if (self.buttonList.count) {
        for (NSInteger i = 0; i < self.buttonList.count; i++) {
            UIButton *button = self.buttonList[i];
            button.selected = NO;
            if (i == _currentIndex) {
                button.selected = YES;
            }
            
        }
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    for (UIView *subview in self.subviews) {
        subview.wg_centerY = self.wg_height/2.0;
    }
    self.line.frame = CGRectMake(0, self.wg_height-kLineHeight, self.wg_width, kLineHeight);
}
- (void)setColorLine:(UIColor *)colorLine {
    _colorLine = colorLine;
    self.line.backgroundColor = _colorLine;
}
- (void)setTitles:(NSArray<NSString *> *)titles {
    [self.buttonList removeAllObjects];
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }

    _titles = titles;
    if (_titles.count == 0) return;
    
    NSInteger count = titles.count;
    CGFloat arrowW = 6;
    CGFloat arrowH = 12;
    UIImage *arrowImage = [UIImage wg_arrowImageWithColor:kColor_Gray_Sub size:CGSizeMake(arrowW, arrowH) arrowType:WGArrowImageTypeRight];
    
    CGFloat buttonW = (kScreenWidth-arrowW*(count-1))/count;
    CGFloat buttonH = self.wg_height;
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    CGFloat arrowY = (buttonH-arrowH)/2;
    CGFloat arrowX = 0;
    for (NSInteger i = 0; i < count; i++) {
        UIImage *image_nor = [self imageWithStepIndex:i+1 isSelect:NO];
        UIImage *image_sel = [self imageWithStepIndex:i+1 isSelect:YES];
        UIButton *button = [self buttonWithTitle:titles[i] image_nor:image_nor image_sel:image_sel];
        buttonX = i * (buttonW + arrowW);
        button.frame = (CGRect){buttonX, buttonY, buttonW, buttonH};
        button.selected = NO;
        if (i == self.currentIndex) {
            button.selected = YES;
        }
        [self addSubview:button];
        [self.buttonList addObject:button];
        if (i < count-1) {
            arrowX = CGRectGetMaxX(button.frame);
            UIImageView *arrowView = [self arrowViewWithArrow:arrowImage];
            arrowView.frame = (CGRect){arrowX, arrowY, arrowW, arrowH};
            [self addSubview:arrowView];
        }
        
    }
    self.line.backgroundColor = self.colorLine;
    [self addSubview:self.line];
}
- (UIImageView *)arrowViewWithArrow:(UIImage *)arrow {
    UIImageView *arrowView = [UIImageView new];
    arrowView.image = arrow;
//    arrowView.backgroundColor = kRedColor;
    return arrowView;
}
- (UIButton *)buttonWithTitle:(NSString *)title image_nor:(UIImage *)image_nor image_sel:(UIImage *)image_sel {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image_nor forState:UIControlStateNormal];
    [button setImage:image_sel forState:UIControlStateSelected];
    [button setTitleColor:_colorNor forState:UIControlStateNormal];
    [button setTitleColor:_colorSel forState:UIControlStateSelected];
    button.titleLabel.font = _titleFont;
    [button setTitle:title forState:UIControlStateNormal];
    CGFloat offsetLeft = 3;
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -offsetLeft, 0, offsetLeft);
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.adjustsImageWhenHighlighted = NO;
    button.userInteractionEnabled = NO;
    return button;
}

- (void)buttonClick:(UIButton *)button {
//    button.selected = !button.isSelected;
}
- (UIImage *)imageWithStepIndex:(NSInteger)index isSelect:(BOOL)isSelect {
    UIFont *font = kFont(14);
    UIColor *textColor = kWhiteColor;
    UIColor *backColor = isSelect ? _colorSel:_colorNor;
    CGFloat width = 16;
    UILabel *label = [UILabel wg_labelWithFont:font textColor:textColor textAlignment:NSTextAlignmentCenter];
    label.backgroundColor = backColor;
    label.text = kIntToStr(index);
    label.wg_size = CGSizeMake(width, width);
    return [[UIImage wg_imageWithView:label] wg_circleImage];
}


- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
//        _line.backgroundColor = kColor_Line;
    }
    return _line;
}
@end
