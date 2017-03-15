//
//  WG_MineViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/12.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_MineViewController.h"
#import "WG_SettingViewController.h"
#import "WG_CollectViewController.h"
#import "WG_MywalletViewController.h"
#import "WGRewardViewController.h"
#import "WGLinghuoJobViewController.h"
#import "WGAuthIdentifyViewController.h"
#import "WGBasicInfoViewController.h"
#import "WGSignUpViewController.h"
#import "WGMyWorkViewController.h"
#import "WGAccountViewController.h"
#import "WGWorkOrderViewController.h"
#import "WGCreditViewController.h"
#import "WGEvaluationViewController.h"

#import "UIViewController+ImagePicker.h"

#import "WG_MineDragHeadView.h"
#import "WG_DragView.h"
#import "WG_MineWalletCell.h"
#import "WG_MineAuthCell.h"
#import "WG_MineCommitCell.h"


#import "WG_UserDefaults.h"

#import "WG_MineUser.h"
#import "WG_MineUserTool.h"
#import "WG_MineCellItem.h"

#import "WG_MineViewController+WG_Extension.h"

#import "WGLoginTool.h"
#import "WGDisplayViewController.h"

#import "WGActionSheet.h"
#import "WGRequestManager.h"

@interface WG_MineViewController () <WG_MineDragHeadViewDelegate, WG_MineWalletCellDelegate, WG_MineCommitCellDelegate, WG_MineAccountCellDelegate>
@property (nonatomic, strong) WG_MineDragHeadView *headView;

@property (nonatomic, strong) WG_MineUser *user;

@property (nonatomic, assign) NSInteger requestId;
/** 登陆状态 */
@property (nonatomic, assign, readonly) BOOL isLogin;

@property (nonatomic, copy) NSArray<NSArray *> *cellItemSections;
@end
@implementation WG_MineViewController
- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStylePlain];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的";
    
    self.navBar.hidden = YES;
    self.statusBarStyle = UIStatusBarStyleLightContent;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kTabBarHeight, 0);
    
    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 45.5;
    
    self.tableView.separatorColor = [UIColor wg_colorWithHexString:@"#ededed"];
    [self getUserInfo];
    
    self.tableView.backgroundColor = [UIColor wg_colorWithHexString:@"#f4f4f4"];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getUserInfo];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [WGRequestManager cancelTaskWithUrl:[self updateIconUrl]];
    
}
//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    self.statusBarStyle = UIStatusBarStyleLightContent;
//}
- (void)getUserInfo {
    
//    self.user = nil;
    self.user = self.isLogin ? [WG_MineUserTool getUser] : nil;
    // 没登陆
    if (!self.isLogin) {
        [WG_MineUserTool clearUser];
        return;
    }
    
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:self.requestUrl];
    request.wg_parameters = @{@"countFlag":@1, @"countFlagUp":@1};
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        if (response.statusCode == 200) {
            WG_MineUser *user = [WG_MineUser mj_objectWithKeyValues:response.responseJSON];
            self.user = user;
        } else if (response.statusCode == 401) {
            [[WG_UserDefaults shareInstance] loginOut];
        }
    }];
}

- (BOOL)isLogin {
    return [[WG_UserDefaults shareInstance] isLogin];
}

- (BOOL)checkLogin {
    if (![self isLogin]) {
        [WGLoginTool loginWithCompleteHandle:^(WGBaseResponse *response) {
            
        }];
    }
    return [self isLogin];
}

#pragma mark - UITableViewDataSorce 
- (UITableViewCell *)wg_cellAtIndexPath:(NSIndexPath *)indexPath {
    WG_MineCellItem *item = self.cellItemSections[indexPath.section][indexPath.row];
    WG_MineAuthCell *cell = [WG_MineAuthCell wg_cellWithTableView:self.tableView];
    cell.item = item;
    cell.delegate = self;
    return cell;
}

