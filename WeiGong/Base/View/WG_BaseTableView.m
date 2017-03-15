//
//  WG_BaseTableView.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/12.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_BaseTableView.h"

@implementation WG_BaseTableView

+ (instancetype)wg_tableView {
    return [self wg_tableViewWithStyle:UITableViewStyleGrouped];
}
+ (instancetype)wg_tableViewWithStyle:(UITableViewStyle)style {
    WG_BaseTableView *tableView = [[WG_BaseTableView alloc] initWithFrame:CGRectZero style:style];
    return tableView;
}

- (void)wg_registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier {
    if (cellClass && identifier.length) {
        [self registerClass:cellClass forCellReuseIdentifier:identifier];
    } else {
        NSLog(@"注册Cell[%@]失败", NSStringFromClass(cellClass));
    }
}

- (void)wg_registerClass:(Class)aClass forHeaderFooterViewReuseIdentifier:(NSString *)identifier {
    if (aClass && identifier.length) {
        [self registerClass:aClass forHeaderFooterViewReuseIdentifier:identifier];
    }
}

- (UITableViewCell *)wg_cellAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath == nil) {
        return nil;
    }
    NSInteger sectionNumber = [self numberOfSections];
    NSInteger section = indexPath.section;
    NSInteger rowNumber = [self numberOfRowsInSection:section];
    
    if (indexPath.section + 1 >= sectionNumber || section < 0) {
        NSLog(@"section:%ld 越界, 总数组:%ld", section, sectionNumber);
        return nil;
    } else if (indexPath.row + 1 >= rowNumber || indexPath.row < 0) {
        NSLog(@"row:%ld 越界, 总行数:%ld, 所在section:%ld", indexPath.row, rowNumber, section);
        return nil;
    }
    
    return [self cellForRowAtIndexPath:indexPath];
}
#pragma mark - 刷新
- (void)wg_reloadData {
    [self reloadData];
}
/** 刷新单行 */
- (void)wg_reloadSingleRowAtIndexPath:(NSIndexPath *)indexPath {
    [self wg_reloadSingleRowAtIndexPath:indexPath animation:None];
}
- (void)wg_reloadSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(WGBaseTableViewRowAnimation)animation {
    if (!indexPath) return ;
    NSInteger sectionNumber = self.numberOfSections;
    NSInteger section = indexPath.section;
    NSInteger rowNumber = [self numberOfRowsInSection:section];
    if (indexPath.section + 1 > sectionNumber || indexPath.section < 0) { // section 越界
        NSLog(@"刷新section: %ld 已经越界, 总组数: %ld", indexPath.section, sectionNumber);
    } else if (indexPath.row + 1 > rowNumber || indexPath.row < 0) { // row 越界
        NSLog(@"刷新row: %ld 已经越界, 总行数: %ld 所在section: %ld", indexPath.row, rowNumber, section);
    } else {
        [self beginUpdates];
        [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }
}
- (void)wg_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self wg_reloadRowsAtIndexPaths:indexPaths animation:None];
}
- (void)wg_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(WGBaseTableViewRowAnimation)animation {
    
    __weak typeof(self) weakself = self;
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSIndexPath class]]) {
            [weakself wg_reloadSingleRowAtIndexPath:obj animation:animation];
        }
    }];
}
- (void)wg_reloadSingleSection:(NSInteger)section {
    [self wg_reloadSingleSection:section animation:None];
}
- (void)wg_reloadSingleSection:(NSInteger)section animation:(WGBaseTableViewRowAnimation)animation {
    NSInteger sectionNumber = self.numberOfSections;
    if (section + 1 > sectionNumber || section < 0) { // section越界
        NSLog(@"刷新section: %ld 已经越界, 总组数: %ld", section, sectionNumber);
    } else {
        [self beginUpdates];
        [self reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }
}
- (void)wg_reloadSections:(NSArray<NSNumber *> *)sections {
    [self wg_reloadSections:sections animation:None];
}
- (void)wg_reloadSections:(NSArray<NSNumber *> *)sections animation:(WGBaseTableViewRowAnimation)animation {
    if (sections.count == 0) {
        return;
    }
    __weak typeof(self) weakself = self;
    [sections enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            [weakself wg_reloadSingleSection:obj.integerValue animation:animation];
        }
    }];
}
#pragma mark - 删除
- (void)wg_deleteSingleRowAtIndexPath:(NSIndexPath *)indexPath {
    [self wg_deleteSingleRowAtIndexPath:indexPath animation:None];
}
- (void)wg_deleteSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(WGBaseTableViewRowAnimation)animation {
    if (!indexPath) return ;
    NSInteger sectionNumber = self.numberOfSections;
    NSInteger section = indexPath.section;
    NSInteger rowNumber = [self numberOfRowsInSection:section];
    if (indexPath.section + 1 > sectionNumber || indexPath.section < 0) { // section 越界
        NSLog(@"删除section: %ld 已经越界, 总组数: %ld", indexPath.section, sectionNumber);
    } else if (indexPath.row + 1 > rowNumber || indexPath.row < 0) { // row 越界
        NSLog(@"删除row: %ld 已经越界, 总行数: %ld 所在section: %ld", indexPath.row, rowNumber, section);
    } else {
        [self beginUpdates];
        [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }
}
- (void)wg_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self wg_deleteRowsAtIndexPaths:indexPaths animation:None];
}
- (void)wg_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(WGBaseTableViewRowAnimation)animation {
    
    __weak typeof(self) weakself = self;
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSIndexPath class]]) {
            [weakself wg_deleteSingleRowAtIndexPath:obj animation:animation];
        }
    }];
}
- (void)wg_deleteSingleSection:(NSInteger)section {
    [self wg_deleteSingleSection:section animation:None];
}
- (void)wg_deleteSingleSection:(NSInteger)section animation:(WGBaseTableViewRowAnimation)animation {
    NSInteger sectionNumber = self.numberOfSections;
    if (section + 1 > sectionNumber || section < 0) { // section越界
        NSLog(@"删除section: %ld 已经越界, 总组数: %ld", section, sectionNumber);
    } else {
        [self beginUpdates];
        [self deleteSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }
}
- (void)wg_deleteSections:(NSArray<NSNumber *> *)sections {
    [self wg_deleteSections:sections animation:None];
}
- (void)wg_deleteSections:(NSArray<NSNumber *> *)sections animation:(WGBaseTableViewRowAnimation)animation {
    if (sections.count == 0) {
        return;
    }
    __weak typeof(self) weakself = self;
    [sections enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            [weakself wg_deleteSingleSection:obj.integerValue animation:animation];
        }
    }];
}
#pragma mark - 插入
- (void)wg_insertSingleRowAtIndexPath:(NSIndexPath *)indexPath {
    [self wg_insertSingleRowAtIndexPath:indexPath animation:None];
}
- (void)wg_insertSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(WGBaseTableViewRowAnimation)animation {
    if (!indexPath) return ;
    NSInteger sectionNumber = self.numberOfSections;
    NSInteger section = indexPath.section;
    NSInteger rowNumber = [self numberOfRowsInSection:section];
    if (indexPath.section > sectionNumber || section < 0) { // section 越界
        NSLog(@"section: %ld 已经越界, 总组数: %ld", indexPath.section, sectionNumber);
    } else if (indexPath.row > rowNumber || indexPath.row < 0) { // row 越界
        NSLog(@"row: %ld 已经越界, 总行数: %ld 所在section: %ld", indexPath.row, rowNumber, section);
    } else {
        [self beginUpdates];
        [self insertRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }
}
- (void)wg_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self wg_insertRowsAtIndexPaths:indexPaths animation:None];
}
- (void)wg_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(WGBaseTableViewRowAnimation)animation {
    
    __weak typeof(self) weakself = self;
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSIndexPath class]]) {
            [weakself wg_insertSingleRowAtIndexPath:obj animation:animation];
        }
    }];
}
- (void)wg_insertSingleSection:(NSInteger)section {
    [self wg_insertSingleSection:section animation:None];
}
- (void)wg_insertSingleSection:(NSInteger)section animation:(WGBaseTableViewRowAnimation)animation {
    NSInteger sectionNumber = self.numberOfSections;
    if (section > sectionNumber || section < 0) { // section越界
        NSLog(@"插入section: %ld 已经越界, 总组数: %ld", section, sectionNumber);
    } else {
        [self beginUpdates];
        [self insertSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }
}
- (void)wg_insertSections:(NSArray<NSNumber *> *)sections {
    [self wg_insertSections:sections animation:None];
}
- (void)wg_insertSections:(NSArray<NSNumber *> *)sections animation:(WGBaseTableViewRowAnimation)animation {
    if (sections.count == 0) {
        return;
    }
    __weak typeof(self) weakself = self;
    [sections enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            [weakself wg_insertSingleSection:obj.integerValue animation:animation];
        }
    }];
}

/** 当有输入框的时候 点击tableview空白处，隐藏键盘*/
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    id view = [super hitTest:point withEvent:event];
    if (![view isKindOfClass:[UITextField class]]) {
        [self endEditing:YES];
    }
    return view;
}

@end
