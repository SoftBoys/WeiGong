//
//  WG_TrafficPathViewController.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/11.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_TrafficPathViewController.h"
#import "WG_JobDetail.h"
#import "WGLocationManager.h"
#import "WG_TrafficPathViewController+Extension.h"

#import "WG_HomeTool.h"
#import "WG_CityItem.h"
#import "WGHomeInfo.h"

#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import <BaiduMapAPI_Map/BMKPolylineView.h>
#import <BaiduMapAPI_Map/BMKPolyline.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>
#import <BaiduMapAPI_Search/BMKRouteSearch.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>

#import "WGLocationManager.h"
#import <BaiduMapAPI_Utils/BMKGeometry.h>

@interface WG_PointAnnotation : BMKPointAnnotation
/** 0起点,1终点,2公交,3地铁,4驾乘,5途经点 */
@property (nonatomic, assign) NSUInteger type;
@property (nonatomic, assign) NSUInteger degree;
@end
@implementation WG_PointAnnotation
@end

@interface WG_TrafficPathViewController () <BMKMapViewDelegate, BMKGeoCodeSearchDelegate, BMKRouteSearchDelegate>
@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, strong) BMKLocationService *locationService;
@property (nonatomic, strong) BMKGeoCodeSearch *geoSearch;
@property (nonatomic, strong) BMKRouteSearch *routeSearch;
@end
@implementation WG_TrafficPathViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
    self.geoSearch.delegate = self;
    self.routeSearch.delegate = self;
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil;
    self.geoSearch.delegate = nil;
    self.routeSearch.delegate = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"交通路线";
    [self wg_initMap];
}
- (void)wg_initMap {
    self.mapView = [BMKMapView new];
    self.mapView.delegate = self;
    self.mapView.zoomLevel = 14;
    [self.view addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.top.mas_equalTo(kTopBarHeight);
    }];
    
    UIButton *locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    locationBtn.backgroundColor = [UIColor redColor];
    [locationBtn addTarget:self action:@selector(wg_locationBtnClick) forControlEvents:UIControlEventTouchUpInside];
    locationBtn.titleLabel.font = kFont_15;
    [locationBtn setTitleColor:kColor_White forState:UIControlStateNormal];
    [locationBtn setTitle:@"导航" forState:UIControlStateNormal];
    [locationBtn setImage:[UIImage imageNamed:@"icon_location"] forState:UIControlStateNormal];
    
    UIImage *backImage = [[[UIImage wg_imageWithColor:kColor_Black size:CGSizeMake(10, 10)] wg_imageWithCornerRadius:3] wg_resizedImage];
    [locationBtn setBackgroundImage:backImage forState:UIControlStateNormal];
    
    [self.view addSubview:locationBtn];
    [locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(35);
    }];
    
    __weak typeof(self) weakself = self;
    WGLocationManager *locationManager = [WGLocationManager shareManager];
    if (locationManager.isCanLocation == NO) {
        [MBProgressHUD wg_message:@"定位功能不可用"];
        return;
    }
    [locationManager startLocationWithSuccess:^(WGLocationManager *manager, WGLocationInfo *info) {
        __strong typeof(weakself) strongself = weakself;
        [strongself getBaiduLocationWithInfo:info];
        
    } fail:^(WGLocationManager *manager, NSError *error) {
        [MBProgressHUD wg_message:@"定位失败"];
    }];
    
    self.geoSearch = [BMKGeoCodeSearch new];
    self.geoSearch.delegate = self;
    
    self.routeSearch = [BMKRouteSearch new];
    self.routeSearch.delegate = self;
    
//    [self wg_location];
}
- (void)getBaiduLocationWithInfo:(WGLocationInfo *)info {
    CLLocation *location = info.location;
    NSDictionary *dict = BMKConvertBaiduCoorFrom(location.coordinate, BMK_COORDTYPE_GPS);
    if (dict) {
        CLLocationCoordinate2D baiduCoor = BMKCoorDictionaryDecode(dict);
        [self wg_reDrawLinesWithBaiduCoor:baiduCoor city:info.city];
    }
}

- (void)wg_locationBtnClick {
    NSString *title = nil;
    NSString *message = nil;
    NSMutableArray *others = @[@"苹果地图"].mutableCopy;
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        [others addObject:@"百度地图"];
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        [others addObject:@"高德地图"];
    }
    
    [UIAlertController wg_actionSheetWithTitle:title message:message completion:^(UIAlertController *alert, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [self wg_appleMap];
        } else if (buttonIndex == 2) {
            [self wg_baiduMap];
        } else if (buttonIndex == 3) {
            [self wg_gaodeMap];
        }
    } cancel:@"取消" others:others];
    
}

