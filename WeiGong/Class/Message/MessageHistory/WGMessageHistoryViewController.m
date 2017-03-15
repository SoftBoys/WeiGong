//
//  WGMessageHistoryViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/26.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGMessageHistoryViewController.h"
#import "WGMessageHistoryViewController+More.h"
#import "WGMessageGroupCell.h"
#import "WGMessageHistoryListCell.h"

#import "WGChatViewController.h"

#import <EMSDK.h>

@interface WGMessageHistoryViewController ()
@property (nonatomic, strong) UISegmentedControl *segmentTitleView;

@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *groupArray;

@property (nonatomic, assign, readonly) BOOL isGroup;
@end

@implementation WGMessageHistoryViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.segmentTitleView.selectedSegmentIndex = 0;
    [self wg_loadData];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.segmentTitleView.selectedSegmentIndex = 0;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTitleView];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
    
}
- (void)setupTitleView {
    [self.navBar addSubview:self.segmentTitleView];
    
    [self.segmentTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(kStatusBarHeight/2);
    }];
}

- (void)wg_loadDataGroupList {
    
    [self.tableView wg_reloadData];
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:[self requestUrl]];
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        if (response.statusCode == 0) return ;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            if ([response.responseJSON isKindOfClass:[NSDictionary class]]) {
                [self.groupArray removeAllObjects];
                NSArray *group = response.responseJSON[@"group"];
                NSArray *items = [WGMessageGroupItem wg_modelArrayWithDictArray:group];
                [self.groupArray wg_addObjectsFromArray:items];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView wg_reloadData];
            });
            
        });
        
        
        
        
    }];
    
}

- (void)wg_loadData {
    
    [self.tableView wg_reloadData];
    
    [self loadEaseDataWithCompletionHandle:^(NSArray<WGMessageHistoryListItem *> *list) {
        self.dataArray = list;
        [self.tableView wg_reloadData];
    }];
    
    
}
#pragma mark - 代理方法
- (UITableViewCell *)wg_cellAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isGroup) {
        WGMessageGroupItem *item = self.groupArray[indexPath.row];
        WGMessageGroupCell *cell = [WGMessageGroupCell wg_cellWithTableView:self.tableView];
        cell.item = item;
        return cell;
    } else {
        WGMessageHistoryListItem *item = self.dataArray[indexPath.row];
        WGMessageHistoryListCell *cell = [WGMessageHistoryListCell wg_cellWithTableView:self.tableView];
        cell.item = item;
        return cell;
    }
    return [super wg_cellAtIndexPath:indexPath];
}
- (NSInteger)wg_numberOfRowsInSection:(NSInteger)section {
    if (self.isGroup) {
        return [self.groupArray count];
    } else {
        return [self.dataArray count];
    }
}
- (UIEdgeInsets)wg_sepLineEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath {
    return UIEdgeInsetsZero;
}
- (void)wg_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(WG_BaseTableViewCell *)cell {
    
    if (self.isGroup) {
        WGMessageGroupItem *item = self.groupArray[indexPath.row];
        WGChatViewController *chatVC = [WGChatViewController wg_chatWithChatter:item.groupid];
        chatVC.title = item.groupname;
        [self wg_pushVC:chatVC];
    } else {
        WGMessageHistoryListItem *item = self.dataArray[indexPath.row];
        WGChatViewController *chatVC = [WGChatViewController wg_chatWithChatter:item.groupID];
        chatVC.title = item.name;
        [self wg_pushVC:chatVC];
    }
    
}

#pragma mark - private

- (UISegmentedControl *)segmentTitleView {
    if (!_segmentTitleView) {
        NSArray *items = @[@"消息",@"咨询组"];
        UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:items];
        
        [segment setTitleTextAttributes:@{NSFontAttributeName:kFont(16),NSForegroundColorAttributeName:kColor_Black} forState:UIControlStateNormal];
        [segment setTitleTextAttributes:@{NSFontAttributeName:kFont(16),NSForegroundColorAttributeName:kWhiteColor} forState:UIControlStateSelected];
        
        segment.tintColor = kColor_Blue;
        segment.backgroundColor = kClearColor;
//        [segment addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
        __weak typeof(self) weakself = self;
        [segment setBlockForControlEvents:UIControlEventValueChanged block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            if ([strongself isGroup]) {
                [strongself wg_loadDataGroupList];
            } else {
                [strongself wg_loadData];
            }
        }];
        segment.selectedSegmentIndex = 0;
        _segmentTitleView = segment;
    }
    return _segmentTitleView;
}
- (BOOL)isGroup {
    return self.segmentTitleView.selectedSegmentIndex == 1;
}
- (NSString *)requestUrl {
    return @"/linggb-ws/ws/0.1/person/getJoinGroups";
}

- (NSMutableArray *)groupArray {
    if (!_groupArray) {
        _groupArray = @[].mutableCopy;
    }
    return _groupArray;
}
@end
