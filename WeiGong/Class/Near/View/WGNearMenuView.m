//
//  WGNearMenuView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/3/7.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGNearMenuView.h"
#import "WG_DropDownMenu.h"

@interface WGNearMenuView () <WG_DropDownMenuDelegate, WG_DropDownMenuDataSource>
@property (nonatomic, strong) WG_DropDownMenu *menuView;
@property (nonatomic, assign) NSInteger distance;
@end
@implementation WGNearMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _menuDistanceList = @[@(2), @(3), @(5)];
        self.distance = [[self.menuDistanceList firstObject] integerValue];
        [self addSubview:self.menuView];
    }
    return self;
}

- (WG_DropDownMenu *)menuView {
    if (!_menuView) {
        CGFloat menuY = 0;
        CGFloat menuH = 35;
        WG_DropDownMenu *menuView = [WG_DropDownMenu dropDownWithoOrigin:CGPointMake(0, menuY) height:menuH];
        menuView.delegate = self;
        menuView.dataSource = self;
        
        _menuView = menuView;
    }
    return _menuView;
}

#pragma mark - WG_DropDownMenuDataSource
- (NSInteger)menu:(WG_DropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column {
    return self.menuDistanceList.count;
}
- (NSInteger)numberOfColumnsInMenu:(WG_DropDownMenu *)menu {
    return 1;
}
- (NSString *)menu:(WG_DropDownMenu *)menu titleForColumn:(NSInteger)column {
    
    return kStringAppend(kIntToStr(self.distance), @"km");
}
- (NSString *)menu:(WG_DropDownMenu *)menu titleForRow:(NSInteger)row inColumn:(NSInteger)column {
    return kStringAppend(self.menuDistanceList[row], @"km");
}
#pragma mark - WG_DropDownMenuDelegate
- (void)menu:(WG_DropDownMenu *)menu didSelectRow:(NSInteger)row inColumn:(NSInteger)column {
    NSInteger distance = [self.menuDistanceList[row] integerValue];
    self.distance = distance;
    [self.menuView reloadData];
    
    if (self.chooseDistanceHandle) {
        self.chooseDistanceHandle(distance);
    }
    
}
- (void)menu:(WG_DropDownMenu *)menu didSelectColumn:(NSInteger)column {
    
}
- (void)didTapCancel {
    
}

@end