- (NSInteger)wg_numberOfSections {
    return self.cellItemSections.count;
}
- (NSInteger)wg_numberOfRowsInSection:(NSInteger)section {
    NSArray *list = self.cellItemSections[section];
    return list.count;
}
- (CGFloat)wg_sectionFooterHeightAtSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)wg_sectionHeaderHeightAtSection:(NSInteger)section {
    return 10;
}
- (UIView *)wg_headerAtSection:(NSInteger)section {
    return [UIView new];
}
- (UIEdgeInsets)wg_sepLineEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
#pragma mark - UITableViewDelegate
- (void)wg_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(WG_BaseTableViewCell *)cell {
    
    WG_MineCellItem *item = self.cellItemSections[indexPath.section][indexPath.row];
    
    if (item.cellType == 0) return;
//    WGLog(@"需要先登录");
    WGLog(@"type:%@", @(item.type));
    if ([self checkLogin]) {
        // TODO: 做页面跳转
        if (item.type == 1) { // 灵活就业
            WGLinghuoJobViewController *jobVC = [WGLinghuoJobViewController new];
            [self wg_pushVC:jobVC];
        } else if (item.type == 2) { // 身份认证
            WGAuthIdentifyViewController *authVC = [WGAuthIdentifyViewController new];
            [self wg_pushVC:authVC];
        } else if (item.type == 3) { // 基本信息
            WGBasicInfoViewController *basicinfoVC = [WGBasicInfoViewController new];
            [self wg_pushVC:basicinfoVC];
        } else if (item.type == 4) { // 签到签退
            WGSignUpViewController *signupVC = [WGSignUpViewController new];
            [self wg_pushVC:signupVC];
        } else if (item.type == 5) { // 我的工作
            NSArray *titles = @[@"申请中",@"录用",@"待上岗",@"完工"];
            NSMutableArray *vcArray = @[].mutableCopy;
            for (NSInteger i = 0; i < titles.count; i++) {
                WGMyWorkViewController *workVC = [WGMyWorkViewController new];
                workVC.title = titles[i];
                workVC.status = i;
                [vcArray wg_addObject:workVC];
            }
            WGDisplayViewController *displayVC = [WGDisplayViewController new];
            displayVC.title = @"我的工作";
            displayVC.wg_childViewController = vcArray;
            [self wg_pushVC:displayVC];
            
        } else if (item.type == 6) { // 工作订单
            WGWorkOrderViewController *orderVC = [WGWorkOrderViewController new];
            [self wg_pushVC:orderVC];
        }
    }
}
#pragma mark - UIScrollViewDelegate
- (void)wg_tableViewDidScroll:(WG_BaseTableView *)tableView {
    [self.headView.backView scrollViewDidScroll:tableView];
}
#pragma mark - WG_MineDragHeadViewDelegate
/** 点击登录 */
- (void)tapLoginInDragView {
    [WGLoginTool loginWithCompleteHandle:^(WGBaseResponse *response) {
        [self getUserInfo];
    }];
}
/** 点击设置 */
- (void)tapSettingInDragView {
    WG_SettingViewController *settingVC = [[WG_SettingViewController alloc] initWithStyle:UITableViewStyleGrouped];
    settingVC.status = self.user.status;
    [self wg_pushVC:settingVC];
}
/** 点击头像 */
- (void)tapIconInDragView {
    if ([self checkLogin]) {
        NSMutableArray *others = @[@"相册"].mutableCopy;
        if ([UIDevice wg_hasCamera]) {
            [others addObject:@"相机"];
        }
        [WGActionSheet actionSheetWithTitle:nil completionHandle:^(WGActionSheet *sheet, NSInteger index) {
            if (index) {
                if (index == 1) { // 相册
                    if ([UIDevice wg_isAccessPhoto]) {
                        [self presentPickerVCWithType:WGImagePickerPhoto];
                    } else {
                        [UIDevice wg_showPhotoAlert];
                    }
                } else if (index == 2) { // 相机
                    if ([UIDevice wg_isAccessCamera]) {
                        [self presentPickerVCWithType:WGImagePickerCamera];
                    } else {
                        [UIDevice wg_showCameraAlert];
                    }
                }
            }
        } cancel:@"取消" others:others];
    }
}
- (void)presentPickerVCWithType:(WGImagePickerSourceType)type {
    
    __weak typeof(self) weakself = self;
    [self wg_presentImagePickerWithSourceType:type allowEditing:YES completionHandle:^(UIImage *image, NSDictionary *editingInfo) {
//        WGLog(@"image:%@,info:%@", image, editingInfo);
        __strong typeof(weakself) strongself = weakself;
        [strongself updateIcon:image];
    }];
}
#pragma mark - 上传头像
- (void)updateIcon:(UIImage *)icon {
    CGSize iconSize = icon.size;
    CGFloat iconH = 200;
    CGFloat iconW = iconH * iconSize.width/iconSize.height;
    UIImage *newImage = [icon wg_resizedImageWithNewSize:CGSizeMake(iconW, iconH)];
    
    [MBProgressHUD wg_showHub_CanTap];
    NSString *url = [self updateIconUrl];
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:url isPost:YES];
    request.wg_parameters = nil;
    request.wg_imageArray = @[newImage];
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        [MBProgressHUD wg_hideHub];
        if ([response.responseJSON isKindOfClass:[NSDictionary class]]) {
            NSString *url = response.responseJSON[@"url"];
            self.user.iconUrl = url;
            self.user = self.user;
        }
    }];
    
}
- (NSString *)updateIconUrl {
    return @"/linggb-ws/ws/0.1/file/uploadPortraitClient";
}
/** 点击收藏 */
- (void)tapCollectionInDragView {
    if ([self checkLogin]) {
        WG_CollectViewController *colloctVC = [[WG_CollectViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [self wg_pushVC:colloctVC];
    }
}
/** 点击信誉 */
- (void)tapCreditInDragView {
    if ([self checkLogin]) {
        // TODO: 做页面跳转
//        WGCreditViewController *creditVC = [WGCreditViewController new];
        WGEvaluationViewController *evaluationVC = [WGEvaluationViewController new];
        [self wg_pushVC:evaluationVC];
    }
}
/** 点击放鸽子 */
- (void)tapRejectInDragView {
    if ([self checkLogin]) {
        // TODO: 做页面跳转
        
    }
}
#pragma mark - WG_MineWalletCellDelegate
/** 点击我的钱包 */
- (void)wg_tapWallet {
    if ([self checkLogin]) {
        WG_MywalletViewController *wallet = [WG_MywalletViewController new];
        [self wg_pushVC:wallet];
    }
}
/** 点击邀请好友 */
- (void)wg_tapRewards {
    if ([self checkLogin]) {
        // TODO: 做页面跳转
        WGRewardViewController *rewardVC = [WGRewardViewController new];
        [self wg_pushVC:rewardVC];
    }
}
#pragma mark - WG_MineCommitCellDelegate
/** 点击待确认 */
- (void)wg_unSureTap {
    if ([self checkLogin]) {
        // TODO: 做页面跳转
    }
}
/** 点击待评价 */
- (void)wg_unCommitTap {
    if ([self checkLogin]) {
        // TODO: 做页面跳转
    }
}
/** 点击已评价 */
- (void)wg_commitTap {
    if ([self checkLogin]) {
        // TODO: 做页面跳转
    }
}

#pragma mark - WG_MineAccountCellDelegate 点击账户
- (void)clickCellAccountWithItem:(WG_MineCellItem *)item {
    if (item.type == 0) {
        if ([self checkLogin]) {
            
            WGAccountViewController *accountVC = [WGAccountViewController new];
            [self wg_pushVC:accountVC];
        }
    }
}

#pragma mark - getter && setter
- (WG_MineDragHeadView *)headView {
    if (!_headView) {
        _headView = [WG_MineDragHeadView new];
        CGFloat headH = MAX(kScreenWidth * 0.45, 165); // 165
        
        _headView.frame = CGRectMake(0, 0, kScreenWidth, headH);
        _headView.delegate = self;
    }
    return _headView;
}

- (void)setUser:(WG_MineUser *)user {
    _user = user;
    self.headView.user = user;
    if (_user) {
        [WG_MineUserTool saveUser:_user];
    } else {
        [WG_MineUserTool clearUser];
    }
    
    // 获取列表数据
    if (!self.isLogin) {
        self.cellItemSections = [self wg_cellItemSectionsNoLogin];
    } else {
        if (_user.agileFlag == 0) {
            self.cellItemSections = [self wg_cellItemSectionsNoAgile];
        } else {
            self.cellItemSections = [self wg_cellItemSectionsHaveAgile];
        }
    }
    [self.tableView reloadData];
    
}


- (NSString *)requestUrl {
    return @"/linggb-ws/ws/0.1/person/getPersonBasicInfo";
}

@end
