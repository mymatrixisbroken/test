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
    _tabBar.delegate = self;
    
    _spinner = [[UIActivityIndicatorView alloc]
                initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _spinner.hidesWhenStopped = YES;
    _spinner.center = self.view.center;
    [self.view addSubview:_spinner];
    [_spinner startAnimating];

    [self loadNavController];
    [self addGradientLayers];
    [self loadTabBar];
    [self getStoreKey];
    
    [_editStoreButton addTarget:self
                   action:@selector(tappedEditStore:)
         forControlEvents:UIControlEventTouchUpInside];
}

-(void) tappedEditStore:(UIButton *) button{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EditStoreViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Edit Store VC SB ID"];
    [self.navigationController pushViewController:vc animated:false];
}

-(void) addGradientLayers{
    _store_image_view.userInteractionEnabled = NO;
    CAGradientLayer *gradientMask = [CAGradientLayer layer];
    gradientMask.frame = _store_image_view.frame;
    gradientMask.colors = @[(id)[UIColor clearColor].CGColor, (id)[UIColor colorWithRed:1.0/255.0 green:1.0/255.0 blue:1.0/255.0 alpha:1.0].CGColor];
    gradientMask.startPoint = CGPointMake(0.5, 0.5);   // start at left middle
    gradientMask.endPoint = CGPointMake(0.5, 1.0);     // end at right middle
    
    [_store_image_view.layer addSublayer:gradientMask];
    
    CAGradientLayer *gradientMask2 = [CAGradientLayer layer];
    gradientMask2.frame = _store_image_view.frame;
    gradientMask2.colors = @[(id)[UIColor clearColor].CGColor, (id)[UIColor colorWithRed:1.0/255.0 green:1.0/255.0 blue:1.0/255.0 alpha:1.0].CGColor];
    gradientMask2.startPoint = CGPointMake(0.5, 0.5);   // start at left middle
    gradientMask2.endPoint = CGPointMake(1.0, 0.5);     // end at right middle
    
    [_store_image_view.layer addSublayer:gradientMask2];
}

