//
//  FirstViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "AnonymousFirebaseSignin.h"

@interface AnonymousFirebaseSignin ()

@end

@implementation AnonymousFirebaseSignin

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadObjectInstance];
    [self signinFirebaseAnonymously];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) loadObjectInstance {
    strain = [strainClass sharedInstance];
    user = [userClass sharedInstance];
    store = [storeClass sharedInstance];
    objectsArray = [objectsArrayClass sharedInstance];
    event = [eventClass sharedInstance];
}

- (void) signinFirebaseAnonymously {
//    [[FIRAuth auth] addAuthStateDidChangeListener:^(FIRAuth *_Nonnull auth,
//                                                    FIRUser *_Nullable user) {
////        if (user != nil) {
////            // User is signed in.
////            [self loadCurrentLocation];
////        }
////        else {
////            FIRUser *youser = [FIRAuth auth].currentUser;
//            if (user.email == nil) {
//                [[FIRAuth auth] signInAnonymouslyWithCompletion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
//                    if (error != nil) {
//                        // Uh-oh, an error occurred!
//                        NSLog(@"Anonymous Firebase User is NOT signed in..");
//                        NSLog(@"%@", error.localizedDescription);
//                        //NSLog(@"UID:%@.",error.userInfo);
//                    }
//                    else {
//                        //Assign current Firebase user to a variable called user
//                        FIRUser *user = [FIRAuth auth].currentUser;
//                        BOOL isAnonymous = user.anonymous;  // YES
//                        NSLog(@"Anonymous Firebase User is signed in.. ");
//                        NSLog(isAnonymous ? @"Yes" : @"No");
//                        NSLog(@"UID:%@.",user.uid);
//                        //NSLog(@"ref %@ strains %@ stores %@ users %@", firebaseRef.ref, firebaseRef.strainsRef, firebaseRef.storesRef, firebaseRef.usersRef);
//                        [self loadCurrentLocation];
//                    }
//                }];
//            }
//            else{
//                [self loadCurrentLocation];
//            }
////        }
//    }];
    
    [[FIRAuth auth] signInAnonymouslyWithCompletion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        if (error != nil) {
            // Uh-oh, an error occurred!
            NSLog(@"Anonymous Firebase User is NOT signed in..");
            NSLog(@"%@", error.localizedDescription);
            //NSLog(@"UID:%@.",error.userInfo);
        }
        else {
            //Assign current Firebase user to a variable called user
            FIRUser *user = [FIRAuth auth].currentUser;
            BOOL isAnonymous = user.anonymous;  // YES
            NSLog(@"Anonymous Firebase User is signed in.. ");
            NSLog(isAnonymous ? @"Yes" : @"No");
            NSLog(@"UID:%@.",user.uid);
            //NSLog(@"ref %@ strains %@ stores %@ users %@", firebaseRef.ref, firebaseRef.strainsRef, firebaseRef.storesRef, firebaseRef.usersRef);
            [self loadCurrentLocation];
        }
    }];
}

-(void)loadCurrentLocation{
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
    
    NSLog(@"latitude is %f", coordinate.latitude);
    
    user.latitude = coordinate.latitude;
    user.longitude = coordinate.longitude;
    
    [_locationManager stopUpdatingLocation];
    
    [self loadfirebaseRef];
}

- (void) loadfirebaseRef {
    firebaseRef = [FirebaseReferenceClass sharedInstance];
    objectsArray.selection = 1;
    objectsArray.searchType = loadObjects;
    [user goToStrainsStoresViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