/** 重绘线路 */
- (void)wg_reDrawLinesWithBaiduCoor:(CLLocationCoordinate2D)coordinate city:(NSString *)city {
    
    [self.mapView setCenterCoordinate:coordinate animated:YES];
    
//    WG_CityItem *cityItem = [WG_HomeTool homeInfo].city;
    
    BMKPlanNode *begin = [[BMKPlanNode alloc]init];
//    begin.cityName = cityItem.city;
    begin.pt = coordinate;
    
    BMKPlanNode *end = [[BMKPlanNode alloc]init];
//    end.cityName = cityItem.city;
    end.pt = CLLocationCoordinate2DMake(self.item.baiduLat, self.item.baiduLon);
    
    BMKTransitRoutePlanOption *routePlanOption = [[BMKTransitRoutePlanOption alloc] init];
    routePlanOption.city = city;
    routePlanOption.from = begin;
    routePlanOption.to = end;
    
    BOOL flag = [self.routeSearch transitSearch:routePlanOption];
    if (!flag) {
        [MBProgressHUD wg_message:@"搜索路线失败"];
    } else {
        
    }
}

#pragma mark - BMKRouteSearchDelegate 
- (void)onGetTransitRouteResult:(BMKRouteSearch*)searcher result:(BMKTransitRouteResult*)result errorCode:(BMKSearchErrorCode)error {
    NSString *errorMessage = [self wg_errorMessageWithCode:error];
    if (errorMessage) {
        [MBProgressHUD wg_message:errorMessage];
    }
    if (error == BMK_SEARCH_NO_ERROR) {
        
        NSArray* array = [NSArray arrayWithArray:self.mapView.annotations];
        [self.mapView removeAnnotations:array];
        array = [NSArray arrayWithArray:_mapView.overlays];
        [self.mapView removeOverlays:array];
        
        BMKTransitRouteLine *plan = [result.routes firstObject];
        NSUInteger count = [plan.steps count];
        for (NSUInteger i = 0; i < count; i++) {
            BMKTransitStep *step = plan.steps[i];
            WG_PointAnnotation *point = [WG_PointAnnotation new];
            point.coordinate = step.entrace.location;
            point.type = 3;
            point.title = step.instruction;
            if (i == 0) {
                point.coordinate = plan.starting.location;
                point.type = 0;
                point.title = self.locationService.userLocation.title;
            } else if (i == count-1) {
                point.coordinate = plan.terminal.location;
                point.type = 1;
                point.title = self.item.jobAddress;
            }
            [self.mapView addAnnotation:point];
            
            BMKPolyline *line = [BMKPolyline polylineWithPoints:step.points count:step.pointsCount];
            [self.mapView addOverlay:line];
        }
        
    }
}
#pragma mark - BMKMapViewDelegate
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(WG_PointAnnotation *)annotation {
    if ([annotation isKindOfClass:[WG_PointAnnotation class]]) {
        BMKAnnotationView *view = nil;
        CGPoint centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
        NSString *imageName = @"images/icon_nav_start.png";
        NSString *identity = @"start_node";
        NSUInteger type = annotation.type;
        if (type == 1) {
            identity = @"end_node";
            imageName = @"images/icon_nav_end.png";
        } else if (type == 2) {
            identity = @"bus_node";
            imageName = @"images/icon_nav_bus.png";
        } else if (type == 3) {
            identity = @"rail_node";
            imageName = @"images/icon_nav_rail.png";
        } else if (type == 4) {
            identity = @"route_node";
            imageName = @"images/icon_direction.png";
        } else if (type == 4) {
            identity = @"route_node";
            imageName = @"images/icon_direction.png";
        }
        
        
        view = [mapView dequeueReusableAnnotationViewWithIdentifier:identity];
        if (view == nil) {
            view = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identity];
        }
        view.centerOffset = centerOffset;
        view.canShowCallout = YES;
        view.image = [self wg_baiduImageWithNamed:imageName];
        view.annotation = annotation;
        return view;
        
    }
    return nil;
}
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay {
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView * polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:1];
//        polylineView.fillColor = kColor_Blue;
//        polylineView.strokeColor = kColor_Orange;
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.3];
        polylineView.lineWidth = 5.0;
        return polylineView;
    }
    return nil;
}

#pragma mark - private
- (UIImage *)wg_baiduImageWithNamed:(NSString *)fileName {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"mapapi.bundle" ofType:nil];
    NSMutableString *imagePath = bundlePath.mutableCopy;
    [imagePath appendFormat:@"/%@", fileName];
    return [UIImage imageWithContentsOfFile:imagePath];
}
- (NSString *)wg_errorMessageWithCode:(BMKSearchErrorCode)errorCode {
    NSString *message = nil;
    switch (errorCode) {
        case BMK_SEARCH_AMBIGUOUS_KEYWORD:
            message = @"检索词有岐义";
            break;
        case BMK_SEARCH_AMBIGUOUS_ROURE_ADDR:
            message = @"检索地址有岐义";
            break;
        case BMK_SEARCH_NOT_SUPPORT_BUS:
            message = @"该城市不支持公交搜索";
            break;
        case BMK_SEARCH_NOT_SUPPORT_BUS_2CITY:
            message = @"不支持跨城市公交";
            break;
        case BMK_SEARCH_ST_EN_TOO_NEAR:
            message = @"起终点太近";
            break;
        case BMK_SEARCH_NETWOKR_ERROR:
            message = @"网络连接错误";
            break;
        case BMK_SEARCH_NETWOKR_TIMEOUT:
            message = @"网络连接超时";
            break;
        case BMK_SEARCH_PERMISSION_UNFINISHED:
            message = @"还未完成鉴权，请在鉴权通过后重试";
            break;
            
        default:
            break;
    }
    
    return message;
}
@end


