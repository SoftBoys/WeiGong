//
//  WG_NearViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/10/12.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_NearViewController.h"
#import "WG_JobDetailViewController.h"

#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

#import "WGLocationManager.h"
#import <BaiduMapAPI_Utils/BMKGeometry.h>

#import "WGNearMenuView.h"
#import "WGNearHeadView.h"
#import "WGNearInfoView.h"
#import "WGNearParam.h"
#import "WGNearMapItem.h"

#import "WG_HomeTool.h"
#import "WGHomeInfo.h"
#import "WG_CityItem.h"

@interface WG_NearViewController () <BMKMapViewDelegate, BMKGeoCodeSearchDelegate>
@property (nonatomic, strong) WGNearHeadView *headView;
@property (nonatomic, strong) WGNearMenuView *menuView;
@property (nonatomic, strong) BMKGeoCodeSearch *geocodesearch;
@property (nonatomic, strong) WGNearInfoView *infoView;
@property (nonatomic, strong) BMKMapView *mapView; //地图
@property (nonatomic, strong) BMKCircle *circle;  // 画圆圈
@property (nonatomic, copy) NSArray *dataArray; //数据源

/** 米 */
@property (nonatomic, assign) NSInteger distance; // 距离
@property (nonatomic, assign) CLLocationCoordinate2D baiduCoor;
@property (nonatomic, strong) BMKPinAnnotationView *annotationView_sel;
@property (nonatomic, strong) WGLocationInfo *addressInfo;
@end

@implementation WG_NearViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
    self.geocodesearch.delegate = self;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil;
    self.geocodesearch.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"搜附近";
    
    [self.view insertSubview:self.menuView atIndex:0];
    [self.view insertSubview:self.mapView atIndex:0];
    [self.view addSubview:self.headView];
//    [self.view addSubview:self.infoView];
     [self.view insertSubview:self.infoView belowSubview:self.menuView];
    
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.navBar.mas_bottom);
        make.height.mas_equalTo(76);
    }];
    
    
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.menuView.mas_bottom);
        make.bottom.mas_equalTo(0);
    }];
    
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(70);
        make.bottom.mas_equalTo(0);
    }];
    
    
    self.distance = [[self.menuView.menuDistanceList firstObject] integerValue] * 1000;
    
    self.geocodesearch = [[BMKGeoCodeSearch alloc] init];
    
    [self wg_startLocation];
}
- (void)wg_startLocation {
    __weak typeof(self) weakself = self;
    WGLocationManager *locationManager = [WGLocationManager shareManager];
    if (locationManager.isCanLocation == NO) {
        [MBProgressHUD wg_message:@"定位功能不可用"];
        return;
    }
    [locationManager restartLocationWithSuccess:^(WGLocationManager *manager, WGLocationInfo *info) {
        __strong typeof(weakself) strongself = weakself;
        strongself.addressInfo = info;
        strongself.headView.address = info.detailAddress;
        [strongself getBaiduLocationWithInfo:info];
        
    } fail:^(WGLocationManager *manager, NSError *error) {
        [MBProgressHUD wg_message:@"定位失败"];
    }];
}
- (void)getBaiduLocationWithInfo:(WGLocationInfo *)info {
    CLLocation *location = info.location;
    NSDictionary *dict = BMKConvertBaiduCoorFrom(location.coordinate, BMK_COORDTYPE_GPS);
    if (dict) {
        CLLocationCoordinate2D baiduCoor = BMKCoorDictionaryDecode(dict);
        [self setupDataWithBaiduCoor:baiduCoor];
    }
}
- (void)setupDataWithBaiduCoor:(CLLocationCoordinate2D)baiduCoor {
    // 移除地图上的点
    [self.mapView removeOverlays:self.mapView.overlays];
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    [self.mapView setCenterCoordinate:baiduCoor animated:YES];
    [self wg_loadDataWithBadduCoor:baiduCoor];
}
- (void)wg_loadDataWithBadduCoor:(CLLocationCoordinate2D)baiduCoor {
    self.baiduCoor = baiduCoor;
    WGNearParam *param = [WGNearParam new];
    param.latitude = baiduCoor.latitude;
    param.longitude = baiduCoor.longitude;
    param.longitude = baiduCoor.longitude;
    param.distance = self.distance ;
    param.pageSize = 500;
    
    self.infoView.hidden = YES;
//    if (self.annotationView_sel) {
//        self.annotationView_sel.image = [UIImage imageNamed:@"baidu_location"];
//    }
    
    WGBaseRequest *request = [WGBaseRequest wg_requestWithUrl:[self requestUrl]];
    request.wg_parameters = [param wg_keyValues];
    [request wg_sendRequestWithCompletion:^(WGBaseResponse *response) {
        if (response.statusCode == 200) {
            // 移除地图上的点
            [self.mapView removeOverlays:self.mapView.overlays];
            [self.mapView removeAnnotations:self.mapView.annotations];
            NSMutableArray *dataArray = @[].mutableCopy;
            if ([response.responseJSON isKindOfClass:[NSDictionary class]]) {
                
                NSArray *items = response.responseJSON[@"items"];
                for (NSDictionary *dict in items) {
                    WGNearMapItem *mapItem = [WGNearMapItem wg_modelWithDictionry:dict];
                    
                    BMKPointAnnotation *item = [[BMKPointAnnotation alloc]init];
                    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){ [mapItem.baiduLatitude doubleValue],[mapItem.baiduLongitude doubleValue]};
                    item.coordinate = pt;
                    mapItem.item = item;
                    [dataArray wg_addObject:mapItem];
                    [self.mapView addAnnotation:item];
                }
                
            }
            self.dataArray = dataArray;
            if (self.dataArray.count == 0) {
                [MBProgressHUD wg_message:@"无数据"];
            } else {
                [self addOverlayViewWithBaiduCoor:baiduCoor];
            }
            
            
        }
    }];
    
}
//添加内置覆盖物
- (void)addOverlayViewWithBaiduCoor:(CLLocationCoordinate2D)baiduCoor {
    
    // 添加圆形覆盖物
    NSInteger radius = self.distance;
    self.circle = [BMKCircle circleWithCenterCoordinate:baiduCoor radius:radius];
    [self.mapView addOverlay:self.circle];
    
}
- (NSString *)requestUrl {
    return @"/linggb-ws/ws/0.1/person/queryByLocation";
}


