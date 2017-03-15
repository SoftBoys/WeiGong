//
//  WG_BaseTableView.h
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/12.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WGBaseTableViewRowAnimation) {
    Fade = UITableViewRowAnimationFade,
    Right = UITableViewRowAnimationRight,
    Left = UITableViewRowAnimationLeft,
    Top = UITableViewRowAnimationTop,
    Bottom = UITableViewRowAnimationBottom,
    None = UITableViewRowAnimationNone,
    Middle = UITableViewRowAnimationMiddle,
    Automatic = UITableViewRowAnimationAutomatic
};

@interface WG_BaseTableView : UITableView

+ (instancetype)wg_tableView;
+ (instancetype)wg_tableViewWithStyle:(UITableViewStyle)style;
/** 注册普通Cell */
- (void)wg_registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier;
/** 注册HeaderFooterView */
- (void)wg_registerClass:(Class)aClass forHeaderFooterViewReuseIdentifier:(NSString *)identifier;
/** 获取 indexPath 的 cell */
- (UITableViewCell *)wg_cellAtIndexPath:(NSIndexPath *)indexPath;
#pragma mark - 刷新Cell
/** 刷新数据 */
- (void)wg_reloadData;
/** 刷新单行, 默认动画 */
- (void)wg_reloadSingleRowAtIndexPath:(NSIndexPath *)indexPath;
/** 刷新单行, 默认动画 */
- (void)wg_reloadSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(WGBaseTableViewRowAnimation)animation;
/** 刷新多行, 默认动画 */
- (void)wg_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;
/** 刷新多行, 默认动画 */
- (void)wg_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(WGBaseTableViewRowAnimation)animation;
/** 刷新单组, 默认动画 */
- (void)wg_reloadSingleSection:(NSInteger)section;
/** 刷新单组, 默认动画 */
- (void)wg_reloadSingleSection:(NSInteger)section animation:(WGBaseTableViewRowAnimation)animation;
/** 刷新多组, 默认动画 */
- (void)wg_reloadSections:(NSArray<NSNumber *> *)sections;
/** 刷新多组, 默认动画 */
- (void)wg_reloadSections:(NSArray<NSNumber *> *)sections animation:(WGBaseTableViewRowAnimation)animation;
#pragma mark - 删除Cell
/** 删除单行, 默认动画 */
- (void)wg_deleteSingleRowAtIndexPath:(NSIndexPath *)indexPath;
/** 删除单行, 默认动画 */
- (void)wg_deleteSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(WGBaseTableViewRowAnimation)animation;
/** 删除多行, 默认动画 */
- (void)wg_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;
/** 删除多行, 默认动画 */
- (void)wg_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(WGBaseTableViewRowAnimation)animation;
/** 删除单组, 默认动画 */
- (void)wg_deleteSingleSection:(NSInteger)section;
/** 删除单组, 默认动画 */
- (void)wg_deleteSingleSection:(NSInteger)section animation:(WGBaseTableViewRowAnimation)animation;
/** 删除多组, 默认动画 */
- (void)wg_deleteSections:(NSArray<NSNumber *> *)sections;
/** 删除多组, 默认动画 */
- (void)wg_deleteSections:(NSArray<NSNumber *> *)sections animation:(WGBaseTableViewRowAnimation)animation;
#pragma mark - 插入Cell
/** 插入单行, 默认动画 */
- (void)wg_insertSingleRowAtIndexPath:(NSIndexPath *)indexPath;
/** 插入单行, 默认动画 */
- (void)wg_insertSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(WGBaseTableViewRowAnimation)animation;
/** 插入多行, 默认动画 */
- (void)wg_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;
/** 插入多行, 默认动画 */
- (void)wg_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(WGBaseTableViewRowAnimation)animation;
/** 插入单组, 默认动画 */
- (void)wg_insertSingleSection:(NSInteger)section;
/** 插入单组, 默认动画 */
- (void)wg_insertSingleSection:(NSInteger)section animation:(WGBaseTableViewRowAnimation)animation;
/** 插入多组, 默认动画 */
- (void)wg_insertSections:(NSArray<NSNumber *> *)sections;
/** 插入多组, 默认动画 */
- (void)wg_insertSections:(NSArray<NSNumber *> *)sections animation:(WGBaseTableViewRowAnimation)animation;

@end
