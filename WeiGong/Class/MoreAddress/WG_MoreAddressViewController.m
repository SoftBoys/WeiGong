//
//  WG_MoreAddressViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/9.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_MoreAddressViewController.h"
#import "WG_JobDetail.h"
#import "WG_MoreAddressCell.h"

#import "WG_TrafficPathViewController.h"

@implementation WG_MoreAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更多工作地点";
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 45;
}
#pragma mark - UITableViewDataSource
- (UITableViewCell *)wg_cellAtIndexPath:(NSIndexPath *)indexPath {
    WG_JobAddressItem *item = self.joblist[indexPath.row];
    WG_MoreAddressCell *cell = [WG_MoreAddressCell wg_cellWithTableView:self.tableView];
    cell.item = item;
    return cell;
}
- (NSInteger)wg_numberOfRowsInSection:(NSInteger)section {
    return [self.joblist count];
}
#pragma mark - UITableViewDelegate
- (void)wg_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(WG_BaseTableViewCell *)cell {
    WG_JobAddressItem *item = self.joblist[indexPath.row];
    WG_TrafficPathViewController *traffic = [WG_TrafficPathViewController new];
    traffic.item = item;
    [self wg_pushVC:traffic];
}
@end
