//
//  EditStoreViewController.m
//  myProject
//
//  Created by Guy on 9/19/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import "EditStoreViewController.h"

@interface EditStoreViewController ()

@end

@implementation EditStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tabBar.delegate = self;
    [self loadTabBar];
    [self loadTextFields];
    [self loadMap];
    
    [_confirmButton addTarget:self
                         action:@selector(tappedConfirm:)
               forControlEvents:UIControlEventTouchUpInside];
    
    [_addressField addTarget:self
                    action:@selector(addressFieldDidEndEditing:)
          forControlEvents:UIControlEventEditingDidEnd];
    
    [_cityStateZipField addTarget:self
                   action:@selector(cityStateZipFieldDidEndEditing:)
         forControlEvents:UIControlEventEditingDidEnd];



    // Do any additional setup after loading the view.
}

-(void) tappedConfirm:(UIButton *)button{
    NSArray *strings = [_cityStateZipField.text componentsSeparatedByString:@", "];
    NSString *stringLat = [NSString stringWithFormat:@"%lf", _storeLat];
    NSString *stringLng = [NSString stringWithFormat:@"%lf", _storeLng];

    
    [[[[firebaseRef.ref child:@"phoneNumbers"] child:store.storeKey] child:@"phoneNumber"] setValue:_phoneNumberField.text];
    [[[[firebaseRef.ref child:@"location"] child:store.storeKey] child:@"address"] setValue:_addressField.text];
    [[[[firebaseRef.ref child:@"location"] child:store.storeKey] child:@"latitude"] setValue:stringLat];
    [[[[firebaseRef.ref child:@"location"] child:store.storeKey] child:@"longitude"] setValue:stringLng];
    
    if (strings.count > 2){                                   //check snapshot is null
        [[[[firebaseRef.ref child:@"location"] child:store.storeKey] child:@"city"] setValue:[strings objectAtIndex:0]];
        [[[[firebaseRef.ref child:@"location"] child:store.storeKey] child:@"state"] setValue:[strings objectAtIndex:1]];
        [[[[firebaseRef.ref child:@"location"] child:store.storeKey] child:@"zipcode"] setValue:[strings objectAtIndex:2]];
    }
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Store updated"
                                 message:@"Successfully updated your store."
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   [self.navigationController popToRootViewControllerAnimated:YES];
                               }];
    
    
    [alert addAction:okButton];
    
    [self presentViewController:alert animated:YES completion:nil];
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

-(void) addressFieldDidEndEditing:(UITextField *) textField{
    _addressField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Address" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1.0]}];
    if ((_addressField.text.length > 0) && (_cityStateZipField.text.length > 0)) {
        [self moveMapFromStoreAddress];
    }
}

-(void) cityStateZipFieldDidEndEditing:(UITextField *) textField{
    _cityStateZipField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"City, State, Zip" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1.0]}];

    if ((_addressField.text.length > 0) && (_cityStateZipField.text.length > 0)) {
        [self moveMapFromStoreAddress];
    }
}

-(void) moveMapFromStoreAddress{
    NSString *address = [_addressField.text stringByAppendingString:_cityStateZipField.text];
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


-(void)loadTextFields{
    _storeNameLabel.text = store.storeName;
    _addressField.text = store.address;
    NSString *string = [[[[store.city stringByAppendingString:@", "]
                          stringByAppendingString:store.state]
                         stringByAppendingString:@" "]
                        stringByAppendingString:store.zipcode ];
    _cityStateZipField.text = string ;
    _phoneNumberField.text = store.phone_number;
    _storeHoursField.text = store.storeHours;
}

-(void)loadTabBar{
    _tabBar.barTintColor = [UIColor colorWithRed:18.0/255.0 green:24.0/255.0 blue:23.0/255.0 alpha:1.0];
    
    _promosTabBarItem.image = [[UIImage imageNamed:@"notSelectedAboutIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    _promosTabBarItem.selectedImage = [[UIImage imageNamed:@"selectedAboutIcon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    _strainsTabBarItem.image = [[UIImage imageNamed:@"notSelectedStrainIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    _strainsTabBarItem.selectedImage = [[UIImage imageNamed:@"selectedStrainIcon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    _reviewsTabBarItem.image = [[UIImage imageNamed:@"notSelectedReviewsIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _reviewsTabBarItem.selectedImage = [[UIImage imageNamed:@"selectedReviewsIcon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _tabBar.selectedItem = _promosTabBarItem;
    
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITableViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Edit Store Promos SB ID"];
    [self addChildViewController:vc];
    vc.tableView.frame = CGRectMake(0, 0, _containerView.frame.size.width, _containerView.frame.size.height);
    [_containerView addSubview:vc.tableView];
    [vc didMoveToParentViewController:self];
    [_scrollView setContentOffset:CGPointMake(0, 381) animated:YES];
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
//    [_tablevc.tableView removeFromSuperview];
    
    if(item.tag == 1) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UITableViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Edit Store Promos SB ID"];
        [self addChildViewController:vc];
        vc.tableView.frame = CGRectMake(0, 0, _containerView.frame.size.width, _containerView.frame.size.height);
        [_containerView addSubview:vc.tableView];
        [vc didMoveToParentViewController:self];
        [_scrollView setContentOffset:CGPointMake(0, 381) animated:YES];
    }
    else if(item.tag == 2) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UITableViewController *vc = [sb instantiateViewControllerWithIdentifier:@"editStoreStrainsSBID"];
        [self addChildViewController:vc];
        vc.tableView.frame = CGRectMake(0, 0, _containerView.frame.size.width, _containerView.frame.size.height);
        [_containerView addSubview:vc.tableView];
        [vc didMoveToParentViewController:self];
        [_scrollView setContentOffset:CGPointMake(0, 381) animated:YES];
    }
    else if(item.tag == 3) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UITableViewController *vc = [sb instantiateViewControllerWithIdentifier:@"reviewsSBID"];
        [self addChildViewController:vc];
        vc.tableView.frame = CGRectMake(0, 0, _containerView.frame.size.width, _containerView.frame.size.height);
        [_containerView addSubview:vc.tableView];
        [vc didMoveToParentViewController:self];
        [_scrollView setContentOffset:CGPointMake(0, 381) animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
