//
//  FirstViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "AddStoreViewController.h"

@interface AddStoreViewController ()

@end

@implementation AddStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageSelected = false;
    _confirmButton.enabled = NO;
    _phoneNumber.tag = 3;
    _storeHours.tag = 3;
    
    _storeHours.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Store Hours (optional)" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1.0]}];
    _storeName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Store Name" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1.0]}];
    _address.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Address" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1.0]}];
    _cityStateZip.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"City, State, Zip" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1.0]}];
    _phoneNumber.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Phone Number (optional)" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1.0]}];

    
    [_storeHours addTarget:self
                    action:@selector(storeHoursDidChange:)
          forControlEvents:UIControlEventEditingDidBegin];
    
    [_storeName addTarget:self
                   action:@selector(storeNameDidChange:)
         forControlEvents:UIControlEventEditingDidBegin];
    
    [_address addTarget:self
                 action:@selector(addressDidChange:)
       forControlEvents:UIControlEventEditingDidBegin];
    
    [_cityStateZip addTarget:self
                      action:@selector(cityStateZipDidChange:)
            forControlEvents:UIControlEventEditingDidBegin];
    
    [_phoneNumber addTarget:self
                     action:@selector(phoneNumberDidChange:)
           forControlEvents:UIControlEventEditingDidBegin];

    
    /******************************************/
    
    
    [_storeHours addTarget:self
                    action:@selector(storeHoursDidEndEditing:)
          forControlEvents:UIControlEventEditingDidEnd];
    
    [_storeName addTarget:self
                   action:@selector(storeNameDidEndEditing:)
         forControlEvents:UIControlEventEditingDidEnd];
    
    [_address addTarget:self
                 action:@selector(addressDidEndEditing:)
       forControlEvents:UIControlEventEditingDidEnd];
    
    [_cityStateZip addTarget:self
                      action:@selector(cityStateZipDidEndEditing:)
            forControlEvents:UIControlEventEditingDidEnd];
    
    [_phoneNumber addTarget:self
                     action:@selector(phoneNumberDidEndEditing:)
           forControlEvents:UIControlEventEditingDidEnd];

    
//    double lat = [user.latitude doubleValue];
//    double lon = [user.longitude doubleValue];
    
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:user.latitude
                                                            longitude:user.longitude
                                                                 zoom:16];
    GMSMapView *mapView = [GMSMapView mapWithFrame:_mapView.bounds camera:camera];
    mapView.delegate = self;
    mapView.myLocationEnabled = true;
    mapView.layer.masksToBounds = NO;
    mapView.layer.shadowOffset = CGSizeMake(0, 3);
    mapView.layer.shadowRadius = 3;
    mapView.layer.shadowOpacity = 0.5;
    
    [_mapView addSubview: mapView];

}

-(void) storeHoursDidChange:(UITextField *) textField{
    _storeHours.font = [UIFont fontWithName:@"NEXA BOLD" size:15.0];
    _storeHours.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"e.g. M-F 10am-9pm" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1.0]}];
    [self checkAllTextFieldLength];
}

-(void) storeNameDidChange:(UITextField *) textField{
    _storeName.font = [UIFont fontWithName:@"CERVO-THIN" size:33.0];
    _storeName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"e.g. Apothekare" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1.0]}];
    [self checkAllTextFieldLength];
}

-(void) addressDidChange:(UITextField *) textField{
    _address.font = [UIFont fontWithName:@"NEXA LIGHT" size:15.0];
    _address.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"e.g. 123 High Street #420" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1.0]}];
    [self checkAllTextFieldLength];
}

-(void) cityStateZipDidChange:(UITextField *) textField{
    _cityStateZip.font = [UIFont fontWithName:@"NEXA LIGHT" size:15.0];
    _cityStateZip.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"e.g. Arlington, TX, 76018" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1.0]}];
    [self checkAllTextFieldLength];
}

