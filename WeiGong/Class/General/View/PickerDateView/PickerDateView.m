//
//  PickerDateView.m
//  ForceUpdate
//
//  Created by dfhb@rdd on 15/10/23.
//  Copyright © 2015年 GW. All rights reserved.
//

#import "PickerDateView.h"

@interface PickerDateView ()
@property (nonatomic, strong) BottomBackView *bottomView;
/**
 *  当前的item
 */
@property (nonatomic, strong) PickerDateItem *currentItem;
@end

@implementation PickerDateView
+ (instancetype)showPickerWithcurrentItem:(PickerDateItem *)currentItem {
    UIView *view = [[UIApplication sharedApplication].windows lastObject];
    PickerDateView *pickdate = [[PickerDateView alloc] initWithFrame:view.bounds];
    pickdate.currentItem = currentItem;
    pickdate.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    //    picker.backgroundColor = [UIColor redColor];
    [view addSubview:pickdate];
    return pickdate;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.设置BottomView
        self.pickH = 200;
        float bottomViewH = self.pickH;
        float bottomViewY = CGRectGetHeight(self.frame);
        float bottomViewW = CGRectGetWidth(self.frame);
        CGRect frameBottom = CGRectMake(0, bottomViewY, bottomViewW, bottomViewH);
        
        self.bottomView = [[BottomBackView alloc] initWithFrame:frameBottom];
        self.bottomView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.bottomView];
        
        self.showMask = YES;
    }
    return self;
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hiddenPicker];
}
- (void)setCurrentItem:(PickerDateItem *)currentItem {
    _currentItem = currentItem;
    if (_currentItem.currentDate == nil) {
        _currentItem.currentDate = [NSDate date];
    }
    self.bottomView.currentItem = _currentItem;
}
- (void)setShowMask:(BOOL)showMask {
    _showMask = showMask;
    if (_showMask) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    }
    else {
        self.backgroundColor = [UIColor clearColor];
    }
}
- (void)didMoveToSuperview {
    [self showPicker];
}
- (void)showPicker {
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomView.transform = CGAffineTransformMakeTranslation(0, -self.pickH);
    } completion:nil];
    
}
- (void)hiddenPicker {
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)setType:(DayType)type {
    _type = type;
    self.bottomView.type = type;
}
@end

@interface BottomBackView ()
@property (nonatomic, strong) UIDatePicker *datepicker;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIButton *sureButton;
@end

@implementation BottomBackView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 1.初始化Picker
        self.datepicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
        self.datepicker.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        // 设置语言
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        self.datepicker.locale = locale;
        // 设置时区
        [self.datepicker setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/beijing"]]; //北京时间
        self.datepicker.backgroundColor = [UIColor clearColor];
        
        // 设置UIDatePicker的显示模式
        [self.datepicker setDatePickerMode:UIDatePickerModeDate];
        [self.datepicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        [self addSubview:self.datepicker];
        
        
        // 2.初始化线条
        self.line = [[UIView alloc] initWithFrame:CGRectZero];
        self.line.backgroundColor = [UIColor colorWithRed:188/255.0 green:186/255.0 blue:193/255.0 alpha:1];
        [self addSubview:self.line];
        
        // 3.初始化按钮
        self.sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [self.sureButton addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
        [self.sureButton setTitleColor:[UIColor colorWithRed:34/255.0 green:136/255.0 blue:213/255.0 alpha:1] forState:UIControlStateNormal];
        [self addSubview:self.sureButton];
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 1.button的frame
    float buttonX = 0;
    float buttonH = 40;
    float buttonY = CGRectGetHeight(self.frame) - buttonH;
    float buttonW = CGRectGetWidth(self.frame);
    self.sureButton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    
    // 2.line的frame
    float lineX = 0;
    float lineH = 0.5;
    float lineY = CGRectGetMinY(self.sureButton.frame) - lineH;
    float lineW = CGRectGetWidth(self.frame);
    self.line.frame = CGRectMake(lineX, lineY, lineW, lineH);
    
    // 3.picker的frame
    float ty = (CGRectGetMinY(self.line.frame) - 216)*0.5;
    ty = 0;
    float pickerY = ty;
    float pickerX = 0;
    float pickerW = CGRectGetWidth(self.frame);
    float pickerH = CGRectGetMinY(self.line.frame) - ty;
    self.datepicker.frame = CGRectMake(pickerX, pickerY, pickerW, pickerH);
    
}
- (void)datePickerValueChanged:(UIDatePicker*)piker
{
    [piker setDate:piker.date animated:YES];
    self.currentItem.currentDate = piker.date;
}
- (void)setType:(DayType)type
{
    _type = type;
    if (_type == Type_YMD) {
        self.datepicker.datePickerMode = UIDatePickerModeDate;
    }
    else if (_type == Type_HM) {
        self.datepicker.datePickerMode = UIDatePickerModeTime;
    }
}
- (void)setCurrentItem:(PickerDateItem *)currentItem
{
    _currentItem = currentItem;
    if (_currentItem) {
        
        if (_currentItem.currentDate) {
            [self.datepicker setDate:_currentItem.currentDate animated:NO];
        }
        if (_currentItem.maxDate) {
            self.datepicker.maximumDate = _currentItem.maxDate;
        }
        if (_currentItem.minDate) {
            self.datepicker.minimumDate = _currentItem.minDate;
        }
    }
}
- (void)sureClick
{
    PickerDateView *pickView = (PickerDateView *)self.superview;
    if (pickView) {
        [pickView hiddenPicker];
        if (pickView.sureBlock) {
            pickView.sureBlock(self.currentItem);
        }
    }
}

@end