-(void) loadTabBar{
    
    _tabBar.barTintColor = [UIColor colorWithRed:18.0/255.0 green:24.0/255.0 blue:23.0/255.0 alpha:1.0];
    
    _aboutBarItem.image = [[UIImage imageNamed:@"notSelectedAboutIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    _aboutBarItem.selectedImage = [[UIImage imageNamed:@"selectedAboutIcon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    _strainsBarItem.image = [[UIImage imageNamed:@"notSelectedStrainIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    _strainsBarItem.selectedImage = [[UIImage imageNamed:@"selectedStrainIcon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    _reviewsBarItem.image = [[UIImage imageNamed:@"notSelectedReviewsIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _reviewsBarItem.selectedImage = [[UIImage imageNamed:@"selectedReviewsIcon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _tabBar.selectedItem = _reviewsBarItem;
    
    _photosBarItem.enabled = YES;
    _photosBarItem.image = [[UIImage imageNamed:@"notSelectedPhotosIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    _photosBarItem.selectedImage = [[UIImage imageNamed:@"selectedPhotosIcon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    _favoriteBarItem.image = [[UIImage imageNamed:@"notSelectedFavoriteIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    _favoriteBarItem.selectedImage = [[UIImage imageNamed:@"selectedFavoriteIcon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


- (void) getStoreKey{
    [store init];

    NSLog(@"other user name is %@",_passedString);
    store.storeName = _passedString;
    
    NSString *lowerString = [store.storeName lowercaseString];
    
    FIRDatabaseQuery *queryLowerUserName = [[[firebaseRef.ref child:@"storeNames"] queryOrderedByChild:@"lowerName"] queryEqualToValue:lowerString];
    
    [queryLowerUserName observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            NSLog(@"store snapshot is %@", snapshot.value);
            if ([[snapshot.value allKeys] count]== 1) {                         //check one email found
                store.storeKey = [[snapshot.value allKeys] objectAtIndex:0];
                NSLog(@"store key is %@", store.storeKey);
                [self getStoreInformation];
            }
        }
    }];
    
}

- (void) getStoreInformation{
    [self editButtonHiddenOrNot];
    [self getStoreLocations];
    [self getImagesStore];
    [self getStoreName];
    [self getStoreHours];
    [self getStoreURL];
    [self getPhoneNumber];
    [self getGooglePlaceID];
    [self getRatingScore];
    [self getTotalCount];
    [self getMontlyCount];
    [self getDailyCount];
    [self getPromoKeys];
    [self getStrainKeys];
    [self getReviewKeys];
}

-(void) editButtonHiddenOrNot{
    if ([user.storeOwnerKey isEqual:store.storeKey]) {
        _editStoreButton.hidden = NO;
    }
    else
        _editStoreButton.hidden = YES;
}

- (void) getStoreLocations{
    NSLog(@"2 store key  is %@", store.storeKey);

    [[[firebaseRef.ref child:@"location"] child:store.storeKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null

            store.latitude = [snapshot.value valueForKey:@"latitude"];
            store.longitude = [snapshot.value valueForKey:@"longitude"];
            store.address = [snapshot.value valueForKey:@"address"];
            store.city = [snapshot.value valueForKey:@"city"];
            store.county = [snapshot.value valueForKey:@"county"];
            store.state = [snapshot.value valueForKey:@"state"];
            store.zipcode = [snapshot.value valueForKey:@"zipcode"];
            
            NSLog(@"object location is %@,%@", store.latitude, store.longitude);
            _store_address_label.text = store.address;
            NSString *string = [[[[store.city stringByAppendingString:@", "]
                                  stringByAppendingString:store.state]
                                 stringByAppendingString:@" "]
                                stringByAppendingString:store.zipcode ];
            _store_city_label.text = string ;

            [self loadMap];
            [self currentDistanceToStores];
        }
    }];
}

-(void) loadMap{
    double lat = [store.latitude doubleValue];
    double lon = [store.longitude doubleValue];
    
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:lat
                                                            longitude:lon
                                                                 zoom:16];
    GMSMapView *mapView = [GMSMapView mapWithFrame:_mapView.bounds camera:camera];
    mapView.delegate = self;
    mapView.myLocationEnabled = true;
    mapView.layer.masksToBounds = NO;
    mapView.layer.shadowOffset = CGSizeMake(0, 3);
    mapView.layer.shadowRadius = 3;
    mapView.layer.shadowOpacity = 0.5;
    
    [_mapView addSubview: mapView];
    
    NSLog(@"store lat is %f",lat);
    NSLog(@"store long is %f",lon);
    
    
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(lat, lon);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    marker.icon = [UIImage imageNamed:@"markerSmartObject"];
    marker.map = mapView;
}

-(void) currentDistanceToStores{
    
    NSString *geocodingBaseURL = @"https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=";
    NSString *url = [NSString stringWithFormat:@"%@%f,%f&destinations=%@,%@&key=AIzaSyAsZ171sgZHuTcapToLRQ5-W9dl_WRLOh4", geocodingBaseURL, user.latitude,user.longitude,store.latitude,store.longitude];
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *queryURL = [NSURL URLWithString:url];
    NSData *data = [NSData dataWithContentsOfURL:queryURL];
    
    NSError *error;
    NSDictionary *json = [NSJSONSerialization
                          JSONObjectWithData:data
                          options:kNilOptions
                          error:&error];
    if (user.latitude != 0.00){
        NSArray *rowsArray = [json objectForKey:@"rows"];
        for (NSDictionary *alert in rowsArray ){
            NSArray *elementsArray = [alert objectForKey:@"elements"];
            for (NSDictionary *alert in elementsArray ){
                NSString* description = [[alert  valueForKey:@"distance"] valueForKey:@"text"];
                NSString* value = [[alert  valueForKey:@"distance"] valueForKey:@"value"];
                store.distanceToMe = description;
                store.distanceValue = value;
                _distanceLabel.text = store.distanceToMe;
            }
        }
    }
}

- (void) getImagesStore {
    [[[[firebaseRef.ref child:@"images"] child:@"stores"] child:store.storeKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null

            NSArray *imageKeys = [[NSArray alloc] init];
            imageKeys = [snapshot.value allKeys];
            
            for(int j=0; j<imageKeys.count ; j++){
                NSLog(@"image snapshot  is %@", snapshot.value);

                
                imageClass *image = [[imageClass alloc] init];
                image.imageKey = [imageKeys objectAtIndex:j];
                image.imageURL = [snapshot.value valueForKey:image.imageKey];
                [store.imagesArray addObject:image];
            }
            
            NSLog(@"object image count is %lu", (unsigned long)[store.imagesArray count]);
            
            [self loadImageView];
            [self getDownVotes];
            [self getUpVotes];
            [self sortStoreImagesByVotes];

        }
    }];
}

- (void) getStoreName {
    [[[firebaseRef.ref child:@"storeNames"] child:store.storeKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            store.storeName = [snapshot.value valueForKey:@"name"];
            NSLog(@"object name is %@", store.storeName);
            _store_name_label.text = store.storeName;
        }
        [_spinner stopAnimating];
    }];
}

- (void) getDownVotes {
    NSLog(@"image key  is %lu", store.imagesArray.count);

    for (int j = 0; j < store.imagesArray.count; j++){
        imageClass *image = [[imageClass alloc] init];
        image = [store.imagesArray objectAtIndex:j];
        NSLog(@"image key  is %@", image.imageKey);

        
        [[[firebaseRef.ref child:@"thumbsDown"] child:image.imageKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            if ([NSNull null] != snapshot.value){                                   //check snapshot is null

            image.imageThumbsDown = [NSMutableArray arrayWithArray:[snapshot.value allKeys]];
            
            [store.imagesArray replaceObjectAtIndex:j withObject:image];
            }
        }];
    }
}

- (void) getUpVotes {
    for (int j = 0; j < store.imagesArray.count; j++){
        imageClass *image = [[imageClass alloc] init];
        image = [store.imagesArray objectAtIndex:j];
        NSLog(@"image key  is %@", image.imageKey);

        
        [[[firebaseRef.ref child:@"thumbsUp"] child:image.imageKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            if ([NSNull null] != snapshot.value){                                   //check snapshot is null

                image.imageThumbsUp = [NSMutableArray arrayWithArray:[snapshot.value allKeys]];
                image.voteScore = image.imageThumbsUp.count - image.imageThumbsDown.count;
                
                [store.imagesArray replaceObjectAtIndex:j withObject:image];
            }
            
        }];
    }
}

- (void) sortStoreImagesByVotes{
    [store.imagesArray sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"voteScore" ascending:NO selector:@selector(compare:)]]];
}

- (void) getStoreHours {
    [[[firebaseRef.ref child:@"storeHours"] child:store.storeKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        NSLog(@"store horus snapshot is %@", snapshot.value);

        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            store.storeHours = [snapshot.value valueForKey:@"hours"];
            NSLog(@"store horus is %@", store.storeHours);
            _hoursLabel.text = store.storeHours;
        }
    }];
}

- (void) getStoreURL {
    [[[firebaseRef.ref child:@"storeURL"] child:store.storeKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            store.url = [snapshot.value valueForKey:@"url"];
            NSLog(@"object url is %@", store.url);
        }
    }];
}

- (void) getPhoneNumber {
    
    [[[firebaseRef.ref child:@"phoneNumbers"] child:store.storeKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            store.phone_number = [snapshot.value valueForKey:@"phoneNumber"];
        
            NSLog(@"object phone number is %@", store.phone_number);
            _store_phone_number_label.text = store.phone_number;
        }
    }];
}

