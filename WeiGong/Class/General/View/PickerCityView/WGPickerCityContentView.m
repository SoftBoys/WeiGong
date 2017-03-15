//
//  WGPickerCityContentView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/10.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGPickerCityContentView.h"
#import "WGPickerCityView.h"

@interface WGPickerCityContentView () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) UIView *line;

@property (nonatomic, assign) NSInteger cityIndex;
@property (nonatomic, assign) NSInteger subcityIndex;

@end
@implementation WGPickerCityContentView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.pickerView];
        [self addSubview:self.sureButton];
        [self addSubview:self.line];
        [self wg_setupFrame];
    }
    return self;
}
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self wg_setupFrame];
}
- (void)wg_setupFrame {
    CGFloat sureW = 80,sureH = 40;
    CGFloat sureX = self.wg_width - sureW;
    self.sureButton.frame = CGRectMake(sureX, 0, sureW, sureH);
    self.line.frame = CGRectMake(0, self.sureButton.wg_bottom, self.wg_width, kLineHeight);
    CGFloat pickerH = 162;
    self.pickerView.frame = CGRectMake(0, self.line.wg_bottom, self.wg_width, pickerH);
}
- (void)setCityItems:(NSArray<WGPickerCityItem *> *)cityItems {
    _cityItems = [cityItems copy];
    if (_cityItems) {
        
        __block NSInteger index = 0;
        [_cityItems enumerateObjectsUsingBlock:^(WGPickerCityItem * _Nonnull cityItem, NSUInteger idx, BOOL * _Nonnull stop) {
            if (cityItem.cityCode == self.currentCityItem.cityCode) {
                index = idx;
            }
        }];
        self.cityIndex = index;
        self.subcityIndex = self.currentCityItem.index_sel;
        
        WGPickerCityItem *cityItem = [_cityItems wg_objectAtIndex:self.cityIndex];
        cityItem.index_sel = self.subcityIndex;
        self.currentCityItem = cityItem;
        
        [self.pickerView reloadAllComponents];
        
        [self.pickerView selectRow:index inComponent:0 animated:NO];
        [self.pickerView selectRow:self.subcityIndex inComponent:1 animated:NO];
        
        
    }
}
#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
//    if (self.cityItems.count) {
//        WGPickerCityItem *cityItem = self.cityItems[self.cityIndex];
//        if (cityItem.subItems.count) {
//            return 2;
//        }
//        return 1;
//    }
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.cityItems.count;
    } else if (component == 1) {
        WGPickerCityItem *cityItem = [self.cityItems wg_objectAtIndex:self.cityIndex];
        return cityItem.subItems.count;
    } else {
        return 0;
    }
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 35;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    if (view == nil) {
        UILabel *label = [UILabel wg_labelWithFont:kFont(15) textColor:kBlackColor];
        label.textAlignment = NSTextAlignmentCenter;
        view = label;
    }
    UILabel *label = (UILabel *)view;
    
    NSString *title = nil;
    if (component == 0) {
        WGPickerCityItem *cityItem = [self.cityItems wg_objectAtIndex:row];
        title = cityItem.city;
    } else if (component == 1) {
        WGPickerCityItem *cityItem = [self.cityItems wg_objectAtIndex:self.cityIndex];
        WGPickerCityItem *subcityItem = cityItem.subItems[row];
        title = subcityItem.city;
    }
    label.text = title;
    
    return view;
}
#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.cityIndex = row;
        self.subcityIndex = 0;
    } else if (component == 1) {
        self.subcityIndex = row;
    }
    
    WGPickerCityItem *cityItem = [self.cityItems wg_objectAtIndex:self.cityIndex];
    cityItem.index_sel = self.subcityIndex;
    self.currentCityItem = cityItem;
    
    
    [self.pickerView reloadAllComponents];
    if (self.cityIndex < self.cityItems.count) {
        [self.pickerView selectRow:self.cityIndex inComponent:0 animated:NO];
    }
    if (self.subcityIndex < cityItem.subItems.count) {
        [self.pickerView selectRow:self.subcityIndex inComponent:1 animated:NO];
    }
    
    
    
    //    CityItem *item_city = self.items[row];
}

#pragma mark - 完成
- (void)sureClick {
    __weak typeof(self) weakself = self;
    if (self.sureHandle) {
        self.sureHandle(weakself.currentCityItem);
    }
    
}
#pragma mark - getter && setter 
- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.showsSelectionIndicator = YES;
    }
    return _pickerView;
}
- (UIButton *)sureButton {
    if (!_sureButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = kFont(16);
        [button setTitleColor:kColor_Blue forState:UIControlStateNormal];
        [button setTitleColor:kColor_Blue forState:UIControlStateSelected];
        [button setTitle:@"完成" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
        _sureButton = button;
    }
    return _sureButton;
}
- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = kColor_Line;
    }
    return _line;
}

@end
