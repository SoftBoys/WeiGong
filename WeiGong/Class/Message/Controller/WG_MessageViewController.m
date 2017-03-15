//
//  WG_MessageViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/12.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_MessageViewController.h"
#import "WG_WebViewController.h"
#import "WGWorkMessageListViewController.h"
#import "WGMessageHistoryViewController.h"

#import "WG_SinaTool.h"
#import "WG_WeChatTool.h"

#import "WGRequestManager.h"
#import "WGMessageItem.h"
#import "WGMessageCell.h"

#import <EMSDK.h>

@interface WG_MessageViewController ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) WGMessageItem *chatMessageItem;
@end
@implementation WG_MessageViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStylePlain];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSInteger unreadCount = [self unreadCount];
    self.chatMessageItem.unreadCount = unreadCount;
    NSString *badgeValue = unreadCount > 0 ? kIntToStr(unreadCount):nil;
    self.navigationController.tabBarItem.badgeValue = badgeValue;
    [self wg_loadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"消息中心";
    
    self.tableView.contentInset = UIEdgeInsetsMake(kTopBarHeight, 0, kTabBarHeight, 0);
    
}

- (void)wg_loadData {
    
    NSString *url = [self requestUrl];
    [WGRequestManager cancelTaskWithUrl:url];
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:url];
    request.wg_parameters = @{@"userFlag":@(2)};
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        
        if (response.statusCode == 200) {
            [self.dataArray removeAllObjects];
            [self.dataArray wg_addObject:self.chatMessageItem];
            
            NSDictionary *workMsg = response.responseJSON[@"workMsg"];
            WGMessageItem *item_work = [WGMessageItem wg_modelWithDictionry:workMsg];
            
            NSDictionary *sysMsg = response.responseJSON[@"sysMsg"];
            WGMessageItem *item_sys = [WGMessageItem wg_modelWithDictionry:sysMsg];
            [self.dataArray wg_addObject:item_sys];
            [self.dataArray wg_addObject:item_work];
            [self.tableView wg_reloadData];
        }
    }];
}

#pragma mark - 代理方法
- (NSInteger)wg_numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}
- (UITableViewCell *)wg_cellAtIndexPath:(NSIndexPath *)indexPath {
    WGMessageItem *item = self.dataArray[indexPath.row];
    WGMessageCell *cell = [WGMessageCell wg_cellWithTableView:self.tableView];
    cell.item = item;
    return cell;
}
- (UIEdgeInsets)wg_sepLineEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath {
    return UIEdgeInsetsZero;
}
- (void)wg_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(WG_BaseTableViewCell *)cell {
    WGMessageItem *item = self.dataArray[indexPath.row];
    
    if (item.itemId == 1) {
        WGMessageHistoryViewController *messageVC = [WGMessageHistoryViewController new];
        [self wg_pushVC:messageVC];
    } else if (item.itemId == 2) {
        WG_WebViewController *webVC = [WG_WebViewController new];
        webVC.title = item.title;
        webVC.webUrl = item.linkUrl;
        [self wg_pushVC:webVC];
    } else if (item.itemId == 3) {
        WGWorkMessageListViewController *workList = [WGWorkMessageListViewController new];
        workList.title = item.title;
//        item.workNew = 1; // 更改消息列表状态
        [self wg_pushVC:workList];
    }
    
}

#pragma mark - private
- (NSString *)requestUrl {
    return @"/linggb-ws/ws/0.1/usermsg/getUserMessageList";
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}
- (WGMessageItem *)chatMessageItem {
    if (!_chatMessageItem) {
        WGMessageItem *item = [WGMessageItem new];
        item.itemId = 1;
        item.unreadCount = [self unreadCount];
        item.title = @"咨询消息";
        item.content = @"查询咨询组或微工客服消息";
        _chatMessageItem = item;
    }
    return _chatMessageItem;
}

- (NSInteger)unreadCount {
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        if (conversation.conversationId.length) {
            unreadCount += conversation.unreadMessagesCount;
        }
    }
    return unreadCount;
}
@end