-(void) phoneNumberDidChange:(UITextField *) textField{
    _phoneNumber.font = [UIFont fontWithName:@"NEXA BOLD" size:15.0];
    _phoneNumber.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"e.g. 555-555-5555" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1.0]}];
    [self checkAllTextFieldLength];
}

/**********************************************/

-(void) storeHoursDidEndEditing:(UITextField *) textField{
    _storeHours.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Store Hours (optional)" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1.0]}];
    [self checkAllTextFieldLength];
}

-(void) storeNameDidEndEditing:(UITextField *) textField{
    _storeName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Store Name" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1.0]}];
    [self checkAllTextFieldLength];
}

-(void) addressDidEndEditing:(UITextField *) textField{
    _address.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Address" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1.0]}];
    [self checkAllTextFieldLength];
}

-(void) cityStateZipDidEndEditing:(UITextField *) textField{
    _cityStateZip.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"City, State, Zip" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1.0]}];
    [self checkAllTextFieldLength];

    if ((_address.text.length > 0) && (_cityStateZip.text.length > 0)) {
        [self moveMapFromStoreAddress];
    }
}

-(void) phoneNumberDidEndEditing:(UITextField *) textField{
    _phoneNumber.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Phone Number (optional)" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1.0]}];
    [self checkAllTextFieldLength];
}

-(void) moveMapFromStoreAddress{
    NSString *address = [_address.text stringByAppendingString:_cityStateZip.text];
    NSString *geocodingBaseURL = @"https://maps.googleapis.com/maps/api/geocode/json?address=";
    NSString *url = [NSString stringWithFormat:@"%@%@&key=AIzaSyAsZ171sgZHuTcapToLRQ5-W9dl_WRLOh4",geocodingBaseURL, address];
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
    _storeLat = [[location valueForKey:@"lat"] doubleValue];
    _storeLng = [[location valueForKey:@"lng"] doubleValue];

    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:_storeLat
                                                            longitude:_storeLng
                                                                 zoom:16];
    GMSMapView *mapView = [GMSMapView mapWithFrame:_mapView.bounds camera:camera];
    [_mapView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    [_mapView addSubview:mapView];
    
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(_storeLat, _storeLng);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    marker.icon = [UIImage imageNamed:@"markerSmartObject"];
    marker.infoWindowAnchor = CGPointMake(0.44f, 0.45f);
    marker.map = mapView;
}

- (IBAction)tappedFillCurrentLocationButton:(id)sender {
    NSString *geocodingBaseURL = @"https://maps.googleapis.com/maps/api/geocode/json?latlng=";
    NSString *url = [NSString stringWithFormat:@"%@%f,%f&key=AIzaSyAsZ171sgZHuTcapToLRQ5-W9dl_WRLOh4",geocodingBaseURL, user.latitude, user.longitude];
//    NSString *url = [NSString stringWithFormat:@"%@%f,%f&key=AIzaSyAsZ171sgZHuTcapToLRQ5-W9dl_WRLOh4",geocodingBaseURL, 32.8710765, -117.2012524];
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
    _storeLat = [[location valueForKey:@"lat"] doubleValue];
    _storeLng = [[location valueForKey:@"lng"] doubleValue];

    
//    NSLog(@"results are %@", results);
    
    NSLog(@"results are %@", [[results objectAtIndex:0] objectForKey:@"formatted_address"]);
    NSString *formattedAddress = [[results objectAtIndex:0] objectForKey:@"formatted_address"];
    NSLog(@"formatted address is %@", formattedAddress);

    
    NSArray *strings = [formattedAddress componentsSeparatedByString:@", "];
    for(id string in strings)
        NSLog(@"string is %@", string);
    
    NSArray *strings2 = [[strings objectAtIndex:2] componentsSeparatedByString:@" "];
    for(id string2 in strings2)
        NSLog(@"string2 is %@", string2);


    if (strings.count > 2){                                   //check snapshot is null
        _address.text = [strings objectAtIndex:0] ;
        _cityStateZip.text = [[[[[strings objectAtIndex:1]
                                stringByAppendingString:@", "]
                              stringByAppendingString:[strings2 objectAtIndex:0]]
                              stringByAppendingString:@", "]
                            stringByAppendingString:[strings2 objectAtIndex:1]];
        [self checkAllTextFieldLength];

        
        
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:_storeLat
                                                                longitude:_storeLng
                                                                     zoom:16];
        GMSMapView *mapView = [GMSMapView mapWithFrame:_mapView.bounds camera:camera];
        [_mapView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
        [_mapView addSubview:mapView];
        
        CLLocationCoordinate2D position = CLLocationCoordinate2DMake(_storeLat, _storeLng);
        GMSMarker *marker = [GMSMarker markerWithPosition:position];
        marker.icon = [UIImage imageNamed:@"markerSmartObject"];
        marker.infoWindowAnchor = CGPointMake(0.44f, 0.45f);
        //        marker.title = tempStore.storeName;
        marker.map = mapView;
    }
}

