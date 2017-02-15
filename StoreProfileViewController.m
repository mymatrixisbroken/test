//
//  FirstViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "StoreProfileViewController.h"

@interface StoreProfileViewController ()

@end

@implementation StoreProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadLabels];
    [self loadImageView];
    [self loadRatingScore];
    [self loadReviewsFromFirebase];
    _tabBar.delegate = self;
    
    
    CAGradientLayer *gradientMask = [CAGradientLayer layer];
    gradientMask.frame = _store_image_view.frame;
    gradientMask.colors = @[(id)[UIColor clearColor].CGColor, (id)[UIColor colorWithRed:1.0/255.0 green:1.0/255.0 blue:1.0/255.0 alpha:1.0].CGColor];
    gradientMask.startPoint = CGPointMake(0.5, 0.5);   // start at left middle
    gradientMask.endPoint = CGPointMake(0.5, 1.0);     // end at right middle

    [_store_image_view.layer addSublayer:gradientMask];
    
    _distanceLabel.textColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    _distanceLabel.font = [UIFont fontWithName:@"NEXA BOLD" size:7.0];
    _distanceLabel.userInteractionEnabled=NO;
    _distanceLabel.text = store.distanceToMe;
    _distanceLabel.textAlignment = NSTextAlignmentRight;
    
    _hoursLabel.textColor = [UIColor colorWithRed:254.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    _hoursLabel.font = [UIFont fontWithName:@"NEXA BOLD" size:9.0];
    _hoursLabel.userInteractionEnabled=NO;
    _hoursLabel.text = @"10:30AM - 11:30PM";
    _hoursLabel.textAlignment = NSTextAlignmentRight;


    _openNowLabel.textColor = [UIColor colorWithRed:8.0/255.0 green:197.0/255.0 blue:103.0/255.0 alpha:1.0];
    _openNowLabel.font = [UIFont fontWithName:@"NEXA BOLD" size:7.0];
    _openNowLabel.userInteractionEnabled=NO;
    _openNowLabel.text = @"Open Now";
    _openNowLabel.textAlignment = NSTextAlignmentRight;


    double lat = [store.latitude doubleValue];
    double lon = [store.longitude doubleValue];

    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:lat
                                                            longitude:lon
                                                                 zoom:16];
    GMSMapView *mapView = [GMSMapView mapWithFrame:_mapView.bounds camera:camera];
    mapView.delegate = self;
    mapView.myLocationEnabled = true;
    [_mapView addSubview: mapView];
    
    NSLog(@"store lat is %f",lat);
    NSLog(@"store long is %f",lon);
    
    
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(lat, lon);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
//    marker.iconView.frame = CGRectMake(0, 0, 5, 5);
    marker.icon = [UIImage imageNamed:@"markerSmartObject"];
    marker.icon = [self image:marker.icon scaledToSize:CGSizeMake(31.5f, 40.0f)];
//    marker.infoWindowAnchor = CGPointMake(0.44f, 0.45f);
    //        marker.title = tempStore.storeName;
    marker.map = mapView;
    
//    NSString *str = [NSString stringWithFormat: @"%ld", (long)i];
//    marker.userData = str;
    
    
    
    
    _tabBar.barTintColor = [UIColor colorWithRed:18.0/255.0 green:24.0/255.0 blue:23.0/255.0 alpha:1.0];
