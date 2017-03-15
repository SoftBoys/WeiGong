//
//  WG_HomeViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/12.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_HomeViewController.h"
#import "WG_BaseNavViewController.h"
#import "WG_ChooseCityViewController.h"
#import "WG_SearchHistoryViewController.h"
#import "WG_JobDetailViewController.h"
#import "WGClassDetailViewController.h"


#import "WG_HomeNavBar.h"
#import "WG_HomeBanner.h"
#import "WG_TableViewNormalHeader.h"
#import "WG_TableViewNormalFooter.h"
#import "WG_HomeMenuView.h"

#import "WG_HomeCell.h"

#import "WGLocationManager.h"
#import "WG_CityItem.h"
#import "WG_HomeTool.h"
#import "WG_HomeItem.h"

#import "WG_HomeClassItem.h"
#import "WG_HomeBannerItem.h"

#import "WGHomeParam.h"
#import "WGHomeInfo.h"

@interface WG_HomeViewController () <WG_HomeNavBarDelegate, WG_HomeBannerDelegate, WG_ChooseCityViewControllerDelegate>
@property (nonatomic, strong) WG_HomeNavBar *navBackgroundView;
@property (nonatomic, strong) WG_HomeBanner *banner;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) WG_CityItem *defaultCity;
@property (nonatomic, strong) WGHomeInfo *homeInfo;
@end
@implementation WG_HomeViewController
- (BOOL)emptyCanScroll {
    return YES;
}
- (instancetype)init {
    return [self initWithStyle:UITableViewStylePlain];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationController.tabBarItem.badgeValue = @"10";
    self.navigationItem.title = @"微工";
    
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
    
    
    [self setNavBar];
    [self setBanner];
    
    [self startLocation];
    
    [self testData];
    
    
    NSArray *bannerItems = self.homeInfo.bannerItems;
    [self.banner setupBannerItems:bannerItems];
    
    NSArray *classItems = self.homeInfo.classItems;
    [self.banner setupClassItems:classItems];
    
    self.dataArray = [self.homeInfo.homeItems mutableCopy];
    [self.tableView wg_reloadData];
    self.navBackgroundView.city = self.defaultCity.city;
    
    /** 初始化位置 */
    [self wg_tableViewDidScroll:self.tableView];
}
- (void)startLocation {
    WGLocationManager *manager = [WGLocationManager shareManager];
    
    [manager startLocationWithSuccess:^(WGLocationManager *manager, WGLocationInfo *info) {
        WGLog(@"address:%@", info);
        [self setCurrentCityItemWithLocationInfo:info];
    } fail:^(WGLocationManager *manager, NSError *error) {
        
    }];
}
- (void)testData {
//    self.dataArray = @[].mutableCopy;
//    for (NSInteger i = 0; i < 15; i++) {
//        WG_HomeItem *item = [WG_HomeItem new];
//        [self.dataArray addObject:item];
//    }
//    [self.tableView wg_reloadData];
    
    NSArray *titles = @[@"仓储揽投",@"店面服务",@"会时服务",@"数据服务",@"设计外包"];
    titles = @[@"",@"",@"",@"",@""];
    NSMutableArray *classItems = @[].mutableCopy;
    for (NSInteger i = 0; i < titles.count; i++) {
        WG_HomeClassItem *item = [WG_HomeClassItem new];
        item.name = titles[i];
        [classItems wg_addObject:item];
    }
    [self.banner setupClassItems:[classItems copy]];
    
    
}
- (void)setNavBar {
    
    self.tableView.contentInset = UIEdgeInsetsZero;
    WG_HomeNavBar *navBackgroundView = [WG_HomeNavBar new];
    navBackgroundView.delegate = self;
    [self.navBar addSubview:navBackgroundView];
    self.navBackgroundView = navBackgroundView;
    [navBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(kStatusBarHeight);
    }];
    self.navBackgroundView.city = @"北京";
}
- (void)setBanner {
    WG_HomeBanner *banner = [WG_HomeBanner new];
    banner.frame = CGRectMake(0, 0, kScreenWidth, [WG_HomeBanner bannerHeight]+[WG_HomeBanner classHeight]);
    banner.delegate = self;
    self.tableView.tableHeaderView = banner;
    self.banner = banner;
}

