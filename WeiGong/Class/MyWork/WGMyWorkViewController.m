//
//  WGMyWorkViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/19.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGMyWorkViewController.h"
#import "WGMyWorkApplyParam.h"
#import "WGMyWorkApplyListItem.h"

#import "WGMyWorkApplyListCell.h"
#import "WGMyWorkArrangeListCell.h"

#import "WG_JobDetailViewController.h"
#import "WGMyWorkDetailViewController.h"

#import "WG_TableViewNormalHeader.h"
#import "WG_TableViewNormalFooter.h"

@interface WGMyWorkViewController ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger page;
/** 是否走的申请职位请求 */
@property (nonatomic, assign, readonly) BOOL isApplyRequest;
@end

@implementation WGMyWorkViewController
- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStylePlain];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsZero;
//    self.title = @"我的工作";
    
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
    NSString *url = [self requestUrl];
    id params = nil;
    if (self.isApplyRequest) {
        WGMyWorkApplyParam *applyParam = [WGMyWorkApplyParam new];
        applyParam.pageSize = 15;
        applyParam.pageNum = page;
        applyParam.postStatus = (self.status == 0)?1:3;
        params = applyParam;
    } else {
        WGMyWorkArrangeParam *arrangeParam = [WGMyWorkArrangeParam new];
        arrangeParam.pageSize = 15;
        arrangeParam.pageNum = page;
        arrangeParam.isHistory = (self.status == 3)?1:2;
        params = arrangeParam;
    }
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:url];
    request.wg_parameters = [params wg_keyValues];
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        if (response.statusCode == 200) {
//            WGLog(@"response:%@",response);
            if (self.page == kDefaultPage) {
                [self.dataArray removeAllObjects];
            }
            if (self.isApplyRequest) {
                NSArray *items = response.responseJSON[@"items"];
                NSArray *itemList = [WGMyWorkApplyListItem wg_modelArrayWithDictArray:items];
                [self.dataArray wg_addObjectsFromArray:itemList];
            } else {
                NSArray *items = response.responseJSON[@"items"];
                NSArray *itemList = [WGMyWorkArrangeListItem wg_modelArrayWithDictArray:items];
                [self.dataArray wg_addObjectsFromArray:itemList];
            }
            
            [self.tableView wg_reloadData];
            
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}
#pragma mark - 代理方法
- (UITableViewCell *)wg_cellAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isApplyRequest) {
        WGMyWorkApplyListItem *item = self.dataArray[indexPath.row];
        WGMyWorkApplyListCell *cell = [WGMyWorkApplyListCell wg_cellWithTableView:self.tableView];
        cell.item = item;
        return cell;
    } else {
        WGMyWorkArrangeListItem *item = self.dataArray[indexPath.row];
        WGMyWorkArrangeListCell *cell = [WGMyWorkArrangeListCell wg_cellWithTableView:self.tableView];
        cell.item = item;
        return cell;
    }
    return [super wg_cellAtIndexPath:indexPath];
}
- (UIEdgeInsets)wg_sepLineEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath {
    return UIEdgeInsetsZero;
}
- (NSInteger)wg_numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}

- (void)wg_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(WG_BaseTableViewCell *)cell {
    if (self.isApplyRequest) {
        WGMyWorkApplyListItem *item = self.dataArray[indexPath.row];
        WG_JobDetailViewController *jobVC = [WG_JobDetailViewController new];
        jobVC.jobId = kIntToStr(item.enterpriseJobId);
        [self wg_pushVC:jobVC];
        
    } else {
        WGMyWorkArrangeListItem *item = self.dataArray[indexPath.row];
        WGMyWorkDetailViewController *detailVC = [WGMyWorkDetailViewController new];
        detailVC.personalWorkId = item.personalWorkId;
        [self wg_pushVC:detailVC];
    }
}
#pragma mark - pravite
- (BOOL)isApplyRequest {
    return (self.status == 0||self.status == 1);
}
- (NSString *)requestUrl {
    NSString *url = self.isApplyRequest ? @"/linggb-ws/ws/0.1/person/jobManager_1.1":@"/linggb-ws/ws/0.1/person/arrangeJobFutureOrHistory";
    return url;
}
#pragma mark - getter && setter 
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}

@end
