//
//  CHTCollectionViewWaterfallHeader.m
//  Demo
//
//  Created by Neil Kimmett on 21/10/2013.
//  Copyright (c) 2013 Nelson. All rights reserved.
//

#import "CHTCollectionViewWaterfallHeader.h"

@implementation CHTCollectionViewWaterfallHeader

#pragma mark - Accessors
- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {

      
      _nearMeButton = [UIButton buttonWithType:UIButtonTypeCustom];
      _nearMeButton.frame = CGRectMake(0, 0, CGRectGetWidth(frame)/3, 40.f);
      [_nearMeButton setImage:[UIImage imageNamed:@"nearme"] forState:UIControlStateNormal];
      [_nearMeButton setTintColor:[UIColor lightGrayColor]];
      [_nearMeButton addTarget:self action:@selector(tappedNearMeButton:) forControlEvents:UIControlEventTouchUpInside];

      _visitedButton = [UIButton buttonWithType:UIButtonTypeCustom];
      _visitedButton.frame = CGRectMake(CGRectGetWidth(frame)/3, 0, CGRectGetWidth(frame)/3, 40.f);
      [_visitedButton setImage:[UIImage imageNamed:@"visited"] forState:UIControlStateNormal];
      [_visitedButton setTintColor:[UIColor lightGrayColor]];
      [_visitedButton addTarget:self action:@selector(tappedVisitedButton:) forControlEvents:UIControlEventTouchUpInside];

      _AtoZButton = [UIButton buttonWithType:UIButtonTypeSystem];
      _AtoZButton.frame = CGRectMake((CGRectGetWidth(frame)/3)*2, 0, CGRectGetWidth(frame)/3, 40.f);
      [_AtoZButton setImage:[UIImage imageNamed:@"A-Z-icon"] forState:UIControlStateNormal];
      [_AtoZButton setTintColor:[UIColor lightGrayColor]];
      [_AtoZButton addTarget:self action:@selector(tappedAtoZButton:) forControlEvents:UIControlEventTouchUpInside];

      
      self.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1];
      [self addSubview:_nearMeButton];
      [self addSubview:_visitedButton];
      [self addSubview:_AtoZButton];
  }
  return self;
}



- (IBAction)tappedAtoZButton:(UIButton *)sender {
    if(objectsArray.selection ==0){
    [objectsArray.strainObjectArray sortUsingDescriptors:
     @[
       [NSSortDescriptor sortDescriptorWithKey:@"strainName" ascending:YES selector:@selector(caseInsensitiveCompare:)]
       ]];
    }
    else{
        [objectsArray.storeObjectArray sortUsingDescriptors:
         @[
           [NSSortDescriptor sortDescriptorWithKey:@"storeName" ascending:YES selector:@selector(caseInsensitiveCompare:)]
           ]];
    }
    objectsArray.searchType = @"AtoZ";
    NSLog(@"search type is %@", objectsArray.searchType);
    
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *vc = [sb instantiateViewControllerWithIdentifier:@"List View Controller  SB ID"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIViewController *rootViewController = window.rootViewController;
    [rootViewController presentViewController:vc animated:YES completion:NULL];
}


- (IBAction)tappedNearMeButton:(UIButton *)sender {
    objectsArray.searchType = @"NearMe";
    NSLog(@"search type is %@", objectsArray.searchType);
    
    
    CLGeocoder *ceo;
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [self.locationManager requestWhenInUseAuthorization];
    
    [_locationManager startUpdatingLocation];
    
    
    ceo= [[CLGeocoder alloc]init];
    [self.locationManager requestWhenInUseAuthorization];
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    CLLocationCoordinate2D coordinate;
    
    coordinate.latitude=_locationManager.location.coordinate.latitude;
    coordinate.longitude=_locationManager.location.coordinate.longitude;
    NSLog(@"latitude is %f",coordinate.latitude);
    NSLog(@"longitude is %f",coordinate.longitude);
    
    [[[firebaseRef.storesRef child:@"-KSd2avxhUxLo-IXPf8w"] child:@"location"]observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        NSLog(@"snapshot is %@", snapshot.value);
        _destLat = [snapshot.value valueForKey:@"latitude"];
        _destLon = [snapshot.value valueForKey:@"longitude"];
        
        NSString *geocodingBaseURL = @"https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=";
        NSString *url = [NSString stringWithFormat:@"%@%f,%f&destinations=%@,%@&key=AIzaSyAsZ171sgZHuTcapToLRQ5-W9dl_WRLOh4", geocodingBaseURL, coordinate.latitude,coordinate.longitude,_destLat,_destLon];
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *queryURL = [NSURL URLWithString:url];
        NSData *data = [NSData dataWithContentsOfURL:queryURL];
        
        NSError *error;
        NSDictionary *json = [NSJSONSerialization
                              JSONObjectWithData:data
                              options:kNilOptions
                              error:&error];
        NSArray *results = [json objectForKey:@"results"];
        NSDictionary *result = [results objectAtIndex:0];
        NSDictionary *geometry = [result objectForKey:@"geometry"];
        NSDictionary *location = [geometry objectForKey:@"location"];
        
        NSLog(@"results are %@",json    );
        NSLog(@"URL is  %@",url    );
        
        //        Do this after you updated your array [user goToStrainsStoresViewController:self];
        
    }];
    
    
    
    
    //    //CLLocationCoordinate2D  ctrpoint;
    //    //  ctrpoint.latitude = ;
    //    //ctrpoint.longitude =f1;
    //    //coordinate.latitude=23.6999;
    //    //coordinate.longitude=75.000;
    //    NSLog(@"%f",coordinate.latitude);
    //    //[self.mapView addAnnotation:marker];
    //
    //
    //    CLLocation *loc = [[CLLocation alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude
    //                       ];
    //    [ceo reverseGeocodeLocation:loc
    //              completionHandler:^(NSArray *placemarks, NSError *error) {
    //                  CLPlacemark *placemark = [placemarks objectAtIndex:0];
    //                  NSLog(@"placemark %@",placemark);
    //                  //String to hold address
    //                  NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
    //                  NSLog(@"addressDictionary %@", placemark.addressDictionary);
    //
    //                  NSLog(@"placemark %@",placemark.region);
    //                  NSLog(@"placemark %@",placemark.country);  // Give Country Name
    //                  NSLog(@"placemark %@",placemark.locality); // Extract the city name
    //                  NSLog(@"location %@",placemark.name);
    //                  NSLog(@"location %@",placemark.ocean);
    //                  NSLog(@"location %@",placemark.postalCode);
    //                  NSLog(@"location %@",placemark.subLocality);
    //
    //                  NSLog(@"location %@",placemark.location);
    //                  //Print the location to console
    //                  NSLog(@"I am currently at %@",locatedAt);
    //                  
    //                  
    //                  [_locationManager stopUpdatingLocation];
    //              }
    //     
    //     ];


}


@end
