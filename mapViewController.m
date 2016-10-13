//
//  mapViewController.m
//  myProject
//
//  Created by Guy on 10/12/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "mapViewController.h"

@interface mapViewController ()

@end

@implementation mapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    CLGeocoder *ceo;
//    _locationManager = [[CLLocationManager alloc] init];
//    _locationManager.delegate = self;
//    _locationManager.distanceFilter = kCLDistanceFilterNone;
//    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
//        [self.locationManager requestWhenInUseAuthorization];
//    
//    [_locationManager startUpdatingLocation];
//    
//    
//    ceo= [[CLGeocoder alloc]init];
//    [self.locationManager requestWhenInUseAuthorization];
//    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
//        [self.locationManager requestWhenInUseAuthorization];
//    }
//    CLLocationCoordinate2D coordinate;
//    
//    coordinate.latitude=_locationManager.location.coordinate.latitude;
//    coordinate.longitude=_locationManager.location.coordinate.longitude;
//    
    NSLog(@"latitude is %f", user.latitude);
    NSLog(@"longitude is %f", user.longitude);

    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:user.latitude
                                                            longitude:user.longitude
                                                                 zoom:10];
    GMSMapView *mapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    mapView.delegate = self;
    mapView.myLocationEnabled = true;
    self.view = mapView;
    
//    [_locationManager stopUpdatingLocation];

    
    
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(user.latitude, user.longitude);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    marker.title = @"I'm here";
    marker.map = mapView;
    marker.tappable = NO;
    
    for (int i = 0; i < objectsArray.storeObjectArray.count; i++) {
        storeClass *tempStore = [objectsArray.storeObjectArray objectAtIndex:i];
        
        double lat = [tempStore.latitude doubleValue];
        double lon = [tempStore.longitude doubleValue];
        
        CLLocationCoordinate2D position = CLLocationCoordinate2DMake(lat, lon);
        GMSMarker *marker = [GMSMarker markerWithPosition:position];
        marker.icon = [UIImage imageNamed:@"green marker"];
        marker.infoWindowAnchor = CGPointMake(0.44f, 0.45f);
//        marker.title = tempStore.storeName;
        marker.map = mapView;
        
        NSString *str = [NSString stringWithFormat: @"%ld", (long)i];
        marker.userData = str;
}
    
    
    
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.8683
//                                                            longitude:151.2086
//                                                                 zoom:16];
//    GMSMapView *mapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
//    mapView.myLocationEnabled = true;
//    self.view = mapView;
//    
//    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(-33.8683, 151.2086);
//    GMSMarker *marker = [GMSMarker markerWithPosition:position];
//    marker.title = @"Sydney";
//    marker.map = mapView;

}

//- (BOOL)mapView:(GMSMapView*)mapView didTapMarker:(GMSMarker*)marker{
//    [mapView setSelectedMarker:marker];
//    return YES;
//}

-(UIView *) mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker{
    markerInfoView *infoWindow = [[[NSBundle mainBundle] loadNibNamed:@"markerInfoView" owner:self options:nil] objectAtIndex:0];

//    markerInfoView *view =  [[mapInfoView alloc] initWithFrame:marker.];
    NSInteger i = [marker.userData integerValue];
    
    storeClass *tempStore = [objectsArray.storeObjectArray objectAtIndex:i];

    
    infoWindow.storeNameLabel.text = tempStore.storeName;
    infoWindow.starRatingView.value = tempStore.ratingScore;
    infoWindow.reviewCountLabel.text = [[NSString stringWithFormat: @"%ld", (long)tempStore.ratingCount] stringByAppendingString:@"reviews"];
    
    return infoWindow;
}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end