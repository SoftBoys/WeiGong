//
//  WG_AboutUsViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/24.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_AboutUsViewController.h"

#import "WG_AboutUsCell.h"
#import "WG_AboutUsHeadView.h"
#import "WG_AboutUsItem.h"


#import "AppDelegate+CheckVersion.h"

#import <WebKit/WebKit.h>

@interface WG_AboutUsViewController ()
@property (nonatomic, copy) NSArray *dataArray;
@end
@implementation WG_AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于";
    
    
    self.tableView.estimatedRowHeight = 40;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    WG_AboutUsHeadView *headView = [WG_AboutUsHeadView new];
    headView.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth*0.5);
    self.tableView.tableHeaderView = headView;
    
    
}
#pragma mark - UITableViewDataSource
- (UITableViewCell *)wg_cellAtIndexPath:(NSIndexPath *)indexPath{
    
    WG_AboutUsCell *cell = [WG_AboutUsCell wg_cellWithTableView:self.tableView];
    cell.item = self.dataArray[indexPath.row];
    return cell;
}
- (NSInteger)wg_numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}

#pragma mark - UITableViewDelegate
- (void)wg_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(WG_BaseTableViewCell *)cell {
    
    WG_AboutUsItem *item = self.dataArray[indexPath.row];
    if (item.type == 1) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:item.contentUrl]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:item.contentUrl]];
        }
    } else if (item.type == 2) {
        // 可以打电话
        if ([[UIDevice wg_platformString] hasPrefix:@"iPhone"]) {
            [UIDevice wg_phoneWithNumber:item.contentUrl];
        } else {
            [UIAlertController wg_alertWithTitle:@"提示" message:@"该设备不可打电话" completion:^(UIAlertController *alert, NSInteger buttonIndex) {
                
            } cancel:nil sure:@"确定"];
        }
    }
    
}

#pragma mark - getter && setter
- (NSArray *)dataArray {
    if (!_dataArray) {
        NSMutableArray *namelist = @[@"官方网站", @"官方微博", @"微信公众号", @"客服电话"].mutableCopy;
        NSMutableArray *namelist2 = @[@"www.vvgong.com", @"微工网", @"微工", @"400-7060-150"].mutableCopy;
        NSMutableArray *contentUrlList = @[@"http://www.vvgong.com", @"http://weibo.com/vvgong", @"", @"400-7060-150"].mutableCopy;
        NSMutableArray *typeList = @[@1, @1, @0, @2].mutableCopy;
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        // 有可更新
        if (app.wg_updateItem.updateType) {
            [namelist insertObject:@"版本更新" atIndex:0];
            [namelist2 insertObject:@"有新版本可用" atIndex:0];
            [contentUrlList insertObject:kAppStoreUrl atIndex:0];
            [typeList insertObject:@1 atIndex:0];
        }
        
        NSMutableArray *itemList = [NSMutableArray arrayWithCapacity:namelist.count];
        for (NSUInteger i = 0; i < namelist.count; i++) {
            WG_AboutUsItem *item = [WG_AboutUsItem new];
            item.name_left = namelist[i];
            item.name_right = namelist2[i];
            item.contentUrl = contentUrlList[i];
            item.type = [typeList[i] integerValue];
            [itemList addObject:item];
        }
        _dataArray = [itemList copy];
    }
    return _dataArray;
}
@end