- (void)wg_loadData {
    [self wg_loadDataWithPage:kDefaultPage];
}
- (void)wg_loadDataWithPage:(NSInteger)page {
    self.page = page;
    NSString *url = self.requestUrl;
    WGHomeParam *param = [WGHomeParam new];
    param.deviceType = 2;
    param.locationCodeId = self.defaultCity.cityCode;
    param.pageSize = 15;
    param.pageNum = self.page;
    
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:url];
    request.wg_parameters = [param wg_keyValues];
    __weak typeof(self) weakself = self;
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        if (response.responseJSON == nil) return;
        __strong typeof(weakself) strongself = weakself;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if (strongself.page == kDefaultPage) {
                [strongself.dataArray removeAllObjects];
            }
            NSArray *data = response.responseJSON[@"items"];
            NSArray *array = [WG_HomeItem wg_modelArrayWithDictArray:data];
            [strongself.dataArray wg_addObjectsFromArray:array];
//            WGLog(@"home:%@", response);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSDictionary *obj = response.responseJSON[@"obj"];
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    NSArray *picList = obj[@"picList"];
                    NSArray *bannerItems = [WG_HomeBannerItem wg_modelArrayWithDictArray:picList];
                    [strongself.banner setupBannerItems:bannerItems];
                    strongself.homeInfo.bannerItems = bannerItems;
                    
                    NSArray *markList = obj[@"markList"];
                    NSArray *classItems = [WG_HomeClassItem wg_modelArrayWithDictArray:markList];
                    [strongself.banner setupClassItems:classItems];
                    strongself.homeInfo.classItems = classItems;
                }
                
                
                
                strongself.homeInfo.city = strongself.defaultCity;
                
                strongself.homeInfo.homeItems = [strongself.dataArray copy];
                
                [WG_HomeTool saveHomeInfo:strongself.homeInfo];
                
                [strongself.tableView wg_reloadData];
                
//                WG_HomeItem *item = [strongself.dataArray lastObject];
//                WGLog(@"name:%@  url:%@", item.jobName, item.jobUrl);
                
                [strongself.tableView.mj_header endRefreshing];
                [strongself.tableView.mj_footer endRefreshing];
                
            });
        });
    }];
    
}
#pragma mark - WG_ChooseCityViewControllerDelegate
- (void)chooseCityItem:(WG_CityItem *)item {
    if (item) {
        self.defaultCity = item;
        self.navBackgroundView.city = self.defaultCity.city;
        [self wg_loadData];
        [self wg_popToVC:self];
    }
}
#pragma mark - WG_HomeNavBarDelegate
- (void)didClickCityButton {
    
    WG_ChooseCityViewController *cityVC = [WG_ChooseCityViewController new];
    cityVC.delegate = self;
    [self wg_pushVC:cityVC];
    
//    UINavigationController *nav = [[WG_BaseNavViewController alloc] initWithRootViewController:cityVC];
//    [self wg_presentVC:nav];
}
- (void)didClickSearchButton {
    
}
#pragma mark - WG_HomeBannerDelegate
/** 点击Banner */
- (void)tapScrollImageWithItem:(WG_HomeBannerItem *)item {
    
}
/** 点击类别 */
- (void)tapClassButtonWithItem:(WG_HomeClassItem *)item {
    WGLog(@"点击了类别");
    if (item) {
        
        WGClassDetailViewController *classDetailVC = [WGClassDetailViewController new];
        classDetailVC.homeInfo = self.homeInfo;
        classDetailVC.classItem = item;
        [self wg_pushVC:classDetailVC];
    }
}
#pragma mark - TableView的代理方法
- (UITableViewCell *)wg_cellAtIndexPath:(NSIndexPath *)indexPath {
    WG_HomeItem *item = self.dataArray[indexPath.row];
    WG_HomeCell *cell = [WG_HomeCell wg_cellWithTableView:self.tableView];
    cell.item = item;
    return cell;
    return [super wg_cellAtIndexPath:indexPath];
}
- (NSInteger)wg_numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}

- (CGFloat)wg_sectionHeaderHeightAtSection:(NSInteger)section {
    return 10;
}
- (CGFloat)wg_sectionFooterHeightAtSection:(NSInteger)section {
    return 0.01;
}