//    _tabBar.translucent = NO;
//    _aboutBarItem.title = nil;

    _aboutBarItem.image = [[UIImage imageNamed:@"aboutSmartObject"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    _aboutBarItem.selectedImage = [[UIImage imageNamed:@"aboutSmartObject"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    _strainsBarItem.image = [[UIImage imageNamed:@"StrainIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    _strainsBarItem.selectedImage = [[UIImage imageNamed:@"StrainIcon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    _reviewsBarItem.image = [[UIImage imageNamed:@"reviewsSmartObject"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    _reviewsBarItem.selectedImage = [[UIImage imageNamed:@"reviewsSmartObject"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

//    [_photosBarItem performSelectorOnMainThread:@selector(didTapPhotosBarItem) withObject:nil waitUntilDone:NO];
    _photosBarItem.enabled = YES;
    _photosBarItem.image = [[UIImage imageNamed:@"photosSmartObject"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    _photosBarItem.selectedImage = [[UIImage imageNamed:@"photosSmartObject"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    _favoriteBarItem.image = [[UIImage imageNamed:@"favoritesSmartObject"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    _favoriteBarItem.selectedImage = [[UIImage imageNamed:@"favoritesSmartObject"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    _aboutBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);


//    [_aboutBarItem setFinishedSelectedImage:[UIImage imageNamed:@"aboutSmartObject"] withFinishedUnselectedImage:[UIImage imageNamed:@"aboutSmartObject"]];

//    UIColor * unselectedColor = [UIColor clearColor];
//    // set color of unselected text
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:unselectedColor, NSForegroundColorAttributeName, nil]
//                                             forState:UIControlStateNormal];

//    _strainsBarItem.title = nil;
//    _reviewsBarItem.title = nil;
//    _photosBarItem.title = nil;
//    _favoriteBarItem.title = nil;
    
//    _aboutBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
//    _strainsBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
//    _reviewsBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
//    _photosBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
//    _favoriteBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    

    

    
    
    
    
//    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //    [viewController presentViewController:vc animated:YES completion:NULL];
//    [_containerView :vc.view];

//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"reviewsSBID"];
//   
//    // lets add it to container view
//    [vc willMoveToParentViewController:self];
//    [self.view addSubview:vc.view];
//    [self addChildViewController:vc];
//    [vc didMoveToParentViewController:self];
//    // keep reference of viewController which may be useful when you need to remove it from container view, lets consider you have a property name as containerViewController
//    _containerView = viewController;

    
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    [_tablevc.tableView removeFromSuperview];

    
    if(item.tag == 1) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UITableViewController *vc = [sb instantiateViewControllerWithIdentifier:@"photosSBID"];
        [self addChildViewController:vc];
        vc.tableView.frame = CGRectMake(0, 0, _containerView.frame.size.width, _containerView.frame.size.height);
        [_containerView addSubview:vc.tableView];
        [vc didMoveToParentViewController:self];

    }
    else if(item.tag == 2) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UITableViewController *vc = [sb instantiateViewControllerWithIdentifier:@"strainsSBID"];
            [self addChildViewController:vc];
            vc.tableView.frame = CGRectMake(0, 0, _containerView.frame.size.width, _containerView.frame.size.height);
            [_containerView addSubview:vc.tableView];
            [vc didMoveToParentViewController:self];
    }
}

- (UIImage *)image:(UIImage*)originalImage scaledToSize:(CGSize)size
{
    //avoid redundant drawing
    if (CGSizeEqualToSize(originalImage.size, size))
    {
        return originalImage;
    }
    
    //create drawing context
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    
    //draw
    [originalImage drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height)];
    
    //capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return image
    return image;
}


-(void)loadReviewsFromFirebase{
    FIRDatabaseQuery *reviewQuery = [[firebaseRef.reviewsRef queryOrderedByChild:@"objectKey"] queryEqualToValue:store.storeKey];
    
//    UITableViewController *tv = [[UITableViewController alloc] init];
//    tv = self.childViewControllers[0];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITableViewController *vc = [sb instantiateViewControllerWithIdentifier:@"reviewsSBID"];
    [self addChildViewController:vc];
    vc.tableView.frame = CGRectMake(0, 0, _containerView.frame.size.width, _containerView.frame.size.height);
    [_containerView addSubview:vc.tableView];
    [vc didMoveToParentViewController:self];

//    [vc willMoveToParentViewController:self];
//    vc.tableView.frame = CGRectMake(0, 0, _containerView.frame.size.width, _containerView.frame.size.height);
//    [_containerView addSubview:vc.view];
//    [self addChildViewController:vc];
//    [vc didMoveToParentViewController:self];
    // keep reference of viewController which may be useful when you need to remove it from container view, lets consider you have a property name as containerViewController
//
//    [vc willMoveToParentViewController:self];
//    vc.tableView.frame = CGRectMake(0, 0, _containerView.frame.size.width, _containerView.frame.size.height);
//    [self addChildViewController:vc];
//    [vc didMoveToParentViewController:self];
//    [_containerView addSubview:vc.tableView];

    
    

    [reviewQuery observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if (snapshot.value == [NSNull null]) {}
        else{
            for (NSInteger i = 0; i < [snapshot.value allKeys].count; i++) {
                reviewClass *tempReview = [[reviewClass alloc] init];
                tempReview.reviewKey = [[snapshot.value allKeys] objectAtIndex:i];
                NSLog(@"key is %@", tempReview.reviewKey);
                
                NSDictionary *dictionary = [[NSDictionary alloc] init];
                dictionary = [snapshot.value valueForKey:tempReview.reviewKey];
                tempReview.message = [dictionary valueForKey:@"message"];
                tempReview.objectImageURL = [dictionary valueForKey:@"objectImage"];
                tempReview.objectKey = [dictionary valueForKey:@"objectKey"];
                tempReview.objectName = [dictionary valueForKey:@"objectName"];
                tempReview.objectType = [dictionary valueForKey:@"objectType"];
                tempReview.userKey = [dictionary valueForKey:@"userKey"];
                tempReview.username = [dictionary valueForKey:@"username"];
                tempReview.rating = [dictionary valueForKey:@"rating"];
                tempReview.objectDataString = [dictionary valueForKey:@"objectData"];
                tempReview.objectData = [[NSData alloc] initWithBase64EncodedString:tempReview.objectDataString options:0];
                
                [store.reviews addObject:tempReview];
            }
    }
//        [tv.tableView reloadData];
        [vc.tableView reloadData];
        _tablevc = vc;
    }];
}

- (IBAction)tappedImage:(UITapGestureRecognizer *)sender {
    [user goToPopoverImageViewController:self];
}

- (IBAction)tappedCheckInButton:(UIButton *)sender {
    FIRUser *youser = [FIRAuth auth].currentUser;
    if (youser.email == nil) {
        [user goToUserNotSignedInViewController:self];
    } else {
        _checkInButton.selected = !_checkInButton.selected;
        NSString *eventKey;
        NSString *checkInKey;
        if(_checkInButton.selected){
            
            NSDate *today = [NSDate date];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd/MM/yyyy"];
            NSString *todaysDate = [dateFormat stringFromDate:today];

            eventKey = [firebaseRef.eventsRef childByAutoId].key;
            checkInKey = [[[firebaseRef.usersRef child:user.userKey] child:@"checkIns"] childByAutoId].key;

            [[[[firebaseRef.usersRef child:user.userKey] child:@"storesVisited"] child:store.storeKey] setValue:store.storeName];
            [user.storesVisited addObject:store.storeKey];
            
            [[[[[firebaseRef.usersRef child:user.userKey] child:@"checkIns"] child:checkInKey] child:@"storeName"] setValue:store.storeName];
            [[[[[firebaseRef.usersRef child:user.userKey] child:@"checkIns"] child:checkInKey] child:@"date"] setValue:todaysDate];
            [user.checkIns addObject:checkInKey];
            
            NSString *messageString = @"Checked in";
            [[[firebaseRef.eventsRef child:eventKey] child:@"userAvatarData"] setValue:user.avatarDataString];
            [[[firebaseRef.eventsRef child:eventKey] child:@"message"] setValue:messageString];
            [[[firebaseRef.eventsRef child:eventKey] child:@"userID"] setValue:user.userKey];
            [[[firebaseRef.eventsRef child:eventKey] child:@"username"] setValue:user.username];
            [[[firebaseRef.eventsRef child:eventKey] child:@"eventType"] setValue:@"checkIn"];

            imageClass *image = [[imageClass alloc] init];
            image = [store.imagesArray objectAtIndex:0];

            [[[firebaseRef.eventsRef child:eventKey] child:@"objectData"] setValue:image.dataString];
            [[[firebaseRef.eventsRef child:eventKey] child:@"objectName"] setValue:store.storeName];
            [[[firebaseRef.eventsRef child:eventKey] child:@"objectRating"] setValue:[NSString stringWithFormat:@"%f",store.ratingScore]];

        }
        else{
            [[[[firebaseRef.usersRef child:user.userKey] child:@"storesVisit"]  child:store.storeKey] removeValue];
            [user.storesVisited removeObject:store.storeKey];
            [[firebaseRef.eventsRef child:eventKey] removeValue];
        }
    }
}

- (void)loadImageView {
    imageClass *image = [[imageClass alloc] init];
    NSLog(@"store images array count %lu", store.imagesArray.count);
    image = [store.imagesArray objectAtIndex:0];
    _store_image_view.image = [UIImage imageWithData: image.data];

}

- (void)loadLabels {
//    _store_name_label.adjustsFontSizeToFitWidth = YES;
//    _store_address_label.adjustsFontSizeToFitWidth = YES;
//    _store_city_label.adjustsFontSizeToFitWidth = YES;
    [self setLabelValues];
}

- (void) setLabelValues {
    _store_name_label.text = store.storeName;
    _store_name_label.textColor = [UIColor colorWithRed:18.0/255.0 green:24.0/255.0 blue:23.0/255.0 alpha:1.0];
    _store_name_label.font = [UIFont fontWithName:@"CERVO-THIN" size:24.0];
    _store_name_label.userInteractionEnabled=NO;

    _store_address_label.text = store.address;
    _store_address_label.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1.0];
    _store_address_label.font = [UIFont fontWithName:@"NEXA LIGHT" size:12.0];
    _store_address_label.userInteractionEnabled=NO;

    _store_city_label.text = store.city;
    _store_city_label.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1.0];
    _store_city_label.font = [UIFont fontWithName:@"NEXA LIGHT" size:12.0];
    _store_city_label.userInteractionEnabled=NO;

    _store_state_label.text = store.state;
    _store_state_label.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1.0];
    _store_state_label.font = [UIFont fontWithName:@"NEXA LIGHT" size:12.0];
    _store_state_label.userInteractionEnabled=NO;

    _store_phone_number_label.text = store.phone_number;
    _store_phone_number_label.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1.0];
    _store_phone_number_label.font = [UIFont fontWithName:@"NEXA BOLD" size:12.0];
    _store_phone_number_label.userInteractionEnabled=YES;
    
    NSLog(@"phone is %@",store.phone_number);
    
    _store_rating_count.textColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    _store_rating_count.font = [UIFont fontWithName:@"NEXA BOLD" size:12.0];
    _store_rating_count.text = [[NSString stringWithFormat:@"%lu", (unsigned long)store .ratingCount] stringByAppendingString:@" Reviews"];

    
//    _store_address_label.text =  [@"Address: "stringByAppendingString: store .address];
//    _store_city_label.text =  [@"City: " stringByAppendingString:store .city];
//    _store_state_label.text = [@"State: " stringByAppendingString:store .state];
//    _store_url_label.text = [@"Webstie: " stringByAppendingString:store .url];
//    _store_phone_number_label.text = store .phone_number;
//    [self loadRatingCount];
}

- (void)loadRatingScore {
    _store_rating_score.value = store.ratingScore;
}

- (void)loadRatingCount{
    _store_rating_count.text = [[NSString stringWithFormat:@"%lu", (unsigned long)store .ratingCount] stringByAppendingString:@" reviews"];
}

- (IBAction)tappedEditButton:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"EditStoreSegue" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