-(void) checkAllTextFieldLength{
    NSMutableArray* emptyTextFieldArray = [[NSMutableArray alloc] init];

    for(UIView *view in _contentVIew.subviews){
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)view;
            if (textField.text.length == 0) {
                if (textField.tag != 3) {
                    [emptyTextFieldArray addObject:textField];
                }
            }
        }
    }
    if (emptyTextFieldArray.count == 0) {
        _confirmButton.enabled = YES;
    }
    else
        _confirmButton.enabled = NO;
}

- (IBAction)tappedConfirmButton:(id)sender {
    NSString *lowerString = [_storeName.text lowercaseString];
    NSString *stringLat = [NSString stringWithFormat:@"%lf", _storeLat];
    NSString *stringLng = [NSString stringWithFormat:@"%lf", _storeLng];
    
    storeClass *store2 = [[storeClass alloc] init];
    store2.storeKey = [[firebaseRef.ref child:@"toBeReviewedStoreKeys"]  childByAutoId].key;
    [[[[firebaseRef.ref  child:@"toBeReviewedStoreNames"]  child:store2.storeKey] child:@"lowerName"] setValue:lowerString];
    [[[[firebaseRef.ref  child:@"toBeReviewedStoreNames"]  child:store2.storeKey] child:@"name"] setValue:_storeName.text];
    [[[[firebaseRef.ref  child:@"toBeReviewedStoreHours"]  child:store2.storeKey] child:@"storeHours"] setValue:_storeHours.text];
    [[[[firebaseRef.ref  child:@"toBeReviewedPhoneNumbers"]  child:store2.storeKey] child:@"phoneNumber"] setValue:_phoneNumber.text];
    [[[[firebaseRef.ref  child:@"toBeReviewedLocation"]  child:store2.storeKey] child:@"address"] setValue:_address.text];
    [[[[firebaseRef.ref  child:@"toBeReviewedLocation"]  child:store2.storeKey] child:@"cityStateZip"] setValue:_cityStateZip.text];
    [[[[firebaseRef.ref  child:@"toBeReviewedLocation"]  child:store2.storeKey] child:@"latitude"] setValue:stringLat];
    [[[[firebaseRef.ref  child:@"toBeReviewedLocation"]  child:store2.storeKey] child:@"longitude"] setValue:stringLng];
    
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Store submitted"
                                 message:@"Thank you for helping the Cheeba community grow. Your store will be reviewed by our moderators for duplicate or make available in search."
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    [self dismissAddStoreViewController];
                                }];
    
    
    [alert addAction:okButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void) dismissAddStoreViewController{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)address_field_changed:(id)sender {
    store.address = _address.text;
}

- (IBAction)city_field_changed:(id)sender {
    store.city = _cityStateZip.text;
}

- (IBAction)state_field_changed:(id)sender {
//    store.state = _state_field.text;
}



