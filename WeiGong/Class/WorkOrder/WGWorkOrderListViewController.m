//
//  WGWorkOrderListViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/23.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGWorkOrderListViewController.h"
#import "WGWorkOrderListCell.h"
#import "WGWorkOrderListParam.h"

#import "WGWorkOrderDetailViewController.h"

#import "WG_TableViewNormalHeader.h"
#import "WG_TableViewNormalFooter.h"

@interface WGWorkOrderListViewController ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger page;
@end

@implementation WGWorkOrderListViewController
- (CGFloat)emptyOffsetY {
    return -30;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsZero;
    
    __weak typeof(self) weakself = self;
    self.tableView.mj_header = [WG_TableViewNormalHeader headerWithRefreshingBlock:^{
        __strong typeof(weakself) strongself = weakself;
        [strongself wg_loadData];
    }];
    self.tableView.mj_footer = [WG_TableViewNormalFooter footerWithRefreshingBlock:^{
        __strong typeof(weakself) strongself = weakself;
        strongself.page ++;
        [strongself wg_loadDataWithPage:strongself.page];
    }];
    
//    WGLog(@"title:%@", self.title);
}
- (void)wg_loadData {
    [self wg_loadDataWithPage:kDefaultPage];
}
- (void)wg_loadDataWithPage:(NSInteger)page {
    self.page = page;
    
    WGWorkOrderListParam *param = [WGWorkOrderListParam new];
    param.orderFlag = self.orderFlag;
    param.pageNum = page;
    param.pageSize = 15;
    
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:[self requestUrl]];
    request.wg_parameters = [param wg_keyValues];
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        if (response.statusCode == 200) {
            if (self.page == kDefaultPage) {
                [self.dataArray removeAllObjects];
            }
            NSDictionary *data = response.responseJSON;
            if ([data isKindOfClass:[NSDictionary class]]) {
                NSArray *items = data[@"items"];
                NSArray *listItems = [WGWorkOrderListItem wg_modelArrayWithDictArray:items];
                [self.dataArray wg_addObjectsFromArray:listItems];
                [self.tableView wg_reloadData];
            }
        }
        if (self.dataArray.count == 0) {
            [MBProgressHUD wg_message:@"暂无相应订单"];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}
#pragma mark - 代理方法
- (UITableViewCell *)wg_cellAtIndexPath:(NSIndexPath *)indexPath {
    WGWorkOrderListItem *item = self.dataArray[indexPath.section];
    WGWorkOrderListCell *cell = [WGWorkOrderListCell wg_cellWithTableView:self.tableView];
    cell.item = item;
    return cell;
}
- (NSInteger)wg_numberOfSections {
    return [self.dataArray count];
}
- (NSInteger)wg_numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)wg_sectionHeaderHeightAtSection:(NSInteger)section {
    return 10;
}
- (void)wg_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(WG_BaseTableViewCell *)cell {
    WGWorkOrderListItem *item = self.dataArray[indexPath.section];
    
    WGWorkOrderDetailViewController *detailVC = [WGWorkOrderDetailViewController new];
    detailVC.listItem = item;
    [self wg_pushVC:detailVC];
}

#pragma mark - getter && setter
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}
- (NSString *)requestUrl {
    return @"/linggb-ws/ws/0.1/orderNew/personOrderList";
}
@end
