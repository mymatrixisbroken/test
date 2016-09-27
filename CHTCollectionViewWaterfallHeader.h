//
//  CHTCollectionViewWaterfallHeader.h
//  Demo
//
//  Created by Neil Kimmett on 21/10/2013.
//  Copyright (c) 2013 Nelson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "objectsArrayClass.h"
#import <CoreLocation/CoreLocation.h>
#import "FirebaseReferenceClass.h"


@interface CHTCollectionViewWaterfallHeader : UICollectionReusableView <CLLocationManagerDelegate>
@property UIButton *AtoZButton;
@property UIButton *nearMeButton;
@property     CLLocationManager *locationManager;
@property     NSString* destLat;
@property     NSString* destLon;


@end