- (UIEdgeInsets)wg_sepLineEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath {
    float left = 12;
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
    CGFloat top = tableView.contentInset.top;
    //    DMLog(@"offsetY:%@ \t top:%@", @(offsetY), @(top));
    CGFloat spaceY = offsetY + top;
    CGFloat alpha = (spaceY / kTopBarHeight);
    if (alpha < 0) {
        alpha = 0;
    } else if (alpha > 1) {
        alpha = 1;
    }
    if (spaceY > kTopBarHeight) {
        self.statusBarStyle = UIStatusBarStyleDefault;
        self.navBackgroundView.type = WGHomeCityTypeLightGray;
        self.titleColor = [UIColor wg_red:64 green:64 blue:64];
    } else {
        self.statusBarStyle = UIStatusBarStyleLightContent;
        self.navBackgroundView.type = WGHomeCityTypeWhite;
        self.titleColor = kWhiteColor;
    }
    self.lineColor = [kColor_NavLine colorWithAlphaComponent:alpha];
    self.backgroundColor = [kColor_Navbar colorWithAlphaComponent:alpha];
    [self updateNavBar];
    
}
#pragma mark - Private
- (UIColor *)navbarLineColor {
    return self.lineColor;
}
- (UIColor *)navbarBackgroundColor {
    return self.backgroundColor;
}
- (UIColor *)navbarTitleColor {
    return self.titleColor;
}
- (UIColor *)lineColor {
    if (_lineColor == nil) {
        _lineColor = [kColor_NavLine colorWithAlphaComponent:0];
    }
    return _lineColor;
}
- (UIColor *)backgroundColor {
    if (_backgroundColor == nil) {
        _backgroundColor = [kColor_Navbar colorWithAlphaComponent:0];
    }
    return _backgroundColor;
}
- (UIColor *)titleColor {
    if (!_titleColor) {
        _titleColor = [super navbarTitleColor];
    }
    return _titleColor;
}
- (NSString *)requestUrl {
    return @"/linggb-ws/ws/0.1/person/home_v3";
}

- (WGHomeInfo *)homeInfo {
    if (!_homeInfo) {
        _homeInfo = [WG_HomeTool homeInfo];
        if (_homeInfo == nil) {
            _homeInfo = [WGHomeInfo new];
        }
    }
    return _homeInfo;
}
- (WG_CityItem *)defaultCity {
    if (!_defaultCity) {
//        _defaultCity = [WG_HomeTool getCurrentCityItem];
        _defaultCity = self.homeInfo.city;
        if (_defaultCity == nil) {
            _defaultCity = [[WG_CityTool getCityItemArray] firstObject];
        }
    }
    return _defaultCity;
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}
- (void)setCurrentCityItemWithLocationInfo:(WGLocationInfo *)info {
    
    NSArray<WG_CityItem *> *cityList = [WG_CityTool getCityItemArray];
    if (info == nil) return;
    for (WG_CityItem *city in cityList) {
        if ([info.detailAddress containsString:city.city]) {
            
            // 第一次使用
            if ([WG_HomeTool getCurrentCityItem] == nil) {
                self.defaultCity = city;
                [WG_HomeTool saveCurrentCityItem:city];
                self.navBackgroundView.city = self.defaultCity.city;
                // TODO: 刷新数据
                [self wg_loadData];
                break;
            } else {
                if (city.cityCode != self.defaultCity.cityCode) {
                    NSString *title = @"提醒";
                    NSString *message = [NSString stringWithFormat:@"当前位置%@, 您确定更改位置吗？", city.city];
                    NSString *cancel = @"取消";
                    NSString *sure = @"确定";
                    /** 不在当前页面不弹框提醒 */
                    if ([self wg_topViewController] != self) {
                        break;
                    }
                    // 保证弹框只弹出一次
                    static BOOL isAlert = NO;
                    if (!isAlert) {
                        isAlert = YES;
                        [UIAlertController wg_alertWithTitle:title message:message completion:^(UIAlertController *alert, NSInteger buttonIndex) {
                            WGLog(@"buttonIndex:%zd", buttonIndex);
                            if (buttonIndex) {
                                self.defaultCity = city;
                                [WG_HomeTool saveCurrentCityItem:city];
                                self.navBackgroundView.city = self.defaultCity.city;
                                // TODO: 刷新数据
                                [self wg_loadData];
                            }
                        } cancel:cancel sure:sure];
                    }
                    
                    break;
                }
            }
        }
    }
    
}

@end