- (void) getGooglePlaceID {
    
    [[[firebaseRef.ref child:@"googlePlaceID"] child:store.storeKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            store.googlePlaceID = [snapshot.value valueForKey:@"googlePlaceID"];
        
            NSLog(@"object google place ID is %@", store.googlePlaceID);
        }
    }];
}

- (void) getRatingScore {
    [[[[firebaseRef.ref child:@"starRating"] child:@"stores"] child:store.storeKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            NSArray *scores = [[NSArray alloc] init];
            scores = [snapshot.value allValues];
            store.ratingCount = [scores count];
            
            if ([scores count] > 0) {
                for (id i in scores){
                    store.ratingScore = store.ratingScore + [i floatValue];
                }
                _store_rating_score.value = store.ratingScore;
                _store_rating_count.text = [[NSString stringWithFormat:@"%lu", store.ratingCount] stringByAppendingString:@" Reviews"];
            }
        }
    }];
}

- (void) getTotalCount {
    
    [[[[firebaseRef.ref child:@"metrics"] child:@"stores"] child:store.storeKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            store.totalViews = [[snapshot.value valueForKey:@"totalViews"] integerValue];
            
            NSLog(@"object total views is %ld", (long)store.totalViews);
        }
    }];
}
- (void) getMontlyCount {
    
    [[[[[firebaseRef.ref child:@"metrics"] child:@"stores"] child:store.storeKey] child:@"monthlyViews"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            store.monthlyViews = [[snapshot.value valueForKey:@"February 2017"]integerValue];
        
        NSLog(@"object montly views is %ld", (long)store.monthlyViews);
        }
    }];
}
- (void) getDailyCount {
    
    [[[[[firebaseRef.ref child:@"metrics"] child:@"stores"] child:store.storeKey] child:@"dailyViews"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            store.dailyViews = [[snapshot.value valueForKey:@"01-Jan-2017"]integerValue];
        
        NSLog(@"object daily views is %ld", (long)store.dailyViews);
        }
    }];
}

