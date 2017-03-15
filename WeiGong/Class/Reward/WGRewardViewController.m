//
//  WGRewardViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/15.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGRewardViewController.h"
#import "WGRewardSelectViewController.h"

#import "WG_WeChatTool.h"
#import "WGRewardItem.h"
#import "WGRewardCell.h"
#import "WGRewardShare.h"

#import "WGRewardHeadView.h"

@interface WGRewardViewController ()
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, strong) WGReward *reward;
@property (nonatomic, strong) WGRewardShare *share;
@property (nonatomic, strong) WGRewardHeadView *headView;
@end

@implementation WGRewardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐奖励";
    
    self.tableView.tableHeaderView = self.headView;
    
    self.dataArray = [self getDataArray];
    [self.tableView wg_reloadData];
    [self setRightItem];
}
- (void)setRightItem {
    __weak typeof(self) weakself = self;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:kOrangeColor forState:UIControlStateNormal];
    button.titleLabel.font = kFont(15);
    [button setTitle:@"奖励查询" forState:UIControlStateNormal];
    [button setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        __strong typeof(weakself) strongself = weakself;
        WGRewardSelectViewController *selectVC = [WGRewardSelectViewController new];
        [strongself wg_pushVC:selectVC];
    }];
    [self.navBar addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kStatusBarHeight);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(kNavigationBarHeight);
    }];
}
- (NSArray *)getDataArray {
    NSArray *titles = @[@"微信扫一扫，邀请好友，加入微工",@"邀请微信好友，加入微工",@"分享到朋友圈邀请好友，加入微工"];
    NSArray *images = @[@"reward_scan",@"reward_session",@"reward_timeline"];
    NSMutableArray *array = @[].mutableCopy;
    NSInteger count = 1;
//    count = titles.count;
    if ([WG_WeChatTool isInstalledWeChat]) {
        count = titles.count;
    }
    for (NSInteger i = 0; i < count; i++) {
        WGRewardItem *item = [WGRewardItem new];
        item.icon = [UIImage imageNamed:images[i]];
        item.title = titles[i];
        item.canClick = (i != 0);
        item.isWXSession = (i == 1);
        [array wg_addObject:item];
    }
    
    WGRewardItem *item = [WGRewardItem new];
    item.isScan = YES;
    [array wg_insertObject:item atIndex:1];
    
    return [array copy];
}

- (void)wg_loadData {
    
    NSString *url = self.requestUrl;
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:url];
//    request.wg_parameters = @{};
    
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        if (response.responseJSON) {
            WGReward *reward = [WGReward mj_objectWithKeyValues:response.responseJSON];
            self.reward = reward;
            
            self.headView.reward = self.reward;
//            self.tableView.tableHeaderView = self.headView;
            
            NSDictionary *commonShare = response.responseJSON[@"commonShare"];
            WGRewardShare *share = [WGRewardShare mj_objectWithKeyValues:commonShare];
            
            [WGDownloadImageManager downloadImageWithUrl:share.picUrl completeHandle:^(BOOL finished, UIImage *image) {
                if (image) {
                    share.icon = image;
                }
                self.share = share;
            }];
            self.share = share;
            
            
            [self.tableView wg_reloadData];
        }
    }];
    
}

- (UITableViewCell *)wg_cellAtIndexPath:(NSIndexPath *)indexPath {
    
    WGRewardItem *item = self.dataArray[indexPath.row];
    WGRewardCell *cell = [WGRewardCell wg_cellWithTableView:self.tableView];
    cell.item = item;
    cell.scanUrl = self.reward.invitationUrl;
    return cell;
    
}

- (NSInteger)wg_numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}
- (UIEdgeInsets)wg_sepLineEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath {
    return UIEdgeInsetsZero;
}
- (void)wg_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(WG_BaseTableViewCell *)cell {
    WGRewardItem *item = self.dataArray[indexPath.row];
    if (item.canClick) {
        if (self.share == nil) return;
        if (item.isWXSession) {
            [[WG_WeChatTool shareInstance] shareToSessionWithTitle:self.share.title content:self.share.content icon:self.share.icon link:self.share.linkUrl];
        } else {
            [[WG_WeChatTool shareInstance] shareToTimelineWithTitle:self.share.title content:self.share.content icon:self.share.icon link:self.share.linkUrl];
        }
    }
}

#pragma mark - private
- (WGRewardHeadView *)headView {
    if (!_headView) {
        _headView = [WGRewardHeadView new];
        _headView.frame = CGRectMake(0, 0, kScreenWidth, 135);
    }
    return _headView;
}
- (NSString *)requestUrl {
    return @"/linggb-ws/ws/0.1/person/invitationPerson";
}
@end
