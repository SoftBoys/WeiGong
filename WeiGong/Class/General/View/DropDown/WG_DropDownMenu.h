//
//  WG_DropDown.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/25.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WG_DropDownMenu;
@protocol WG_DropDownMenuDelegate <NSObject>

- (void)menu:(WG_DropDownMenu *)menu didSelectRow:(NSInteger)row inColumn:(NSInteger)column;

- (void)menu:(WG_DropDownMenu *)menu didSelectColumn:(NSInteger)column;
- (void)didTapCancel;

@end

@protocol WG_DropDownMenuDataSource <NSObject>

- (NSString *)menu:(WG_DropDownMenu *)menu titleForColumn:(NSInteger)column;
- (NSString *)menu:(WG_DropDownMenu *)menu titleForRow:(NSInteger)row inColumn:(NSInteger)column;

- (NSInteger)numberOfColumnsInMenu:(WG_DropDownMenu *)menu;
- (NSInteger)menu:(WG_DropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column;
@end

@interface WG_DropDownMenu : UIView
+ (instancetype)dropDownWithoOrigin:(CGPoint)origin height:(CGFloat)height;
@property (nonatomic, weak) id<WG_DropDownMenuDelegate> delegate;
@property (nonatomic, weak) id<WG_DropDownMenuDataSource> dataSource;
/** 背景蒙版颜色（默认黑色） */
@property (nonatomic, strong) UIColor *maskColor;
/** 刷新数据 */
- (void)reloadData;
@end
