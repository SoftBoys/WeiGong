//
//  WGChatSetViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/27.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGChatSetViewController.h"
#import "WGChatSetCell.h"
#import <EMSDK.h>

@interface WGChatSetViewController ()
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation WGChatSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupChatter:self.chatter groupHandle:^(EMGroup *group) {
        NSMutableArray *array = @[].mutableCopy;
        NSInteger count = self.isGroup ? 3:1;
        NSArray *titles = @[@"清空聊天记录", @"消息免打扰", @"退出咨询组" ];
        for (NSInteger i = 0; i < count; i++) {
            WGChatSetItem *item = [WGChatSetItem new];
            NSString *name = titles[i];
            item.title = name;
            item.isBlocked = group.isBlocked;
            if (i == 1) {
                item.showSwitch = YES;
            }
            [array addObject:item];
        }
        self.dataArray = [array copy];
        [self.tableView wg_reloadData];
    }];
    
}
- (void)setupChatter:(NSString *)chatter groupHandle:(void(^)(EMGroup *group))handle {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSArray *grouplist = [[EMClient sharedClient].groupManager getJoinedGroups];
        dispatch_async(dispatch_get_main_queue(), ^{
            EMGroup *chatGroup = nil;
            for (EMGroup *group in grouplist) {
                if ([group.groupId isEqualToString:chatter]) {
                    chatGroup = group;
                    break;
                }
            }
//            if (chatGroup) {
                if (handle) {
                    handle(chatGroup);
                }
//            }
            
        });
    });
}

#pragma mark - 代理方法
- (UITableViewCell *)wg_cellAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakself = self;
    WGChatSetItem *item = self.dataArray[indexPath.row];
    WGChatSetCell *cell = [WGChatSetCell wg_cellWithTableView:self.tableView];
    cell.item = item;
    cell.changeSwitchHandle = ^(UISwitch *myswitch) {
        __strong typeof(weakself) strongself = weakself;
        [strongself changeWithSwitch:myswitch];
    };
    return cell;
}
- (NSInteger)wg_numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}
- (UIEdgeInsets)wg_sepLineEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath {
    return UIEdgeInsetsZero;
}

- (void)wg_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(WG_BaseTableViewCell *)cell {
    if (indexPath.row == 0) {
        [self clearMessages];
    } else if (indexPath.row == 2) {
        NSString *title = @"提示", *message = @"确定退出咨询组？";
        [UIAlertController wg_alertWithTitle:title message:message completion:^(UIAlertController *alert, NSInteger index) {
            if (index) {
                [self exitGroup];
            }
        } cancel:@"取消" sure:@"确定"];
    }
}

#pragma mark 退出群组
- (void)exitGroup {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(){
        EMError *error = nil;
        [[EMClient sharedClient].groupManager leaveGroup:self.chatter error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                [MBProgressHUD wg_message:@"退出失败"];
            }
            else{
                [MBProgressHUD wg_message:@"退出成功"];
                [[NSNotificationCenter defaultCenter] postNotificationName:ExitGroup object:nil];
            }
        });
    });
    
}
#pragma mark 清除聊天记录
- (void)clearMessages {
    [[NSNotificationCenter defaultCenter] postNotificationName:RemoveAllMessages object:nil];
}

- (void)changeWithSwitch:(UISwitch *)swit {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error;
        if (swit.isOn) {
            [[EMClient sharedClient].groupManager blockGroup:self.chatter error:&error];
        } else {
            [[EMClient sharedClient].groupManager unblockGroup:self.chatter error:&error];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                [MBProgressHUD wg_message:@"设置失败"];
            } else {
                [MBProgressHUD wg_message:@"设置成功"];
                
            }
        });
    });
}


@end