#pragma mark - BMKMapViewDelegate
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay {
    if ([overlay isKindOfClass:[BMKCircle class]]) {
        BMKCircleView* circleView = [[BMKCircleView alloc] initWithOverlay:overlay];
        circleView.fillColor = [kColor_Gray_Back colorWithAlphaComponent:0.7];
        circleView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
        circleView.strokeColor = kColor_Blue;
        circleView.lineWidth = 1.5;
        
        return circleView;
    }
    return nil;
}
/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation {
    // 生成重用标示identifier
    NSString *AnnotationViewID = @"xidanMark";
    
    // 检查是否有重用的缓存
    BMKAnnotationView *annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        ((BMKPinAnnotationView*)annotationView).animatesDrop = NO;
    
    }
    //
    
    // 设置位置
    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
    // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
    annotationView.canShowCallout = NO;
    annotationView.image = [UIImage imageNamed:@"baidu_location"];
    // 设置是否可以拖拽
    annotationView.draggable = NO;
    
    return annotationView;
}
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view {
    [mapView bringSubviewToFront:view];
    [mapView setNeedsDisplay];
    WGLog(@"点击了地图图标");
    //获取当前的item
    WGNearMapItem *mapItem_current = nil;
    id annotation = view.annotation;
    for (WGNearMapItem *mapItem in self.dataArray) {
        if (mapItem.item == annotation) {
            mapItem_current = mapItem;
            break;
        }
    }
    
    if ([view isKindOfClass:[BMKPinAnnotationView class]]) {
        self.infoView.hidden = NO;
        if (self.annotationView_sel) {
            self.annotationView_sel.image = [UIImage imageNamed:@"baidu_location"];
        }
        view.image = [UIImage imageNamed:@"baidu_location_sel"];
        
        self.annotationView_sel = (BMKPinAnnotationView *)view;
        
        self.infoView.mapItem = mapItem_current;
    } else {
        self.infoView.hidden = YES;
    }
    
}
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
    self.infoView.hidden = YES;
    if (self.annotationView_sel) {
        self.annotationView_sel.image = [UIImage imageNamed:@"baidu_location"];
    }
}
- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    //    NSLog(@"didAddAnnotationViews");
}
#pragma mark - BMKGeoCodeSearchDelegate

