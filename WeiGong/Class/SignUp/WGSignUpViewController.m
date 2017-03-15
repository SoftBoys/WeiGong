//
//  WGSingUpViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 17/2/19.
//  Copyright © 2017年 guojunwei. All rights reserved.
//

#import "WGSignUpViewController.h"
#import "WGLocationManager.h"

#import <BaiduMapAPI_Utils/BMKGeometry.h>
#import "WGRequestManager.h"
#import "WG_IconButton.h"
#import "WGSignUpLocationView.h"
#import "WGSignUpTimeView.h"
#import "WGSignUpListCell.h"
#import "WGSignUpOrDownCell.h"

#import "WGSignUpDetail.h"
#import "NSTimer+Addition.h"

#import "WGSignUpOrDownParam.h"

@interface WGSignUpViewController () <WGSignUpOrDownCellDelegate>
@property (nonatomic, strong) WGSignUpTimeView *timeView;
@property (nonatomic, strong) WGSignUpLocationView *locationView;
@property (nonatomic, strong) WGSignUpDetail *detail;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSTimeInterval timestamp;
@property (nonatomic, assign) CLLocationCoordinate2D baiduCoor;
@end

@implementation WGSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"签到签退";
    
    [self setupHeadFootView];
    [self startLocation];
    
}
- (void)setupHeadFootView {
    [self.view addSubview:self.timeView];
    [self.view addSubview:self.locationView];
    
    CGFloat timeH = 40;
    [self.timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.navBar.mas_bottom);
        make.height.mas_equalTo(timeH);
    }];
    
    CGFloat locationH = 40;
    [self.locationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(locationH);
    }];
    
    UIEdgeInsets contentInset = self.tableView.contentInset;
    contentInset.top += timeH;
    contentInset.bottom += locationH;
    self.tableView.contentInset = contentInset;
    
}
- (void)startLocation {
    static CGFloat rotation = M_PI_4;
    self.locationView.button_location.transform = CGAffineTransformMakeRotation(rotation);
    self.locationView.button_location.enabled = NO;
    
    __weak typeof(self) weakself = self;
    WGLocationManager *locationManager = [WGLocationManager shareManager];
    [locationManager restartLocationWithSuccess:^(WGLocationManager *manager, WGLocationInfo *info) {
        __strong typeof(weakself) strongself = weakself;
        [strongself getBaiduLocationWithInfo:info];
        strongself.locationView.button_location.transform = CGAffineTransformMakeRotation(0);
        strongself.locationView.button_location.enabled = YES;
    } fail:^(WGLocationManager *manager, NSError *error) {
        __strong typeof(weakself) strongself = weakself;
        strongself.locationView.button_location.transform = CGAffineTransformMakeRotation(0);
        strongself.locationView.button_location.enabled = YES;
    }];
}
- (void)getBaiduLocationWithInfo:(WGLocationInfo *)info {
    CLLocation *location = info.location;
    NSDictionary *dict = BMKConvertBaiduCoorFrom(location.coordinate, BMK_COORDTYPE_GPS);
    if (dict) {
        CLLocationCoordinate2D baiduCoor = BMKCoorDictionaryDecode(dict);
        [self wg_loadDataWithBaiduCoor:baiduCoor];
    }
    self.locationView.address = info.detailAddress;
}
- (void)wg_loadDataWithBaiduCoor:(CLLocationCoordinate2D)baiduCoor {
    self.baiduCoor = baiduCoor;
    
    [WGRequestManager cancelTaskWithUrl:[self requestUrl]];
    NSDictionary *param = @{@"lon":@(baiduCoor.longitude), @"lat":@(baiduCoor.latitude)};
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:[self requestUrl]];
    request.wg_parameters = param;
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
//        WGLog(@"statusCode:%@", @(response.statusCode));
        if (response.statusCode == 0) return ;
        WGSignUpDetail *detail = [WGSignUpDetail wg_modelWithDictionry:response.responseJSON];
        
        self.detail = detail;
        
        /** 测试数据 */
