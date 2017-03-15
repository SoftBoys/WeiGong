//
//  WGLocationManager.m
//  WGBaseDemo
//
//  Created by dfhb@rdd on 16/11/29.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WGLocationManager.h"
#import <AddressBookUI/AddressBookUI.h>

@interface WGLocationManager () <CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, copy) WGSuccessCallBack successBlock;
@property (nonatomic, copy) WGFailCallBack failBlock;
@end

@implementation WGLocationManager
@synthesize authStatus = _authStatus;
+ (instancetype)shareManager {
    static WGLocationManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[[self class] alloc] init];
    });
    return _manager;
}

- (void)startLocationWithSuccess:(WGSuccessCallBack)success fail:(WGFailCallBack)fail {
    if (self.isCanLocation) {
        if (self.authStatus == kWGAuthStatus_UnAuth) {
            if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                [self.locationManager requestWhenInUseAuthorization];
            }
            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [self.locationManager requestAlwaysAuthorization];
            }
        }
        /** 正在定位 */
        _resultStatus = kWGResultStatus_Loading;
        [self.locationManager startUpdatingLocation];
    } else {
        /** 不可定位 */
        _resultStatus = kWGResultStatus_Fail;
    }
    if (success) {
        self.successBlock = success;
    }
    if (fail) {
        self.failBlock = fail;
    }
#ifdef DEBUG
    NSLog(@"start--authStatus:%@ ", @(self.authStatus));
#endif
}
- (void)startLocation {
    [self startLocationWithSuccess:nil fail:nil];
}
- (void)stopLocation {
    if (self.isCanLocation) {
        [self.locationManager stopUpdatingLocation];
    }
}
- (void)restartLocation {
    [self stopLocation];
    [self startLocation];
}
- (void)restartLocationWithSuccess:(WGSuccessCallBack)success fail:(WGFailCallBack)fail {
    [self stopLocation];
    [self startLocationWithSuccess:success fail:fail];
}
#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *location = manager.location;
    if (location) {
        /** 定位成功 */
        _resultStatus = kWGResultStatus_Success;
        [self stopLocation];
        [self setLocationInfoWithLocation:location];
    }
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    /** 定位失败 */
    _resultStatus = kWGResultStatus_Fail;
    if ([self.delegate respondsToSelector:@selector(locationManager:fail:)]) {
        [self.delegate locationManager:self fail:error];
    }
    
    if (self.failBlock) {
        __weak typeof(self) weakself = self;
        self.failBlock(weakself, error);
    }
}
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    _authStatus = (WGAuthStatus)status;
    if (status != kWGAuthStatus_Denied) {
        [self restartLocation];
    }
#ifdef DEBUG
    NSLog(@"change--authStatus:%@ status:%@ ", @(self.authStatus), @(status));
#endif
}
#pragma mark - 设置Info
- (void)setLocationInfoWithLocation:(CLLocation *)location {
    if (location == nil) return;
    _location = location;
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count) {
            CLPlacemark *place = [placemarks firstObject];
            NSString *detailAddress = [(NSArray *)place.addressDictionary[@"FormattedAddressLines"] firstObject];
            
            // 需要引入AddressBookUI.framework类库
            NSString *address = ABCreateStringWithAddressDictionary(place.addressDictionary, YES);
            WGLocationInfo *info = [[WGLocationInfo alloc] init];
            info.name = place.name;
            info.country = place.country;
            info.province = place.administrativeArea;
            info.city = place.locality;
            info.subcity = place.subLocality;
            info.street = place.thoroughfare;
            info.substreet = place.subThoroughfare;
            info.detailAddress = detailAddress;
            info.address = address;
            info.location = location;
            _info = info;
            
            if ([self.delegate respondsToSelector:@selector(locationManager:successInfo:)]) {
                [self.delegate locationManager:self successInfo:info];
            }
            
            __weak typeof(self) weakself = self;
            if (self.successBlock) {
                self.successBlock(weakself, weakself.info);
            }
        }
    }];
}

#pragma mark - getter && setter
- (BOOL)isCanLocation {
    WGAuthStatus auth = self.authStatus;
    return [CLLocationManager locationServicesEnabled] && !(auth == kWGAuthStatus_Denied || auth == kWGAuthStatus_Restricted);
}
- (WGAuthStatus)authStatus {
    return (WGAuthStatus)[CLLocationManager authorizationStatus];
}
- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return _locationManager;
}
@end

@implementation WGLocationInfo
- (NSString *)description {
    return [NSString stringWithFormat:@"省(直辖市):%@ 市:%@ 区(县):%@ 街道:%@ 子街道:%@ 详细地址:%@", _province, _city, _subcity, _street, _substreet, _detailAddress];
}
@end