- (void)loadImageView {
    NSLog(@"store images array count %lu", store.imagesArray.count);
    
    if ([store.imagesArray count] > 0) {
        FIRStorage *storage = [FIRStorage storage];
        FIRStorageReference *storageRef = [storage reference];
        
        imageClass *image = [[imageClass alloc] init];
        image = [store.imagesArray objectAtIndex:0];
        
        NSLog(@"image link is %@", image.imageURL);
        FIRStorageReference *spaceRef = [[[storageRef child:@"stores"] child:store.storeKey] child:image.imageURL];
        NSLog(@"ref is %@", spaceRef);
        
        UIImage *placeHolder = [[UIImage alloc] init];
        [_store_image_view sd_setImageWithStorageReference:spaceRef placeholderImage:placeHolder];
    }
}

- (void) getPromoKeys {
    [[[firebaseRef.ref child:@"promos"] child:store.storeKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            
            NSArray *promoKeys = [[NSArray alloc] init];
            promoKeys = [snapshot.value allKeys];
            
            for(int j=0; j< promoKeys.count ; j++){
                NSLog(@"image snapshot  is %@", snapshot.value);
                
                
                promoClass *promo = [[promoClass alloc] init];
                promo.promoKey = [promoKeys objectAtIndex:j];
                [store.promosArray addObject:promo];
            }
            
            NSLog(@"object image count is %lu", (unsigned long)[store.promosArray count]);
            
            [self getPromoDate];
            [self getPromoText];
            [self getPromoLikes];
        }
    }];
}

- (void) getPromoDate {
    NSLog(@"promo key  is %lu", store.promosArray.count);
    
    for (int j = 0; j < store.promosArray.count; j++){
        promoClass *promo = [[promoClass alloc] init];
        promo = [store.promosArray objectAtIndex:j];
        NSLog(@"promo key  is %@", promo.promoKey);
        
        
        [[[[firebaseRef.ref child:@"promoDate"] child:store.storeKey] child:promo.promoKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            if ([NSNull null] != snapshot.value){                                   //check snapshot is null
                promo.promoDate = [[snapshot.value allValues] objectAtIndex:0];
                
                [store.promosArray replaceObjectAtIndex:j withObject:promo];
            }
        }];
    }
}

- (void) getPromoText {
    NSLog(@"promo key  is %lu", store.promosArray.count);
    
    for (int j = 0; j < store.promosArray.count; j++){
        promoClass *promo = [[promoClass alloc] init];
        promo = [store.promosArray objectAtIndex:j];
        NSLog(@"promo key  is %@", promo.promoKey);
        
        
        [[[[firebaseRef.ref child:@"promoText"] child:store.storeKey] child:promo.promoKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            if ([NSNull null] != snapshot.value){                                   //check snapshot is null
                promo.promoText = [[snapshot.value allValues] objectAtIndex:0];
                
                [store.promosArray replaceObjectAtIndex:j withObject:promo];
            }
        }];
    }
}

- (void) getPromoLikes {
    NSLog(@"promo key  is %lu", store.promosArray.count);
    
    for (int j = 0; j < store.promosArray.count; j++){
        promoClass *promo = [[promoClass alloc] init];
        promo = [store.promosArray objectAtIndex:j];
        NSLog(@"promo key  is %@", promo.promoKey);
        
        
        [[[[firebaseRef.ref child:@"promoLikes"] child:store.storeKey] child:promo.promoKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            if ([NSNull null] != snapshot.value){                                   //check snapshot is null
                promo.promoLikes = [snapshot.value allKeys];
                
                [store.promosArray replaceObjectAtIndex:j withObject:promo];
            }
        }];
    }
}

- (void) getStrainKeys {
    [[[firebaseRef.ref child:@"storeHasStrains"] child:store.storeKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            NSArray *strainKeys = [[NSArray alloc] init];
            strainKeys = [snapshot.value allKeys];
            
            for(int j=0; j< strainKeys.count ; j++){
                NSLog(@"image snapshot  is %@", snapshot.value);
                
                
                strainClass *tempStrain = [[strainClass alloc] init];
                tempStrain.strainKey = [strainKeys objectAtIndex:j];
                [store.hasStrainsArray addObject:tempStrain];
            }
            
            NSLog(@"object image count is %lu", (unsigned long)[store.hasStrainsArray count]);

            [self getStrainInformation];
        }
    }];
}

