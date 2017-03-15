//
//  WG_TimeViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/12.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_TimeViewController.h"
#import "WG_HomeCell.h"
#import "WG_HomeItem.h"
#import "WG_TableViewNormalFooter.h"
#import "WG_TableViewGifHeader.h"

#import "WG_JobDetailViewController.h"

@interface WG_TimeViewController ()
@property (nonatomic, copy) NSString *date_start;
@property (nonatomic, copy) NSString *date_stop;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger requestId;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end
@implementation WG_TimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationItem.title = @"";
    self.tableView.contentInset = UIEdgeInsetsMake(kTopBarHeight, 0, kTabBarHeight, 0);
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    
    __weak typeof(self) weakself = self;
    self.tableView.mj_header = [WG_TableViewGifHeader headerWithRefreshingBlock:^{
        weakself.page = 0;
        [weakself wg_downloadWithPage:weakself.page];
    }];
    self.tableView.mj_footer = [WG_TableViewNormalFooter footerWithRefreshingBlock:^{
        weakself.page ++;
        [weakself wg_downloadWithPage:weakself.page];
    }];
    
    self.date_start = @"20150101";
    self.date_stop = @"20161010";
    [self wg_downloadWithPage:self.page];
}
- (void)wg_downloadWithPage:(NSInteger)page {
    self.page = page;
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:@"/linggb-ws/ws/0.1/person/queryByTime"];
    request.wg_parameters = @{@"startDate":self.date_start,
                              @"stopDate":self.date_stop,
                              @"pageSize":@20,
                              @"pageNum":@(page)};
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        if (response.responseJSON) {
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                if (page == 0) {
                    [self.dataArray removeAllObjects];
                }
                NSArray *list = response.responseJSON[@"items"];
                if (list.count) {
                    NSArray<WG_HomeItem *> *items = [WG_HomeItem mj_objectArrayWithKeyValuesArray:list];
                    [self.dataArray addObjectsFromArray:items];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.tableView.mj_header endRefreshing];
                    if (list.count < 20) {
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    } else {
                        [self.tableView.mj_footer endRefreshing];
                    }
                    [self.tableView reloadData];
                });
            });
        }
    }];
    
}
#pragma mark - UITableViewDataSource
- (UITableViewCell *)wg_cellAtIndexPath:(NSIndexPath *)indexPath {
    WG_HomeCell *cell = [WG_HomeCell wg_cellWithTableView:self.tableView];
    cell.item = self.dataArray[indexPath.row];
    return cell;
}
- (NSInteger)wg_numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}
#pragma mark - UITableViewDelegate 
- (void)wg_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(WG_BaseTableViewCell *)cell {
    
    WG_HomeItem *item = self.dataArray[indexPath.row];
    WG_JobDetailViewController *detail = [WG_JobDetailViewController new];
    detail.homeItem = item;
    [self wg_pushVC:detail];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}
@end