- (void) geocodeAddress:(NSString *)address{

    NSString *geocodingBaseURL = @"https://maps.googleapis.com/maps/api/geocode/json?";
    NSString *url = [NSString stringWithFormat:@"%@address=%@&key=AIzaSyAsZ171sgZHuTcapToLRQ5-W9dl_WRLOh4", geocodingBaseURL, address];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *queryURL = [NSURL URLWithString:url];
    NSData *data = [NSData dataWithContentsOfURL:queryURL];
    [self fetchedData:data];
}

- (void) fetchedData:(NSData *)data{
    NSError *error;
    NSDictionary *json = [NSJSONSerialization
                          JSONObjectWithData:data
                          options:kNilOptions
                          error:&error];
    NSArray *results = [json objectForKey:@"results"];
    NSDictionary *result = [results objectAtIndex:0];
    NSDictionary *geometry = [result objectForKey:@"geometry"];
    NSDictionary *location = [geometry objectForKey:@"location"];
    store.latitude = [location objectForKey:@"lat"];
    store.longitude = [location objectForKey:@"lng"];
    store.googlePlaceID = [result objectForKey:@"place_id"];
}

- (void)loadFirstPhotoForPlace:(NSString *)placeID {
    GMSPlacesClient *place_client = [GMSPlacesClient sharedClient];
    [place_client lookUpPhotosForPlaceID:placeID callback:^(GMSPlacePhotoMetadataList *_Nullable photos, NSError *_Nullable error) {
        if (error) {
            // TODO: handle the error.
            NSLog(@"loadFirstPhotoForPlace Error: %@", [error description]);
        } else {
            if (photos.results.count > 0) {
                GMSPlacePhotoMetadata *firstPhoto = photos.results.firstObject;
//                [self loadImageForMetadata:firstPhoto];
            }
        }
    }];
}

//- (void)loadImageForMetadata:(GMSPlacePhotoMetadata *)photoMetadata {
//    GMSPlacesClient *place_client = [GMSPlacesClient sharedClient];
//    [place_client loadPlacePhoto:photoMetadata constrainedToSize:self.imageView.bounds.size scale:self.imageView.window.screen.scale callback:^(UIImage *_Nullable photo, NSError *_Nullable error) {
//        if (error) {
//            NSLog(@"Error: %@", [error description]);
//        } else {
//            [self.imageView setImage: photo];
//            _imageSelected = true;
//            [self loadImagesToClassObject:photo];
//        }
//    }];
//}