- (void) getStrainInformation{
    /* need to change from count to 20 items per page*/
    for (int i = 0; i < store.hasStrainsArray.count; i++){
        
        strainClass *tempStrain = [[strainClass alloc] init];
        tempStrain = [store.hasStrainsArray objectAtIndex:i];
//                [store.hasStrainsArray replaceObjectAtIndex:i withObject:tempStrain];
        
        [self getStrainName: i];
        [self getStrainRatingScore: i];
        [self getStrainFamily: i];
    }
}



- (void) getStrainName:(NSInteger) i {
    strainClass *tempStrain = [[strainClass alloc] init];
    tempStrain = [store.hasStrainsArray objectAtIndex:i];

    [[[firebaseRef.ref child:@"strainNames"] child:tempStrain.strainKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            tempStrain.strainName = [snapshot.value valueForKey:@"name"];
            NSLog(@"object name is %@", tempStrain.strainName);
            [store.hasStrainsArray replaceObjectAtIndex:i withObject:tempStrain];

//            _strainNameLabel.text = strain.strainName;
        }
    }];
}

- (void) getStrainRatingScore:(NSInteger) i {
    strainClass *tempStrain = [[strainClass alloc] init];
    tempStrain = [store.hasStrainsArray objectAtIndex:i];

    [[[[firebaseRef.ref child:@"starRating"] child:@"strains"] child:tempStrain.strainKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            NSArray *scores = [[NSArray alloc] init];
            scores = [snapshot.value allValues];
            tempStrain.ratingCount = [scores count];
            
            if ([scores count] > 0) {
                for (id i in scores){
                    tempStrain.ratingScore = tempStrain.ratingScore + [i floatValue];
                }
                [store.hasStrainsArray replaceObjectAtIndex:i withObject:tempStrain];

//                _starRating.value = strain.ratingScore;
//                _ratingCount.text = [[NSString stringWithFormat:@"%lu", strain.ratingCount] stringByAppendingString:@" Reviews"];
            }
        }
    }];
}

- (void) getStrainFamily:(NSInteger) i {
    strainClass *tempStrain = [[strainClass alloc] init];
    tempStrain = [store.hasStrainsArray objectAtIndex:i];

    [[[firebaseRef.ref child:@"strainFamily"] child:tempStrain.strainKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            tempStrain.family = [snapshot.value valueForKey:@"family"];
            [store.hasStrainsArray replaceObjectAtIndex:i withObject:tempStrain];

//            _strainSpeciesLabel.text = strain.family;
            NSLog(@"object montly views is %@",tempStrain.family);
        }
    }];
}

- (void) getReviewKeys {
    [[[[firebaseRef.ref child:@"reviewKeys"] child:@"stores"] child:store.storeKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            
            NSArray *reviewKeys = [[NSArray alloc] init];
            reviewKeys = [snapshot.value allKeys];
            
            for(int j=0; j< reviewKeys.count ; j++){
                NSLog(@"image snapshot  is %@", snapshot.value);
                
                
                reviewClassNew *review = [[reviewClassNew alloc] init];
                review.reviewKey = [reviewKeys objectAtIndex:j];
                [store.reviewsArray addObject:review];
            }
            
            NSLog(@"object image count is %lu", (unsigned long)[store.reviewsArray count]);
            
            [self getReviewAuthoredByUser];
            [self getReviewMessage];
            [self getReviewRating];
        }
    }];
}

- (void) getReviewAuthoredByUser {
    NSLog(@"review key  is %lu", store.reviewsArray.count);
    
    for (int j = 0; j < store.reviewsArray.count; j++){
        reviewClassNew *review = [[reviewClassNew alloc] init];
        review = [store.reviewsArray objectAtIndex:j];
        NSLog(@"review key  is %@", review.reviewKey);
        
        
        [[[firebaseRef.ref child:@"reviewAddedByUser"] child:review.reviewKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            if ([NSNull null] != snapshot.value){                                   //check snapshot is null
                NSLog(@"user key  is %@", [[snapshot.value allKeys] objectAtIndex:0]);

                review.authoredByUserKey = [[snapshot.value allKeys] objectAtIndex:0];
                [store.reviewsArray replaceObjectAtIndex:j withObject:review];
                
                [self getReviewAuthoredByUserImage:j];
                [self getAuthoredByUsername:j];
            }
        }];
    }
}

