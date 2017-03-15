//
//  WG_SearchHistoryViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/28.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_SearchHistoryViewController.h"
#import "WG_SearchViewController.h"
#import "WG_HomeMenuView.h"

#import "WG_SearchHistoryTool.h"

#import "WG_SearchHistoryCell.h"


@interface WG_SearchHistoryViewController () <UITextFieldDelegate>
@property (nonatomic, strong) UITextField *searchBar;
@property (nonatomic, strong) UIButton *footerBtn;

@property (nonatomic, strong) NSMutableArray *dataArray;
@end
@implementation WG_SearchHistoryViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSArray *historyItems = [WG_SearchHistoryTool wg_historyItems];
    self.dataArray = historyItems.mutableCopy;
    
    [self.tableView reloadData];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.searchBar becomeFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self wg_setSearchBar];
    self.tableView.backgroundColor = kColor(233, 233, 233);
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 15)];
    
    self.tableView.tableFooterView = self.footerBtn;
}
- (void)wg_setSearchBar {
    
    [self.navBar addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(10);
        make.left.mas_equalTo(55);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(30);
    }];
    
    self.searchBar.background  = [[UIImage wg_imageWithColor:kColor(233, 233, 233) size:CGSizeMake(300, 30)] wg_imageWithCornerRadius:15];
    
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WG_SearchHistoryItem *item = self.dataArray[indexPath.row];
    WG_SearchHistoryCell *cell = [WG_SearchHistoryCell wg_cellWithTableView:tableView];
    cell.item = item;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.footerBtn.hidden = ![self.dataArray count];
    return [self.dataArray count];
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    return;
    WG_SearchHistoryItem *item = self.dataArray[indexPath.row];
    WG_SearchViewController *searchVC = [[WG_SearchViewController alloc] initWithStyle:UITableViewStylePlain];
    searchVC.keyWords = item.name;
    searchVC.menuView.items = self.menuItems;
    [self wg_pushVC:searchVC];
    [WG_SearchHistoryTool wg_saveHistoryItem:item];
    self.searchBar.text = item.name;
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    NSString *keyWorks = textField.text;
    if (keyWorks.length == 0) return NO;
    WG_SearchViewController *searchVC = [[WG_SearchViewController alloc] initWithStyle:UITableViewStylePlain];
    searchVC.keyWords = keyWorks;
    searchVC.menuView.items = self.menuItems;
    [self wg_pushVC:searchVC];
    
    WG_SearchHistoryItem *item = [WG_SearchHistoryItem new];
    item.name = keyWorks;
    item.key = [keyWorks wg_MD5];
//    item.timeStamp = [[NSDate date] timeIntervalSince1970];
    [WG_SearchHistoryTool wg_saveHistoryItem:item];
    
    return YES;
}

- (void)wg_clearHistory {
    NSString *title = @"温馨提示";
    NSString *message = @"你确定要清除历史记录吗?";
    [UIAlertController wg_alertWithTitle:title message:message completion:^(UIAlertController *alert, NSInteger buttonIndex) {
        if (buttonIndex) {
            [WG_SearchHistoryTool wg_clearHistory];
            self.dataArray = nil;
            [self.tableView reloadData];
        }
    } cancel:@"取消" sure:@"确定"];
    
    
}
#pragma mark - getter && setter
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        NSArray *historyItems = [WG_SearchHistoryTool wg_historyItems];
        _dataArray = historyItems.mutableCopy;
    }
    return _dataArray;
}
- (UITextField *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UITextField alloc] init];
        _searchBar.backgroundColor = [UIColor clearColor];
        _searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchBar.placeholder = @"请输入关键字";
        _searchBar.font = kFont_16;
        _searchBar.textColor = kColor_Black;
        _searchBar.leftViewMode = UITextFieldViewModeAlways;
        _searchBar.returnKeyType = UIReturnKeySearch;
        _searchBar.delegate = self;
        UIButton *leftView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        leftView.userInteractionEnabled = NO;
        [leftView setImage:[UIImage imageNamed:@"bar_search"] forState:UIControlStateNormal];
        _searchBar.leftView = leftView;
    }
    return _searchBar;
}
- (UIButton *)footerBtn {
    if (!_footerBtn) {
        _footerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        _footerBtn.titleLabel.font = kFont_15;
        [_footerBtn setTitle:@"清除搜索记录" forState:UIControlStateNormal];
        [_footerBtn setTitleColor:kColor_Black_Sub forState:UIControlStateNormal];
        [_footerBtn setBackgroundImage:[WG_SearchHistoryCell backImageWithColor:kColor_White] forState:UIControlStateNormal];
        [_footerBtn setBackgroundImage:[WG_SearchHistoryCell backImageWithColor:kColor_Gray_Back] forState:UIControlStateHighlighted];
        [_footerBtn addTarget:self action:@selector(wg_clearHistory) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footerBtn;
}

@end
