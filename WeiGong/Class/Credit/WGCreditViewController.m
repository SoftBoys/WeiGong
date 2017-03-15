//
//  WGCreditViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/25.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGCreditViewController.h"
#import "WG_TableViewNormalHeader.h"
#import "WG_TableViewNormalFooter.h"

#import "WGCreditListItem.h"
#import "WGCreditListCell.h"

@interface WGCreditViewController ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger page;
@end

@implementation WGCreditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的信誉";
    self.sepLineColor = kClearColor;
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
    
}
- (void)wg_loadData {
    [self wg_loadDataWithPage:kDefaultPage];
}
- (void)wg_loadDataWithPage:(NSInteger)page {
    self.page = page;
    NSDictionary *param = @{@"pageNum":@(self.page), @"pageSize":@(15)};
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:[self requestUrl]];
    request.wg_parameters = param;
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        if (response.statusCode == 200) {
            if (self.page == kDefaultPage) {
                [self.dataArray removeAllObjects];
            }
            NSArray *items = response.responseJSON[@"items"];
            NSArray *listItems = [WGCreditListItem wg_modelArrayWithDictArray:items];
            [self.dataArray wg_addObjectsFromArray:listItems];
        }
        [self.tableView wg_reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}
#pragma mark - 代理方法
- (UITableViewCell *)wg_cellAtIndexPath:(NSIndexPath *)indexPath {
    WGCreditListItem *item = self.dataArray[indexPath.section];
    WGCreditListCell *cell = [WGCreditListCell wg_cellWithTableView:self.tableView];
    cell.item = item;
    return cell;
    return [super wg_cellAtIndexPath:indexPath];
}
- (NSInteger)wg_numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)wg_numberOfSections {
    return [self.dataArray count];
}
- (CGFloat)wg_sectionFooterHeightAtSection:(NSInteger)section {
    return 12;
}
- (void)wg_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(WG_BaseTableViewCell *)cell {
    
}

- (NSString *)requestUrl {
    return @"/linggb-ws/ws/0.1/person/getEvalById";
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}
@end