//- (IBAction)tappedImageView:(UITapGestureRecognizer *)sender {
//    NSString *geocodingBaseURL = @"https://maps.googleapis.com/maps/api/place/textsearch/json?";
//    NSString *url = [NSString stringWithFormat:@"%@query=dispensary&location=%f,%f&radius=13000&type=dispensary&key=AIzaSyAsZ171sgZHuTcapToLRQ5-W9dl_WRLOh4",geocodingBaseURL, user.latitude, user.longitude];
//    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURL *queryURL = [NSURL URLWithString:url];
//    NSData *data = [NSData dataWithContentsOfURL:queryURL];
//    NSError *error;
//    NSDictionary *json = [NSJSONSerialization
//                          JSONObjectWithData:data
//                          options:kNilOptions
//                          error:&error];
//    NSArray *results = [json objectForKey:@"results"];
//    //    NSLog(@"results are %@", results);
//    
//    
//
//    NSArray *storeNames = [objectsArray.storeObjectArray valueForKey:@"storeName"];
//    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Are you trying to add.." message:@"" preferredStyle:UIAlertControllerStyleAlert];
//
//
//    for (NSInteger i = 0; i < results.count; i++) {
//        NSDictionary *result = [results objectAtIndex:i];
////        NSLog(@"result is %@", result);
//        NSString *name = [result objectForKey:@"name"];
//        NSString *placeID = [result objectForKey:@"place_id"];
//
//        
//        
//        
//    NSString * address = [result objectForKey:@"formatted_address"];
//    NSError * err;
//    NSDataDetector * addrParser = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeAddress
//                                                                  error:&err];
//    __block NSDictionary * addressParts;
//    if( addrParser ){
//        [addrParser enumerateMatchesInString:address
//                                     options:0
//                                       range:(NSRange){0, [address length]}
//                                  usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
//                                      addressParts = [result addressComponents];
//                                  }];
//    }
//    
////    NSLog(@"%@", addressParts);
//
//        //    NSDictionary *geometry = [result objectForKey:@"geometry"];
//        //    NSDictionary *location = [geometry objectForKey:@"location"];
//        //    store.latitude = [location objectForKey:@"lat"];
//        //    store.longitude = [location objectForKey:@"lng"];
//        //    store.googlePlaceID = [result objectForKey:@"place_id"];
//        if (![storeNames containsObject:name]) {
//            [actionSheet addAction:[UIAlertAction actionWithTitle:name style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                
//                _storeName.text = name;
//                _address.text = [addressParts objectForKey:@"Street"];
//                _cityStateZip.text = [addressParts objectForKey:@"City"];
////                _state_field.text = [addressParts objectForKey:@"State"];
//                
//            
//                NSString *geocodingBaseURL = @"https://maps.googleapis.com/maps/api/place/details/json?";
//                NSString *url = [NSString stringWithFormat:@"%@placeid=%@&key=AIzaSyAsZ171sgZHuTcapToLRQ5-W9dl_WRLOh4",geocodingBaseURL, placeID];
//                url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//                NSURL *queryURL = [NSURL URLWithString:url];
//                NSData *data = [NSData dataWithContentsOfURL:queryURL];
//                NSError *error;
//                NSDictionary *json = [NSJSONSerialization
//                                      JSONObjectWithData:data
//                                      options:kNilOptions
//                                      error:&error];
//                NSDictionary *results = [json objectForKey:@"result"];
////                NSLog(@"result is %@", json );
////                NSLog(@"result is %@", results );
//                _phoneNumber.text = [results objectForKey:@"formatted_phone_number"];
//                
//                    [[GMSPlacesClient sharedClient]
//                     lookUpPhotosForPlaceID:placeID
//                     callback:^(GMSPlacePhotoMetadataList *_Nullable photos,
//                                NSError *_Nullable error) {
//                         if (error) {
//                             // TODO: handle the error.
//                             NSLog(@"Error: %@", [error description]);
//                         } else {
//                             if (photos.results.count > 0) {
//                                 GMSPlacePhotoMetadata *firstPhoto = photos.results.firstObject;
//                                 [[GMSPlacesClient sharedClient]
//                                  loadPlacePhoto:firstPhoto
//                                  constrainedToSize:self.imageView.bounds.size
//                                  scale:self.imageView.window.screen.scale
//                                  callback:^(UIImage *_Nullable photo, NSError *_Nullable error) {
//                                      if (error) {
//                                          // TODO: handle the error.
//                                          NSLog(@"Error: %@", [error description]);
//                                      } else {
//                                          self.imageView.image = photo;
//                                          //self.attributionTextView.attributedText = firstPhoto.attributions;
//                                      }
//                                  }];
//                             }
//                         }
//                     }];
//
//
//            }]];
//
//        }
//    }
//    
//    
//    
//    
////    [actionSheet addAction:[UIAlertAction actionWithTitle:[mArray objectAtIndex:0] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
////        
////        // Cancel button tappped.
////        [self dismissViewControllerAnimated:YES completion:^{
////        }];
////    }]];
////
////    [actionSheet addAction:[UIAlertAction actionWithTitle:[mArray objectAtIndex:1] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
////        
////        // Cancel button tappped.
////        [self dismissViewControllerAnimated:YES completion:^{
////        }];
////    }]];
////
////    [actionSheet addAction:[UIAlertAction actionWithTitle:[mArray objectAtIndex:2] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
////        
////        // Cancel button tappped.
////        [self dismissViewControllerAnimated:YES completion:^{
////        }];
////    }]];
////    
//
//    [self presentViewController:actionSheet animated:YES completion:nil];
//
//    
//    
//    
//    
//
//    
////    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select Image" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
////    
////    picker2 = [[UIImagePickerController alloc] init];
////    picker = [[UIImagePickerController alloc] init];
////
////    
////    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
////        self->picker2.delegate = self;
////        [picker2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
////        [self presentViewController:picker2 animated:YES completion:NULL];
////        // Distructive button tapped.[self dismissViewControllerAnimated:YES completion:^{}];
////    }]];
////    
////    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
////        self->picker.delegate = self;
////        [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
////        [self presentViewController:picker animated:YES completion:NULL];
////        // OK button tapped. [self dismissViewControllerAnimated:YES completion:^{}];
////    }]];
////    
////    // Present action sheet.
////    [self presentViewController:actionSheet animated:YES completion:nil];
//
////}

//- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
//    image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    self.imageView.contentMode  = UIViewContentModeScaleAspectFit;
//    [self.imageView setImage:image];
//    _imageSelected = true;
//    [self loadImagesToClassObject:image];
//    [self dismissViewControllerAnimated:YES completion:NULL];
//}

- (void) loadImagesToClassObject:(UIImage *)Image{
    //store.medium_image = [[self class] imageWithImage:Image scaledToWidth:1500];
    //store.small_image = [[self class] imageWithImage:Image scaledToWidth:100];
}

+(UIImage*)imageWithImage: (UIImage*) sourceImage scaledToWidth: (float) i_width
{
    float oldWidth = sourceImage.size.width;
    float scaleFactor = i_width / oldWidth;
    
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void) updateClassObjectValues {
    store.storeName = _storeName.text;
    store.address = _address.text;
    store.city = _cityStateZip.text;
//    store.state = _state_field.text;
    store.phone_number = _phoneNumber.text;
}

- (void) updateFirebaseValues{
    [[[firebaseRef.storesRef child:store.storeKey] child:@"storeName"] setValue:store.storeName];
    [[[[firebaseRef.storesRef child:store.storeKey] child:@"location"] child:@"address" ] setValue:store.address];
    [[[[firebaseRef.storesRef child:store.storeKey] child:@"location"] child:@"city" ] setValue:store.city];
    [[[[firebaseRef.storesRef child:store.storeKey] child:@"location"] child:@"state" ] setValue:store.state];
    [[[[firebaseRef.storesRef child:store.storeKey] child:@"location"] child:@"latitude" ] setValue:store.latitude];
    [[[[firebaseRef.storesRef child:store.storeKey] child:@"location"] child:@"longitude" ] setValue:store.longitude];
    [[[firebaseRef.storesRef child:store.storeKey] child:@"phoneNumber"] setValue:store.phone_number];
    [[[firebaseRef.storesRef child:store.storeKey] child:@"googlePlaceID"] setValue:store.googlePlaceID];
    [[[firebaseRef.storesRef child:store.storeKey] child:@"url"]  setValue:store.url];
    [[[firebaseRef.storesRef child:store.storeKey] child:@"phoneNumber"] setValue:store.phone_number];
    [[[firebaseRef.storesRef child:store.storeKey] child:@"ratingCount"] setValue:@""];
    [[[firebaseRef.storesRef child:store.storeKey] child:@"ratingScore"] setValue:@""];
    [[[firebaseRef.storesRef child:store.storeKey] child:@"sells"] setValue:@""];
}

- (NSDictionary *)storeLocation{
    NSDictionary *dictionaryLocation= @{@"address": @"",
                                        @"city":@"",
                                        @"state":@"",
                                        @"latitude":@"",
                                        @"longitude":@"",};
    return dictionaryLocation;
}

