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
    objectsArray.strainOrStore = 1;
    objectsArray.filterSelected = loadObjects;
    [user goToStrainsStoresViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*- (void) restructureDB{
    [[[[firebaseRef.ref child:@"googlePlaceID"] child:@"storeKey"] child:@"googlePlaceID"] setValue:@"true"];
    [[[[[firebaseRef.ref child:@"images"] child:@"stores"] child:@"storeKey"] child:@"imageKey"] setValue:@"true"];
    [[[[[firebaseRef.ref child:@"images"] child:@"users"] child:@"userKey"] child:@"imageKey"] setValue:@"true"];
    [[[[[firebaseRef.ref child:@"images"] child:@"strains"] child:@"strainKey"] child:@"imageKey"] setValue:@"true"];
    [[[[firebaseRef.ref child:@"imageData"] child:@"imageKey"] child:@"imagePath"] setValue:@"<imagePath>"];
    [[[[firebaseRef.ref child:@"thumbsDown"] child:@"imageKey"] child:@"userKey"] setValue:@"true"];
    [[[[firebaseRef.ref child:@"thumbsUp"] child:@"imageKey"] child:@"userKey"] setValue:@"true"];
    [[[[firebaseRef.ref child:@"location"] child:@"storeKey"] child:@"address"] setValue:@"<address>"];
    [[[[firebaseRef.ref child:@"location"] child:@"storeKey"] child:@"city"] setValue:@"<city>"];
    [[[[firebaseRef.ref child:@"location"] child:@"storeKey"] child:@"latitude"] setValue:@"<latitude>"];
    [[[[firebaseRef.ref child:@"location"] child:@"storeKey"] child:@"longitude"] setValue:@"<longitude>"];
    [[[[firebaseRef.ref child:@"location"] child:@"storeKey"] child:@"state"] setValue:@"<state>"];
    [[[[firebaseRef.ref child:@"location"] child:@"storeKey"] child:@"county"] setValue:@"<county>"];
    [[[[firebaseRef.ref child:@"location"] child:@"storeKey"] child:@"zipcode"] setValue:@"<zipcode>"];
    [[[[[firebaseRef.ref child:@"starRating"] child:@"stores"] child:@"storeKey"] child:@"userKey"] setValue:@"<rating>"];
    [[[[[firebaseRef.ref child:@"starRating"] child:@"strains"] child:@"strainKey"] child:@"userKey"] setValue:@"<rating>"];
    [[[[[firebaseRef.ref child:@"reviews"] child:@"stores"] child:@"storeKey"] child:@"userKey"] setValue:@"reviewKey"];
    [[[[[firebaseRef.ref child:@"reviews"] child:@"strains"] child:@"strainKey"] child:@"userKey"] setValue:@"reviewKey"];
    [[[[firebaseRef.ref child:@"reviewData"] child:@"reviewKey"] child:@"message"] setValue:@"<string>"];
    [[[[firebaseRef.ref child:@"reviewData"] child:@"reviewKey"] child:@"objectimageKey"] setValue:@"<string>"];
    [[[[firebaseRef.ref child:@"reviewData"] child:@"reviewKey"] child:@"objectKey"] setValue:@"<string>"];
    [[[[firebaseRef.ref child:@"reviewData"] child:@"reviewKey"] child:@"objectType"] setValue:@"<string>"];
    [[[[firebaseRef.ref child:@"reviewData"] child:@"reviewKey"] child:@"rating"] setValue:@"<string>"];
    [[[[firebaseRef.ref child:@"reviewData"] child:@"reviewKey"] child:@"userKey"] setValue:@"<string>"];
    [[[[firebaseRef.ref child:@"reviewData"] child:@"reviewKey"] child:@"username"] setValue:@"<string>"];
    [[[[firebaseRef.ref child:@"inventory"] child:@"storeKey"] child:@"strainKey"] setValue:@"true"];
    [[[[[[firebaseRef.ref child:@"metrics"] child:@"stores"] child:@"storeKey"] child:@"dailyViews"] child:@"01-Jan-2017"] setValue:@"integer"];
    [[[[[[firebaseRef.ref child:@"metrics"] child:@"stores"] child:@"storeKey"] child:@"dailyViews"] child:@"02-Jan-2017"] setValue:@"integer"];
    [[[[[[firebaseRef.ref child:@"metrics"] child:@"stores"] child:@"storeKey"] child:@"monthlyViews"] child:@"January 2017"] setValue:@"integer"];
    [[[[[[firebaseRef.ref child:@"metrics"] child:@"stores"] child:@"storeKey"] child:@"monthlyViews"] child:@"February 2017"] setValue:@"integer"];
    [[[[[firebaseRef.ref child:@"metrics"] child:@"stores"] child:@"storeKey"] child:@"totalViews"] setValue:@"integer"];
    [[[[[[firebaseRef.ref child:@"metrics"] child:@"strains"] child:@"strainKey"] child:@"dailyViews"] child:@"01-Jan-2017"] setValue:@"integer"];
    [[[[[[firebaseRef.ref child:@"metrics"] child:@"strains"] child:@"strainKey"] child:@"dailyViews"] child:@"02-Jan-2017"] setValue:@"integer"];
    [[[[[[firebaseRef.ref child:@"metrics"] child:@"strains"] child:@"strainKey"] child:@"monthlyViews"] child:@"January 2017"] setValue:@"integer"];
    [[[[[[firebaseRef.ref child:@"metrics"] child:@"strains"] child:@"strainKey"] child:@"monthlyViews"] child:@"February 2017"] setValue:@"integer"];
    [[[[[firebaseRef.ref child:@"metrics"] child:@"strains"] child:@"strainKey"] child:@"totalViews"] setValue:@"integer"];
    [[[[firebaseRef.ref child:@"storeNames"] child:@"storeKey"] child:@"name"] setValue:@"NSString"];
    [[[[firebaseRef.ref child:@"storeURL"] child:@"storeKey"] child:@"url"] setValue:@"NSString"];
    [[[[firebaseRef.ref child:@"phoneNumbers"] child:@"storeKey"] child:@"phoneNumber"] setValue:@"NSInteger"];
    [[[[firebaseRef.ref child:@"accountTypes"] child:@"userKey"] child:@"type"] setValue:@"user || storeOwner || moderator"];
    [[[[firebaseRef.ref child:@"badges"] child:@"userKey"] child:@"badgeKey"] setValue:@"true"];
    [[[[firebaseRef.ref child:@"checkIns"] child:@"userKey"] child:@"checkInKey"] setValue:@"storeKey"];
    [[[[firebaseRef.ref child:@"dateJoined"] child:@"userKey"] child:@"dateJoined"] setValue:@"NSDate"];
    [[[[firebaseRef.ref child:@"emails"] child:@"userKey"] child:@"email"] setValue:@"NSString"];
    [[[[firebaseRef.ref child:@"friendRequestOutbound"] child:@"userKey"] child:@"toUserKey"] setValue:@"NSString"];
    [[[[firebaseRef.ref child:@"friendRequestInbound"] child:@"userKey"] child:@"fromUserKey"] setValue:@"NSString"];
    [[[[firebaseRef.ref child:@"friends"] child:@"userKey"] child:@"userKey2"] setValue:@"true"];
    [[[[firebaseRef.ref child:@"friends"] child:@"userKey"] child:@"userKey3"] setValue:@"true"];
    [[[[firebaseRef.ref child:@"friends"] child:@"userKey2"] child:@"userKey"] setValue:@"true"];
    [[[[firebaseRef.ref child:@"friends"] child:@"userKey3"] child:@"userKey"] setValue:@"true"];
    [[[[firebaseRef.ref child:@"lastSignedIn"] child:@"userKey"] child:@"date"] setValue:@"NSDate"];
    [[[[firebaseRef.ref child:@"storesVisited"] child:@"userKey"] child:@"storeKey"] setValue:@"true"];
    [[[[firebaseRef.ref child:@"strainsTried"] child:@"userKey"] child:@"strainKey"] setValue:@"true"];
    [[[[firebaseRef.ref child:@"usernames"] child:@"userKey"] child:@"username"] setValue:@"NSString"];
    [[[[firebaseRef.ref child:@"wishLists"] child:@"userKey"] child:@"strainKey"] setValue:@"true"];
    [[[[firebaseRef.ref child:@"aroma"] child:@"strainKey"] child:@"aroma"] setValue:@"NSString"];
    [[[[firebaseRef.ref child:@"availableAt"] child:@"strainKey"] child:@"storeKey"] setValue:@"true"];
    [[[[firebaseRef.ref child:@"CBD"] child:@"strainKey"] child:@"CBD"] setValue:@"NSInteger"];
    [[[[[firebaseRef.ref child:@"consumptionForm"] child:@"storeKey"] child:@"strainKey"] child:@"bud"] setValue:@"NSInteger"];
    [[[[[firebaseRef.ref child:@"consumptionForm"] child:@"storeKey"] child:@"strainKey"] child:@"concentrate"] setValue:@"NSInteger"];
    [[[[[firebaseRef.ref child:@"consumptionForm"] child:@"storeKey"] child:@"strainKey"] child:@"edible"] setValue:@"NSInteger"];
    [[[[[firebaseRef.ref child:@"consumptionForm"] child:@"storeKey"] child:@"strainKey"] child:@"topical"] setValue:@"NSInteger"];
    [[[[[firebaseRef.ref child:@"consumptionForm"] child:@"storeKey"] child:@"strainKey"] child:@"grass"] setValue:@"NSInteger"];
    [[[[firebaseRef.ref child:@"flavor"] child:@"strainKey"] child:@"flavor"] setValue:@"NSString"];
    [[[[firebaseRef.ref child:@"grower"] child:@"strainKey"] child:@"grower"] setValue:@"NSString"];
    [[[[firebaseRef.ref child:@"highType"] child:@"strainKey"] child:@"energetic"] setValue:@"NSInteger"];
    [[[[firebaseRef.ref child:@"highType"] child:@"strainKey"] child:@"euphoric"] setValue:@"NSInteger"];
    [[[[firebaseRef.ref child:@"highType"] child:@"strainKey"] child:@"happiness"] setValue:@"NSInteger"];
    [[[[firebaseRef.ref child:@"highType"] child:@"strainKey"] child:@"relxed"] setValue:@"NSInteger"];
    [[[[firebaseRef.ref child:@"highType"] child:@"strainKey"] child:@"uplifting"] setValue:@"NSInteger"];
    [[[[firebaseRef.ref child:@"species"] child:@"strainKey"] child:@"species"] setValue:@"Sative || Indica"];
    [[[[firebaseRef.ref child:@"strainNames"] child:@"strainKey"] child:@"strainname"] setValue:@"NSString"];
    [[[[firebaseRef.ref child:@"THC"] child:@"strainKey"] child:@"THC"] setValue:@"NSInteger"];
    [[[[[firebaseRef.ref child:@"storesViewdInCheeba"] child:@"userKey"] child:@"sponsor1"] child:@"count"] setValue:@"NSInteger"];
    [[[[[firebaseRef.ref child:@"storesViewdInCheeba"] child:@"userKey"] child:@"sponsor2"] child:@"count"] setValue:@"NSInteger"];
    [[[[firebaseRef.ref child:@"uniqueUsersViewedInCheeba"] child:@"storeKey"] child:@"userKey"] setValue:@"true"];
    [[[firebaseRef.ref child:@"userKey"] child:@"sponsoredIndex"] setValue:@"2 || 4"];
    [[[[[firebaseRef.ref child:@"sponsorsSeen"] child:@"userKey"] child:@"sponsor1"] child:@"seenAtIndex2"] setValue:@"NSInteger"];
    [[[[[firebaseRef.ref child:@"sponsorsSeen"] child:@"userKey"] child:@"sponsor1"] child:@"seenAtIndex4"] setValue:@"NSInteger"];
    [[[[[firebaseRef.ref child:@"sponsorsSeen"] child:@"userKey"] child:@"sponsor2"] child:@"seenAtIndex2"] setValue:@"NSInteger"];
    [[[[[firebaseRef.ref child:@"sponsorsSeen"] child:@"userKey"] child:@"sponsor2"] child:@"seenAtIndex4"] setValue:@"NSInteger"];
    [[[[firebaseRef.ref child:@"sponsors"] child:@"sponsor1"] child:@"image"] setValue:@"NSString"];
    [[[[firebaseRef.ref child:@"sponsors"] child:@"sponsor1"] child:@"zipcode"] setValue:@"NSString"];
    [[[[firebaseRef.ref child:@"sponsors"] child:@"sponsor1"] child:@"numberOfViewsAtIndex2"] setValue:@"NSIteger"];
    [[[[firebaseRef.ref child:@"sponsors"] child:@"sponsor1"] child:@"numberOfViewsAtIndex4"] setValue:@"NSIteger"];
}*/

@end
