//
//  WG_CollectViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/21.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_CollectViewController.h"
#import "WG_JobDetailViewController.h"
#import "WG_TableViewGifHeader.h"
#import "WG_TableViewNormalFooter.h"

#import "WG_HomeItem.h"
#import "WG_HomeCell.h"

@interface WG_CollectViewController ()
@property (nonatomic, assign) NSUInteger requestId;
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end
@implementation WG_CollectViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收藏";
    
    __weak typeof(self) weakself = self;
    self.tableView.mj_header = [WG_TableViewGifHeader headerWithRefreshingBlock:^{
        [weakself wg_loadDataWithPage:kDefaultPage];
    }];
    self.tableView.mj_footer = [WG_TableViewNormalFooter footerWithRefreshingBlock:^{
        weakself.page ++;
        [weakself wg_loadDataWithPage:weakself.page];
    }];

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self wg_loadData];
}
- (void)wg_loadData {
    [self wg_loadDataWithPage:kDefaultPage];
}
- (void)wg_loadDataWithPage:(NSInteger)page {
    
    self.page = page;
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:self.requestUrl];
    request.wg_parameters = @{@"pageNum": @(page), @"pageSize":@15};
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        WGLog(@"收藏列表数据");
        if (response.responseJSON) {
            if (self.page == 0) {
                [self.dataArray removeAllObjects];
            }
            
            NSArray *items = response.responseJSON[@"items"];
            if ([items isKindOfClass:[NSArray class]] && items.count) {
                NSArray *homeItems = [WG_HomeItem mj_objectArrayWithKeyValuesArray:items];
                [self.dataArray addObjectsFromArray:homeItems];
            }
            
            [self.tableView reloadData];
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
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
    return self.dataArray.count;
}
#pragma mark - UITableViewDelegate
- (void)wg_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(WG_BaseTableViewCell *)cell {
    
    WG_HomeItem *item = self.dataArray[indexPath.row];
    if (item) {        
        WG_JobDetailViewController *jobDetailVC = [WG_JobDetailViewController new];
        jobDetailVC.homeItem = item;
        [self wg_pushVC:jobDetailVC];
    }
    
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
- (NSString *)requestUrl {
    return @"/linggb-ws/ws/0.1/person/showFavorite";
}
@end
