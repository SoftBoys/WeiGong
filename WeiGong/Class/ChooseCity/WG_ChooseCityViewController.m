//
//  WG_ChooseCityViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/13.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_ChooseCityViewController.h"
#import "WG_TableViewGifHeader.h"
#import "WG_CityItem.h"
#import "WG_ChooseCityCell.h"
#import "WG_ChooseCityHeadView.h"

#import "WGDataTypeItem.h"
#import "WGDataBaseTool.h"

@interface WG_ChooseCityViewController ()
@property (nonatomic, copy) NSArray <WG_CityItem *>*cityItemArray;
@end
@implementation WG_ChooseCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择城市";
    
    WG_ChooseCityHeadView *headView = [[WG_ChooseCityHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    self.tableView.tableHeaderView = headView;
    
    headView.currentCity = self.currentItem ? self.currentItem.city : [self.cityItemArray firstObject].city;

    
}

- (void)wg_loadData {
    
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:[self requestUrl]];
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        if (response.statusCode == 200) {
            NSArray *location = response.responseJSON[@"location"];
            NSArray *list = [WG_CityItem wg_modelArrayWithDictArray:location];
            self.cityItemArray = list;
            [WG_CityTool setCityItems:list];
            [self.tableView wg_reloadData];
            
            NSArray *dataCode = response.responseJSON[@"dataCode"];
            [WGDataBaseTool putObject:dataCode withId:@"dataCode"];
            
        }
    }];
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)wg_cellAtIndexPath:(NSIndexPath *)indexPath{
    WG_ChooseCityCell *cell = [WG_ChooseCityCell wg_cellWithTableView:self.tableView];
    cell.item = self.cityItemArray[indexPath.row];
    return cell;
}
- (NSInteger)wg_numberOfRowsInSection:(NSInteger)section {
    return self.cityItemArray.count;
}
#pragma mark - UITableViewDelegate
- (void)wg_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(WG_BaseTableViewCell *)cell {
    WG_CityItem *item = self.cityItemArray[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(chooseCityItem:)]) {
        [self.delegate chooseCityItem:item];
    }
}

#pragma mark - getter && setter
- (NSArray<WG_CityItem *> *)cityItemArray {
    if (!_cityItemArray) {
        _cityItemArray = [WG_CityTool getCityItemArray];
    }
    return _cityItemArray;
}

- (NSString *)requestUrl {
    return @"/linggb-ws/ws/0.1/common/locationAndDataCode";
}
@end