- (void) getReviewAuthoredByUserImage:(NSInteger) i {
    NSLog(@"review key  is %lu", store.reviewsArray.count);
    
        reviewClassNew *review = [[reviewClassNew alloc] init];
        review = [store.reviewsArray objectAtIndex:i];
        NSLog(@"review key  is %@", review.reviewKey);
        
        
        [[[[firebaseRef.ref child:@"images"] child:@"users"] child:review.authoredByUserKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            if ([NSNull null] != snapshot.value){                                   //check snapshot is null
                for (id key in snapshot.value) {
                    [review.userImageLink addObject:[snapshot.value valueForKey:key]];
                }
                [store.reviewsArray replaceObjectAtIndex:i withObject:review];
            }
        }];
}

- (void) getAuthoredByUsername:(NSInteger) i{
    NSLog(@"review key  is %lu", store.reviewsArray.count);
    
        reviewClassNew *review = [[reviewClassNew alloc] init];
        review = [store.reviewsArray objectAtIndex:i];
        NSLog(@"review key  is %@", review.reviewKey);

        [[[firebaseRef.ref child:@"usernames"] child:review.authoredByUserKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            if ([NSNull null] != snapshot.value){                                   //check snapshot is null
                review.authoredByUsername = [snapshot.value valueForKey:@"username"];
                
                [store.reviewsArray replaceObjectAtIndex:i withObject:review];
            }
        }];
}


- (void) getReviewMessage {
    NSLog(@"review key  is %lu", store.reviewsArray.count);
    
    for (int j = 0; j < store.reviewsArray.count; j++){
        reviewClassNew *review = [[reviewClassNew alloc] init];
        review = [store.reviewsArray objectAtIndex:j];
        NSLog(@"review key  is %@", review.reviewKey);
        
        
        [[[firebaseRef.ref child:@"reviewMessage"] child:review.reviewKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            if ([NSNull null] != snapshot.value){                                   //check snapshot is null
                review.message = [[snapshot.value allValues] objectAtIndex:0];
                
                [store.reviewsArray replaceObjectAtIndex:j withObject:review];
            }
        }];
    }
}

- (void) getReviewRating {
    NSLog(@"review key  is %lu", store.reviewsArray.count);
    
    for (int j = 0; j < store.reviewsArray.count; j++){
        reviewClassNew *review = [[reviewClassNew alloc] init];
        review = [store.reviewsArray objectAtIndex:j];
        NSLog(@"review key  is %@", review.reviewKey);
        
        
        [[[firebaseRef.ref child:@"reviewRating"] child:review.reviewKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            if ([NSNull null] != snapshot.value){                                   //check snapshot is null
                review.rating = [[snapshot.value allValues] objectAtIndex:0];
                
                [store.reviewsArray replaceObjectAtIndex:j withObject:review];
            }
        }];
    }
}




//-(void)getPromos{
//    FIRDatabaseQuery *reviewQuery = [[firebaseRef.reviewsRef queryOrderedByChild:@"objectKey"] queryEqualToValue:store.storeKey];
//    
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UITableViewController *vc = [sb instantiateViewControllerWithIdentifier:@"reviewsSBID"];
//    [self addChildViewController:vc];
//    vc.tableView.frame = CGRectMake(0, 0, _containerView.frame.size.width, _containerView.frame.size.height);
//    [_containerView addSubview:vc.tableView];
//    [vc didMoveToParentViewController:self];
//    
//    
//    [reviewQuery observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
//        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
//            for (NSInteger i = 0; i < [snapshot.value allKeys].count; i++) {
//                reviewClass *tempReview = [[reviewClass alloc] init];
//                tempReview.reviewKey = [[snapshot.value allKeys] objectAtIndex:i];
//                NSLog(@"key is %@", tempReview.reviewKey);
//                
//                NSDictionary *dictionary = [[NSDictionary alloc] init];
//                dictionary = [snapshot.value valueForKey:tempReview.reviewKey];
//                tempReview.message = [dictionary valueForKey:@"message"];
//                tempReview.objectImageURL = [dictionary valueForKey:@"objectImage"];
//                tempReview.objectKey = [dictionary valueForKey:@"objectKey"];
//                tempReview.objectName = [dictionary valueForKey:@"objectName"];
//                tempReview.objectType = [dictionary valueForKey:@"objectType"];
//                tempReview.userKey = [dictionary valueForKey:@"userKey"];
//                tempReview.username = [dictionary valueForKey:@"username"];
//                tempReview.rating = [dictionary valueForKey:@"rating"];
//                tempReview.objectDataString = [dictionary valueForKey:@"objectData"];
//                tempReview.objectData = [[NSData alloc] initWithBase64EncodedString:tempReview.objectDataString options:0];
//                
//                [store.reviews addObject:tempReview];
//            }
//        }
//        [vc.tableView reloadData];
//        _tablevc = vc;
//        
//    }];
//}