//        NSMutableArray *testList = @[].mutableCopy;
//        for (NSInteger i = 0; i < 20; i++) {
//            WGSignUpListItem *item = [WGSignUpListItem new];
//            item.jobName = kStringAppend(@"测试测试测试", @(i));
//            item.startTime = @"06:20";
//            item.stopTime = @"12:20";
//            item.address = @"北京市海淀区";
//            item.startDate = @"06:00";
//            item.startDistance = 50;
//            item.stopDate = @"18:00";
//            item.stopDistance = 100;
//            item.startFlag = i % 3;
//            item.stopFlag = i % 4 ;
//            if (item.stopFlag == 1) {
//                item.startFlag = 1;
//            }
//            [testList wg_addObject:item];
//        }
//        self.detail.jobList = testList;
        
        [self beginTiming];
        
        [self.tableView wg_reloadData];
    }];
}

- (void)beginTiming {
    if (self.detail == nil) {
        return;
    }
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timestamp = self.detail.currentTime/1000;
    __weak typeof(self) weakself = self;
    self.timer = [NSTimer wg_timerWithTimeInterval:1 block:^{
        __strong typeof(weakself) strongself = weakself;
        [strongself timerTimestamp:strongself.timer];
    } repeats:YES];
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}
- (void)timerTimestamp:(NSTimer *)timer {
    
    if (self.timestamp > 0) {        
        self.timeView.timestamp = self.timestamp;
        self.timestamp ++ ;
    }
//    WGLog(@"%@",@(timestamp));
}
#pragma mark - 代理方法
- (UITableViewCell *)wg_cellAtIndexPath:(NSIndexPath *)indexPath {
    WGSignUpListItem *item = self.detail.jobList[indexPath.section];
    if (indexPath.row == 0) {
        WGSignUpListCell *cell = [WGSignUpListCell wg_cellWithTableView:self.tableView];
        cell.item = item;
        return cell;
    } else if (indexPath.row == 1) {
        WGSignUpOrDownCell *cell = [WGSignUpOrDownCell wg_cellWithTableView:self.tableView];
        cell.item = item;
        cell.delegate = self;
        return cell;
    }
    return [super wg_cellAtIndexPath:indexPath];
}
- (CGFloat)wg_sectionHeaderHeightAtSection:(NSInteger)section {
    return 12;
}
- (NSInteger)wg_numberOfSections {
    return self.detail.jobList.count;
}
- (NSInteger)wg_numberOfRowsInSection:(NSInteger)section {
    WGSignUpListItem *item = self.detail.jobList[section];
    NSInteger count = (item.startFlag == 1 && item.stopFlag == 1) ? 1:2;
    return count;
}
- (UIEdgeInsets)wg_sepLineEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath {
    return UIEdgeInsetsZero;
}
#pragma mark - WGSignUpOrDownCellDelegate
- (void)signUpOrDownWithItem:(WGSignUpListItem *)item {
    if (item == nil) {
        return;
    }
    
    NSInteger flag = (item.startFlag != 1)? 1:2;
    WGSignUpOrDownParam *param = [WGSignUpOrDownParam new];
    param.personalWorkId = item.personalWorkId;
    param.baiduLatitude = @(self.baiduCoor.latitude);
    param.baiduLongitude = @(self.baiduCoor.longitude);
    param.flag = flag;
    [WGRequestManager cancelTaskWithUrl:[self signUpOrDownUrl]];
    [MBProgressHUD wg_showHub_CanTap];
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:[self signUpOrDownUrl] isPost:YES];
    request.wg_parameters = [param wg_keyValues];
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        [MBProgressHUD wg_hideHub];
        if (response.statusCode == 200) {
            [self wg_loadDataWithBaiduCoor:self.baiduCoor];
        }
    }];
}
- (NSString *)signUpOrDownUrl {
    return @"/linggb-ws/ws/0.1/newArrange/naUpdatePersonAttendance";
}
#pragma mark - private
- (NSString *)requestUrl {
    return @"/linggb-ws/ws/0.1/person/arrangeJobToday";
}
- (WGSignUpLocationView *)locationView {
    if (!_locationView) {
        _locationView = [WGSignUpLocationView new];
        __weak typeof(self) weakself = self;
        [_locationView.button_location setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(weakself) strongself = weakself;
            [strongself clickLocationButton];
        }];
    }
    return _locationView;
}
- (void)clickLocationButton {
//    self.locationView.button_location.transform = CGAffineTransformMakeRotation(M_PI_4);
    [self startLocation];
}

- (WGSignUpTimeView *)timeView {
    if (!_timeView) {
        _timeView = [WGSignUpTimeView new];
        _timeView.backgroundColor = self.tableView.backgroundColor;
    }
    return _timeView;
}

- (void)dealloc {
    [[WGLocationManager shareManager] stopLocation];
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
@end