- (void)onClickGeocodeWithKey:(NSString *)keys {
    self.geocodesearch.delegate = self;
    
    NSString *city = self.addressInfo.city ?:[WG_HomeTool homeInfo].city.city;
    city = [WG_HomeTool homeInfo].city.city;
    BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geocodeSearchOption.city = city;
    geocodeSearchOption.address = keys;
    BOOL flag = [_geocodesearch geoCode:geocodeSearchOption];
    if(flag) {
        NSLog(@"geo检索发送成功");
    } else {
//        NSLog(@"geo检索发送失败");
        [MBProgressHUD wg_message:@"获取位置信息失败"];
    }
}
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    self.geocodesearch.delegate = nil;
    if (error == 0) {
        [self onClickReverseGeocodeWithCoor:result.location];
        [self setupDataWithBaiduCoor:result.location];
    } else {
        if (error == BMK_SEARCH_RESULT_NOT_FOUND) {
            [MBProgressHUD wg_message:@"没有找到检索结果"];
        }
    }
}
#pragma mark - 反检索
- (void)onClickReverseGeocodeWithCoor:(CLLocationCoordinate2D)coordinate {
    self.geocodesearch.delegate = self;
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = coordinate;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag) {
//        NSLog(@"反geo检索发送成功");
    } else {
//        NSLog(@"反geo检索发送失败");
        [MBProgressHUD wg_message:@"获取位置信息失败"];
    }
}
#pragma mark 反向检索
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    self.geocodesearch.delegate = nil;
    if (error == 0) {
//        NSLog(@"address:%@",result.address);
        self.headView.address = result.address;
    } else {
        
    }
    
}

#pragma mark - getter && setter 
- (WGNearHeadView *)headView {
    if (!_headView) {
        _headView = [WGNearHeadView new];
        __weak typeof(self) weakself = self;
        _headView.searchHandle = ^(NSString *keywords) {
            __strong typeof(weakself) strongself = weakself;
            [strongself onClickGeocodeWithKey:keywords];
        };
        _headView.locationHandle = ^() {
            __strong typeof(weakself) strongself = weakself;
            [strongself wg_startLocation];
        };
    }
    return _headView;
}
- (WGNearMenuView *)menuView {
    if (!_menuView) {
        CGFloat menuY = kTopBarHeight+76;
        CGFloat menuH = 35;
        WGNearMenuView *menuView = [WGNearMenuView new];
        menuView.wg_top = menuY;
        menuView.wg_height = menuH;
        menuView.wg_width = kScreenWidth;
        __weak typeof(self) weakself = self;
        menuView.chooseDistanceHandle = ^(NSInteger distance) {
            __strong typeof(weakself) strongself = weakself;
            strongself.distance = distance * 1000;
            [strongself setupDataWithBaiduCoor:strongself.baiduCoor];
            strongself.infoView.hidden = YES;
            if (strongself.annotationView_sel) {
                strongself.annotationView_sel.image = [UIImage imageNamed:@"baidu_location"];
            }
        };
        _menuView = menuView;
    }
    return _menuView;
}
- (BMKMapView *)mapView {
    if (!_mapView) {
        BMKMapView *mapView = [[BMKMapView alloc] init];
        mapView.minZoomLevel = 12;
        mapView.maxZoomLevel = 20;
        mapView.delegate = self;
        mapView.zoomLevel = 14;
        mapView.isSelectedAnnotationViewFront = YES;
        mapView.showMapScaleBar = YES;
        mapView.userTrackingMode = BMKUserTrackingModeNone;
        //精度设置
        BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc]init];
        displayParam.isRotateAngleValid = true;//跟随态旋转角度是否生效
        displayParam.isAccuracyCircleShow = false;//精度圈是否显示
        //    displayParam.locationViewImgName= path;//定位图标名称
        displayParam.locationViewOffsetX = 0;//定位偏移量(经度)
        displayParam.locationViewOffsetY = 0;//定位偏移量（纬度）
        [mapView updateLocationViewWithParam:displayParam];
        
        _mapView = mapView;
    }
    return _mapView;
}
- (WGNearInfoView *)infoView {
    if (!_infoView) {
        _infoView = [WGNearInfoView new];
        _infoView.backgroundColor = [kColor_Black colorWithAlphaComponent:0.8];
        _infoView.hidden = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInfoView:)];
        [_infoView addGestureRecognizer:tap];
    }
    return _infoView;
}
- (void)tapInfoView:(UITapGestureRecognizer *)tap {
    WGNearInfoView *infoView = (WGNearInfoView *)tap.view;
    WGNearMapItem *mapItem = infoView.mapItem;
    if (mapItem) {
        WG_JobDetailViewController *jobVC = [WG_JobDetailViewController new];
        jobVC.homeItem = mapItem;
        [self wg_pushVC:jobVC];
    }
}
- (void)dealloc {
    _mapView.delegate = nil;
    _mapView = nil;
    self.geocodesearch.delegate = nil;
    self.geocodesearch = nil;
    
}

@end
