//
//  WG_SearchViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/28.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_SearchViewController.h"
#import "WG_JobDetailViewController.h"

#import "WG_HomeMenuView.h"
#import "WG_HomeCell.h"
#import "WG_HomeItem.h"
#import "WG_TableViewGifHeader.h"
#import "WG_TableViewNormalFooter.h"

#import "WG_HomeMenuItem.h"


@interface WG_SearchButton : UIButton

@end

@implementation WG_SearchButton
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = kFont_15;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self setImage:[UIImage imageNamed:@"bar_search"] forState:UIControlStateNormal];
        [self setTitleColor:kColor_Black forState:UIControlStateNormal];
    }
    return self;
}
- (void)setHighlighted:(BOOL)highlighted {}
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGSize size = self.currentImage.size;
    CGFloat imageY = (CGRectGetHeight(self.frame)-size.height)/2.0;
    return (CGRect){0, imageY, size};
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGRect imageF = [self imageRectForContentRect:CGRectZero];
    CGFloat titleX = CGRectGetMaxX(imageF);
    CGFloat titleW = CGRectGetWidth(self.frame) - titleX;;
    CGFloat titleH = CGRectGetHeight(self.frame);
    return (CGRect){titleX, 0, titleW, titleH};
}
@end

@interface WG_SearchViewController () <WG_HomeMenuViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, assign) NSUInteger requestId;
@end
@implementation WG_SearchViewController
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.menuView wg_tapBackView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索";
    self.tableView.tableHeaderView = nil;
    self.navBar.backgroundColor = kColor_Gray_Nav;
    
    self.statusBarStyle = UIStatusBarStyleDefault;
    
    [self wg_redefineBackBtn];
    [self wg_addSearchBar];
    [self setHeadView];
    
    [self wg_downloadDataWithPage:self.page keyWorks:self.keyWords];
    
    
}
- (void)wg_redefineBackBtn {
    // 重定义返回按钮
    UIButton *backBtn = [self valueForKey:@"backBtn"];
    
    if (backBtn) {
        
        // 获取点击事件方法名
        NSArray *targetList = [backBtn actionsForTarget:self forControlEvent:UIControlEventTouchUpInside];
        for (NSString *selectorName in targetList) {
            [backBtn removeTarget:self action:NSSelectorFromString(selectorName) forControlEvents:UIControlEventTouchUpInside];
        }
        [backBtn addTarget:self action:@selector(wg_backClick) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)wg_backClick {
//    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)wg_addSearchBar {
    WG_SearchButton *searchBtn = [WG_SearchButton buttonWithType:UIButtonTypeCustom];
    [searchBtn addTarget:self action:@selector(wg_searchClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navBar addSubview:searchBtn];
    
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(10);
        make.left.mas_equalTo(55);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(30);
    }];
    
    [searchBtn setBackgroundImage:[[UIImage wg_imageWithColor:kColor(233, 233, 233) size:CGSizeMake(300, 30)] wg_imageWithCornerRadius:15] forState:UIControlStateNormal];
    
    [searchBtn setTitle:self.keyWords forState:UIControlStateNormal];
}
- (void)wg_searchClick {
    [self wg_backClick];
}
- (void)setHeadView {
    [self.view addSubview:self.menuView];
    
    [self.menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kTopBarHeight);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo([WG_HomeMenuView menuHeight]);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.menuView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    self.tableView.contentInset = UIEdgeInsetsZero;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60;
    
    // 添加刷新
    __weak typeof(self) weakself = self;
    self.tableView.mj_header = [WG_TableViewGifHeader headerWithRefreshingBlock:^{
        weakself.page = 0;
        [weakself wg_downloadDataWithPage:weakself.page keyWorks:self.keyWords];
    }];
    self.tableView.mj_footer = [WG_TableViewNormalFooter footerWithRefreshingBlock:^{
        weakself.page ++;
        [weakself wg_downloadDataWithPage:weakself.page keyWorks:self.keyWords];
    }];
}
- (void)wg_downloadDataWithPage:(NSInteger)page keyWorks:(NSString *)keyWorks{
    
    self.page = page;
    NSArray<WG_HomeMenuItem *> *items = [self valueForKeyPath:@"menuView.items"];
    WG_HomeMenuItem *item1 = [items firstObject];
    WG_HomeMenuItem *item2 = [items objectAtIndex:1];
    WG_HomeMenuItem *item3 = [items lastObject];
    
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:@""];
    /*
    self.requestId = [WG_HomeNetTool wg_toolWithCityId:item1.selectItem.code markId:item3.selectItem.code dateFlag:item2.selectItem.code pageNum:page keyWord:keyWorks success:^(WG_NetResponse *response) {
        
        if (response.responseJSON) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                if (page == 0) {
                    [self.dataArray removeAllObjects];
                }
                NSArray *list = response.responseJSON[@"items"];
                if (list) {
                    NSArray<WG_HomeItem *> *itemList = [WG_HomeItem mj_objectArrayWithKeyValuesArray:list];
                    [self.dataArray addObjectsFromArray:itemList];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView.mj_header endRefreshing];
                    if (list.count < 20) {
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    } else {
                        [self.tableView.mj_footer endRefreshing];
                    }
                    [self.tableView.mj_footer endRefreshing];
                    [self.tableView reloadData];
                });
            });
        }
        
    } fail:^(WG_NetResponse *response) {
        if (self.page) {
            self.page --;
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [response wg_showErrorMessage];
    }];
     */
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
    WG_JobDetailViewController *jobDetailVC = [WG_JobDetailViewController new];
    jobDetailVC.jobId = item.enterpriseJobId;
    [self wg_pushVC:jobDetailVC];
}

- (UIColor *)titleColor {
    return kColor_Black;
}
- (BOOL)hiddenNavBarLine {
    return YES;
}

#pragma mark - WG_HomeMenuViewDelegate
- (void)wg_updateData {
    [self wg_downloadDataWithPage:self.page keyWorks:self.keyWords];
}

#pragma mark - getter && setter
- (WG_HomeMenuView *)menuView {
    if (!_menuView) {
        _menuView = [[WG_HomeMenuView alloc] init];
        _menuView.delegate = self;
    }
    return _menuView;
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
@end