//-(void)loadReviewsFromFirebase{
//    FIRDatabaseQuery *reviewQuery = [[firebaseRef.reviewsRef queryOrderedByChild:@"objectKey"] queryEqualToValue:store.storeKey];
//    
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UITableViewController *vc = [sb instantiateViewControllerWithIdentifier:@"reviewsSBID"];
//    [self addChildViewController:vc];
//    vc.tableView.frame = CGRectMake(0, 0, _containerView.frame.size.width, _containerView.frame.size.height);
//    [_containerView addSubview:vc.tableView];
//    [vc didMoveToParentViewController:self];
//    
//    
//    [reviewQuery observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
//        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
//            for (NSInteger i = 0; i < [snapshot.value allKeys].count; i++) {
//                reviewClass *tempReview = [[reviewClass alloc] init];
//                tempReview.reviewKey = [[snapshot.value allKeys] objectAtIndex:i];
//                NSLog(@"key is %@", tempReview.reviewKey);
//                
//                NSDictionary *dictionary = [[NSDictionary alloc] init];
//                dictionary = [snapshot.value valueForKey:tempReview.reviewKey];
//                tempReview.message = [dictionary valueForKey:@"message"];
//                tempReview.objectImageURL = [dictionary valueForKey:@"objectImage"];
//                tempReview.objectKey = [dictionary valueForKey:@"objectKey"];
//                tempReview.objectName = [dictionary valueForKey:@"objectName"];
//                tempReview.objectType = [dictionary valueForKey:@"objectType"];
//                tempReview.userKey = [dictionary valueForKey:@"userKey"];
//                tempReview.username = [dictionary valueForKey:@"username"];
//                tempReview.rating = [dictionary valueForKey:@"rating"];
//                tempReview.objectDataString = [dictionary valueForKey:@"objectData"];
//                tempReview.objectData = [[NSData alloc] initWithBase64EncodedString:tempReview.objectDataString options:0];
//                
//                [store.reviews addObject:tempReview];
//            }
//    }
//        [vc.tableView reloadData];
//        _tablevc = vc;
//        
//    }];
//}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    [_tablevc.tableView removeFromSuperview];
    
    if(item.tag == 1) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UITableViewController *vc = [sb instantiateViewControllerWithIdentifier:@"promosSBID"];
        [self addChildViewController:vc];
        vc.tableView.frame = CGRectMake(0, 0, _containerView.frame.size.width, _containerView.frame.size.height);
        [_containerView addSubview:vc.tableView];
        [vc didMoveToParentViewController:self];
        [_scrollView setContentOffset:CGPointMake(0, 570) animated:YES];
        
    }
    else if(item.tag == 2) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UITableViewController *vc = [sb instantiateViewControllerWithIdentifier:@"strainsSBID"];
        [self addChildViewController:vc];
        vc.tableView.frame = CGRectMake(0, 0, _containerView.frame.size.width, _containerView.frame.size.height);
        [_containerView addSubview:vc.tableView];
        [vc didMoveToParentViewController:self];
        [_scrollView setContentOffset:CGPointMake(0, 570) animated:YES];
    }
    else if(item.tag == 3) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UITableViewController *vc = [sb instantiateViewControllerWithIdentifier:@"reviewsSBID"];
        [self addChildViewController:vc];
        vc.tableView.frame = CGRectMake(0, 0, _containerView.frame.size.width, _containerView.frame.size.height);
        [_containerView addSubview:vc.tableView];
        [vc didMoveToParentViewController:self];
        [_scrollView setContentOffset:CGPointMake(0, 570) animated:YES];
    }
    else if(item.tag == 4) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UITableViewController *vc = [sb instantiateViewControllerWithIdentifier:@"photosSBID"];
        [self addChildViewController:vc];
        vc.tableView.frame = CGRectMake(0, 0, _containerView.frame.size.width, _containerView.frame.size.height);
        [_containerView addSubview:vc.tableView];
        [vc didMoveToParentViewController:self];
        [_scrollView setContentOffset:CGPointMake(0, 570) animated:YES];
    }
    else if(item.tag == 5) {
        //Bookmark store
    }
}


