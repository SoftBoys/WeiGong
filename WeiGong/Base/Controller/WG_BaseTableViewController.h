//
//  WG_BaseTableViewController.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/12.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_BaseViewController.h"
#import "WG_BaseTableView.h"
#import "WG_BaseTableViewCell.h"

/** 初始化页码 */
#define kDefaultPage 0
@interface WG_BaseTableViewController : WG_BaseViewController
@property (nonatomic, strong, readonly) WG_BaseTableView *tableView;
/** 是否需要分割线 (默认显示) */
@property (nonatomic, assign) BOOL needCellSepLine;
/** 分割线的颜色 */
@property (nonatomic, strong) UIColor *sepLineColor;
/** 初始化 tableView 的样式 */
- (instancetype)initWithStyle:(UITableViewStyle)style;
#pragma mark - 需在子类中重写
/** 组数 */
- (NSInteger)wg_numberOfSections;
/** 某个组的行数 */
- (NSInteger)wg_numberOfRowsInSection:(NSInteger)section;
- (UIView *)wg_headerAtSection:(NSInteger)section;
- (UIView *)wg_footerAtSection:(NSInteger)section;
/** 设置 cell */
- (UITableViewCell *)wg_cellAtIndexPath:(NSIndexPath *)indexPath;
/** 设置行高 */
- (CGFloat)wg_rowHeightAtIndexPath:(NSIndexPath *)indexPath;
/** 设置 sectionHeader 的高 */
- (CGFloat)wg_sectionHeaderHeightAtSection:(NSInteger)section;
/** 设置 sectionFooter 的高 */
- (CGFloat)wg_sectionFooterHeightAtSection:(NSInteger)section;
/** 点击cell */
- (void)wg_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(WG_BaseTableViewCell *)cell;
/** 设置分割线偏移量 */
- (UIEdgeInsets)wg_sepLineEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath;
/** tableView时时滑动 */
- (void)wg_tableViewDidScroll:(WG_BaseTableView *)tableView;

@end

@interface WG_BaseTableViewController (EmptyView)

- (void)wg_startEmpty;

- (CGFloat)emptyOffsetY;

- (NSString *)emptyRemindText;

- (UIImage *)emptyIcon;

- (BOOL)emptyCanScroll;

- (void)didTapEmptyView;

@end

