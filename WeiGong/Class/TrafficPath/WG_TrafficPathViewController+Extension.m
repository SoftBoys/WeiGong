//
//  WG_TrafficPathViewController+Extension.m
//  NewWGProject
//
//  Created by dfhb@rdd on 16/11/18.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "WG_TrafficPathViewController+Extension.h"
#import <MapKit/MapKit.h>
#import "WG_JobDetail.h"

@implementation WG_TrafficPathViewController (Extension)

- (void)wg_appleMap {
    
    CLLocationCoordinate2D coords2 = CLLocationCoordinate2DMake(self.item.gaodeLat, self.item.gaodeLon);
    
    MKMapItem *fromLocation = [MKMapItem mapItemForCurrentLocation];
    //目的地的位置
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coords2 addressDictionary:nil]];
    toLocation.name = self.item.jobAddress ?: @"目的地";
    
    NSArray *items = @[fromLocation, toLocation];
    
    NSDictionary *options = @{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
//                              MKLaunchOptionsMapTypeKey: [NSNumber numberWithInteger:MKMapTypeStandard],
                              MKLaunchOptionsShowsTrafficKey:@YES};

    //打开苹果自身地图应用，并呈现特定的item
    [MKMapItem openMapsWithItems:items launchOptions:options];
}
- (void)wg_baiduMap {
    NSString *head = @"baidumap://map/direction?";
    NSDictionary *params = @{@"origin":@"{{我的位置}}",
                             @"destination":[NSString stringWithFormat:@"latlng:%f,%f|name=%@", self.item.baiduLat, self.item.baiduLon, self.item.jobAddress],
                             @"coord_type":@"bd09ll",
                             @"mode":@"driving"};
    
    NSMutableString *muPath = head.mutableCopy;
    for (NSString *key in params.allKeys) {
        [muPath appendFormat:@"%@=",key];
        [muPath appendFormat:@"%@&",params[key]];
    }
    
    NSString *url = [[muPath substringToIndex:muPath.length-1] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    
}
- (void)wg_gaodeMap {
    
    NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",@"微工",@"NewWeigong",self.item.gaodeLat, self.item.gaodeLon] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

@end