- (NSDictionary *)storeStats{
    NSDictionary *strainStats= @{@"totalCount":@"",
                                 @"monthlyCount":@"",
                                 @"totalUserCount":@""};
    return strainStats;
}
- (IBAction)tappedCancelButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];

}
- (IBAction)tapped_submit_button:(UIButton *)sender {
    if(_imageSelected){
        [self geocodeAddress:_address.text];
        NSDictionary *dict2 = [self storeLocation];
        NSDictionary *dict3 = [self storeStats];
        store.storeKey = [firebaseRef.storesRef childByAutoId].key;
  
        [[[firebaseRef.storesRef child:store.storeKey] child:@"location"]setValue:dict2];
        [[[firebaseRef.storesRef child:store.storeKey] child:@"stats"]setValue:dict3];
        
        [self updateClassObjectValues];
        [self updateFirebaseValues];
        
        CGSize size = CGSizeMake(500, 500);
//        UIImage *sizedImage = [[self class] imageWithImage:self.imageView.image scaledToSize:size];
        //NSString *encodedString = [UIImagePNGRepresentation(self.strainImageView.image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//        NSData *encodedString = UIImagePNGRepresentation(sizedImage);
//        NSData *encodedString1 = UIImagePNGRepresentation(self.imageView.image);
        
        
        
        
        
//        NSString *stringForm = [encodedString base64EncodedStringWithOptions:0];
//        NSString *stringForm1 = [encodedString1 base64EncodedStringWithOptions:0];
//        [[[firebaseRef.storesRef child:store.storeKey] child:@"data"] setValue:stringForm];
//        NSUInteger bytes = [stringForm lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
//        NSLog(@"%lu bytes", bytes);
//        NSUInteger bytes1 = [stringForm1 lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
//        NSLog(@"XXXXX%lu bytes", bytes1);
//        [[[firebaseRef.storesRef child:store.storeKey] child:@"data"] setValue:stringForm1];
//        NSLog(@"%@", stringForm1);

        
        
        
        
        
        //NSLog(@"image encoded= %@", encodedString);
        
        NSURL *theURL = [NSURL URLWithString:@"https://api.imgur.com/3/image"];
        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0f];
        
        //Specify method of request(Get or Post)
        [theRequest setHTTPMethod:@"POST"];
        
        //Pass some default parameter(like content-type etc.)
        [theRequest setValue:@"Client-ID bceb6364428afba" forHTTPHeaderField:@"Authorization"];
        
        //[theRequest setValue:encodedString forHTTPHeaderField:@"image"];
//        [theRequest setHTTPBody:encodedString1];
        NSURLResponse *theResponse = NULL;
        NSError *theError = NULL;
        NSData *theResponseData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&theResponse error:&theError];
        
        NSDictionary *dataDictionaryResponse = [NSJSONSerialization JSONObjectWithData:theResponseData options:0 error:&theError];
        //NSLog(@"url to send request= %@",theURL);
        //NSLog(@"%@",dataDictionaryResponse);
        
        NSDictionary *output = [dataDictionaryResponse valueForKey:@"data"];
        NSString *imageURL = [output valueForKey:@"link"];
        NSLog(@"url is %@", imageURL);
        
//        [store.imageNames removeAllObjects];
//        [store.imageNames addObject:imageURL];

        [[[[firebaseRef.storesRef child:store.storeKey] child:@"images"] child:@"1" ] setValue:imageURL];

        [self performSegueWithIdentifier:@"createdStoreSegue" sender:self];

        /*[uploadTask observeStatus:FIRStorageTaskStatusSuccess handler:^(FIRStorageTaskSnapshot *snapshot) {
            [self performSegueWithIdentifier:@"createdStoreSegue" sender:self];
        }];*/

    }
    else if (!_imageSelected){
        [user presentImageNotSelectedAlert:self];
    }
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end