//- (UIImage *)image:(UIImage*)originalImage scaledToSize:(CGSize)size
//{
//    //avoid redundant drawing
//    if (CGSizeEqualToSize(originalImage.size, size))
//    {
//        return originalImage;
//    }
//    
//    //create drawing context
//    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
//    
//    //draw
//    [originalImage drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height)];
//    
//    //capture resultant image
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    //return image
//    return image;
//}


//- (IBAction)tappedImage:(UITapGestureRecognizer *)sender {
//    NSLog(@"%@",[self.navigationController.viewControllers objectAtIndex:0]);
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    popOverImageViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Popover Image VC SB ID"];
//    NSString *otherStrainName = [NSString stringWithFormat: @"%@",[self.navigationController.viewControllers objectAtIndex:0]];
//    vc.passedString = otherStrainName;
//    [self.navigationController pushViewController:vc animated:false];
//
////    [user goToPopoverImageViewController:self];
//}

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


//- (IBAction)tappedEditButton:(UIBarButtonItem *)sender {
//    [self performSegueWithIdentifier:@"EditStoreSegue" sender:self];
//}

- (void) loadNavController{
    
    UIButton *btn1 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0,0,25,25);
    [btn1 setBackgroundImage:[UIImage imageNamed:@"newsFeedWhiteIcon"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(newsFeedButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonOne = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    
    
    UIButton *btn2 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0,0,25,25);
    [btn2 setBackgroundImage:[UIImage imageNamed:@"mapWhiteIcon"] forState:UIControlStateNormal];
    UIBarButtonItem *buttonTwo = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    
    
    UIButton *btn3 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(0,0,25,25);
    [btn3 setBackgroundImage:[UIImage imageNamed:@"searchWhiteIcon"] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(searchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonThree = [[UIBarButtonItem alloc] initWithCustomView:btn3];
    
    
    UIButton *btn4 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(0,0,25,25);
    [btn4 setBackgroundImage:[UIImage imageNamed:@"storesWhiteIcon"] forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(storeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonFour = [[UIBarButtonItem alloc] initWithCustomView:btn4];
    
    
    UIButton *btn5 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn5.frame = CGRectMake(0,0,25,25);
    [btn5 setBackgroundImage:[UIImage imageNamed:@"hamburgerWhiteIcon"] forState:UIControlStateNormal];
    [btn5 addTarget:self action:@selector(barButtonCustomPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonFive = [[UIBarButtonItem alloc] initWithCustomView:btn5];
    
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    space.width = 55;

    NSArray *buttons = @[buttonOne, space, buttonTwo, space, buttonThree, space, buttonFour, space, buttonFive];
    
    self.navigationController.navigationBar.topItem.title = nil;
    self.navigationController.navigationBar.topItem.leftBarButtonItems = buttons;
}

-(IBAction)newsFeedButtonPressed:(UIButton*)btn {
    user.mainNavigationSelected = 0;
    [user goToNewsFeedViewController:self];
}

-(IBAction)strainButtonPressed:(UIButton*)btn {
    user.mainNavigationSelected = 1;
    [user gotoMapViewViewController:self];
}

-(IBAction)searchButtonPressed:(UIButton*)btn {
    user.mainNavigationSelected = 2;
    [user goToSearchViewController:self];
}


-(IBAction)userProfileButtonPressed:(UIButton*)btn {
    user.mainNavigationSelected = 2;
    FIRUser *youser = [FIRAuth auth].currentUser;
    if(youser.anonymous){
        [user goToUserNotSignedInViewController:self];
    }
    else{
        [user goToCurrentUserProfileViewController:self];
    }
}

-(IBAction)storeButtonPressed:(UIButton*)btn {
    user.mainNavigationSelected = 3;
    objectsArray.filterSelected = 10;
    objectsArray.strainOrStore = 1;
    [user goToStrainsStoresViewController:self];
}


-(IBAction)barButtonCustomPressed:(UIBarButtonItem*)btn
{
    FIRUser *currentUser = [FIRAuth auth].currentUser;
    if(currentUser.anonymous){
        [user gotoOptionListViewController:self];
        
    } else {
        [user gotoOptionListSignedInViewController:self];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
