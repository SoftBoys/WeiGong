//
//  WGClassDetailViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/16.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGClassDetailViewController.h"
#import "WG_JobDetailViewController.h"

#import "WGClassHeadView.h"
#import "WG_HomeCell.h"
#import "WG_HomeItem.h"
#import "WGHomeParam.h"
#import "WG_CityItem.h"

#import "WG_TableViewNormalHeader.h"
#import "WG_TableViewNormalFooter.h"

@interface WGClassDetailViewController ()
@property (nonatomic, strong) WGClassHeadView *headView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UIButton *scrollToTopButton;
@property (nonatomic, assign) NSInteger page;
@end

@implementation WGClassDetailViewController
- (BOOL)emptyCanScroll {
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.backButton.backgroundColor = kRedColor;
    
    UIImage *image = [UIImage imageNamed:@"nav_back_circle"];
    [self.backButton setImage:image forState:UIControlStateNormal];
    [self.backButton setImage:image forState:UIControlStateHighlighted];
    
    self.tableView.contentInset = UIEdgeInsetsZero;
    self.headView = [WGClassHeadView new];
    self.headView.tableView = self.tableView;
    [self.view addSubview:self.scrollToTopButton];
    [self wg_tableViewDidScroll:self.tableView];
    
    self.headView.classItem = self.classItem;
    
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
    NSString *url = self.requestUrl;
    WGHomeParam *param = [WGHomeParam new];
    param.deviceType = 2;
    param.locationCodeId = self.homeInfo.city.cityCode;
    param.pageSize = 15;
    param.pageNum = self.page;
    param.markId = self.classItem.code;
    
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:url];
    request.wg_parameters = [param wg_keyValues];
//    __weak typeof(self) weakself = self;
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        if (self.page == kDefaultPage) {
            [self.dataArray removeAllObjects];
        }
        NSArray *data = response.responseJSON[@"items"];
        NSArray *array = [WG_HomeItem wg_modelArrayWithDictArray:data];
        [self.dataArray wg_addObjectsFromArray:array];
        
        NSDictionary *obj = response.responseJSON[@"obj"];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *markInfo = obj[@"markInfo"];
            WG_HomeClassItem *classItem = [WG_HomeClassItem wg_modelWithDictionry:markInfo];
            self.classItem = classItem;
            
//            self.headView.classItem = self.classItem;
        }
        [self.tableView wg_reloadData];
        
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}

#pragma mark - 代理方法
- (UITableViewCell *)wg_cellAtIndexPath:(NSIndexPath *)indexPath {
    WG_HomeItem *item = self.dataArray[indexPath.row];
    WG_HomeCell *cell = [WG_HomeCell wg_cellWithTableView:self.tableView];
    cell.item = item;
    return cell;
}
- (NSInteger)wg_numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}
- (CGFloat)wg_sectionHeaderHeightAtSection:(NSInteger)section {
    return 10;
}
- (UIEdgeInsets)wg_sepLineEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat left = 12;
    return UIEdgeInsetsMake(0, left, 0, left);
}

- (void)wg_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(WG_BaseTableViewCell *)cell {
    WG_HomeItem *item = self.dataArray[indexPath.row];
    if (item) {
        WG_JobDetailViewController *jobdetailVC = [WG_JobDetailViewController new];
        jobdetailVC.homeItem = item;
        [self wg_pushVC:jobdetailVC];
    }
    
}

- (void)wg_tableViewDidScroll:(WG_BaseTableView *)tableView {
    CGFloat offsetY = tableView.contentOffset.y;
//    CGFloat insetTop = tableView.contentInset.top;
//    WGLog(@"offsetY:%.2f insetTop:%.2f", offsetY, insetTop);
    
    CGFloat showMinY = 200;
    CGFloat showMaxY = showMinY + 50;
    CGFloat alpha = 1;
    
    self.scrollToTopButton.hidden = offsetY < showMinY;
    
    alpha = (offsetY - showMinY)/(showMaxY - showMinY);
    if (alpha > 1) {
        alpha = 1;
    } else if (alpha < 0) {
        alpha = 0;
    }
    
    self.scrollToTopButton.alpha = alpha;
}
#pragma mark - Private
- (UIColor *)navbarBackgroundColor {
    return kClearColor;
}
- (BOOL)navbarLineHidden {
    return YES;
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}
- (UIButton *)scrollToTopButton {
    if (!_scrollToTopButton) {
        _scrollToTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat buttonW = 40, buttonH = buttonW;
        CGFloat buttonX = kScreenWidth - buttonW - 20;
        CGFloat buttonY = kScreenHeight - buttonH - 20;
        _scrollToTopButton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        _scrollToTopButton.backgroundColor = kColor(80, 177, 229);
        _scrollToTopButton.layer.cornerRadius = buttonW/2.0;
        _scrollToTopButton.clipsToBounds = YES;
        _scrollToTopButton.layer.masksToBounds = YES;
        
        CGFloat arrowW = buttonW/2;
        CGSize size = CGSizeMake(arrowW, arrowW/2);
        UIImage *image = [UIImage wg_arrowImageWithColor:kWhiteColor size:size arrowW:kLineHeight*2 arrowType:WGArrowImageTypeTop];
        [_scrollToTopButton setImage:image forState:UIControlStateNormal];
        
        __weak typeof(self) weakself = self;
        [_scrollToTopButton setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
//            [strongself.tableView setScrollsToTop:YES];
            [strongself.tableView scrollRectToVisible:CGRectMake(0, 0.1, kScreenWidth, kScreenHeight) animated:YES];
        }];
    }
    return _scrollToTopButton;
}

- (NSString *)requestUrl {
    return @"/linggb-ws/ws/0.1/person/home_v3";
}
@end
