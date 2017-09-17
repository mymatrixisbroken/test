//
//  ViewController.m
//  Demo
//
//  Created by Nelson on 12/11/27.
//  Copyright (c) 2012年 Nelson. All rights reserved.
//

#import "ViewController.h"
#import "CHTCollectionViewWaterfallCell.h"
#import "CHTCollectionViewWaterfallHeader.h"
#import "CHTCollectionViewWaterfallFooter.h"

#define CELL_COUNT 30
#define CELL_IDENTIFIER @"WaterfallCell"
#define HEADER_IDENTIFIER @"WaterfallHeader"
#define FOOTER_IDENTIFIER @"WaterfallFooter"

@interface ViewController ()
@property (nonatomic, strong) NSArray *cellSizes;
@property (nonatomic, strong) NSArray *cats;
@end

@implementation ViewController

#pragma mark - Accessors

- (UICollectionView *)collectionView {
  if (!_collectionView) {
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];

    layout.sectionInset = UIEdgeInsetsMake(3, 3, 3 ,3);
      layout.columnCount = 1;
    layout.headerHeight = 0;
    layout.footerHeight = 0;
    layout.minimumColumnSpacing = 25;
    layout.minimumInteritemSpacing = 1;
      
      
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[CHTCollectionViewWaterfallCell class]
        forCellWithReuseIdentifier:CELL_IDENTIFIER];
    [_collectionView registerClass:[CHTCollectionViewWaterfallHeader class]
        forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
               withReuseIdentifier:HEADER_IDENTIFIER];
    [_collectionView registerClass:[CHTCollectionViewWaterfallFooter class]
        forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
               withReuseIdentifier:FOOTER_IDENTIFIER];
  }
  return _collectionView;
}

- (NSArray *)cellSizes {
  if (!_cellSizes) {
    _cellSizes = @[
      [NSValue valueWithCGSize:CGSizeMake(2048, 1000)],
      [NSValue valueWithCGSize:CGSizeMake(2048, 1000)],
      [NSValue valueWithCGSize:CGSizeMake(2048, 1000)],
      [NSValue valueWithCGSize:CGSizeMake(2048, 1000)]
    ];
  }
  return _cellSizes;
}

#pragma mark - Life Cycle

- (void)dealloc {
  _collectionView.delegate = nil;
  _collectionView.dataSource = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (objectsArray.filterSelected == nearMeRecommended) {
        [self getUserCurrentLocation];
    }
    [self loadStoreStrain];

    
    //******************** Extension view *************************//
    self.shyNavBarManager.scrollView = self.collectionView;
    [self.view addSubview:self.collectionView];
    [self loadExtView];

    
    
                //******************** Search Bar Code *************************//
                //    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
                //    _searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
                //    _searchBar.showsCancelButton = YES;
                //    _searchBar.delegate = self;
                //    _searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
                //
                //    if (objectsArray.filterSelected == search) {
                //        [UIView animateWithDuration:0.5 animations:^{
                //            //        _rightButton.alpha = 0.0f;
                //
                //        } completion:^(BOOL finished) {
                //
                //            self.navigationController.navigationBar.topItem.rightBarButtonItems = nil;
                //            self.navigationController.navigationBar.topItem.titleView = _searchBar;
                //            _searchBar.alpha = 0.0;
                //
                //            [UIView animateWithDuration:0.5
                //                             animations:^{
                //                                 _searchBar.alpha = 1.0;
                //                             } completion:^(BOOL finished) {
                //                                 [_searchBar becomeFirstResponder];
                //                             }];
                //        }];
                //    }
                //******************** Search Bar Code *************************//


                //******************** Refresh pull down code *************************//
                //    if (_refresh == nil) {
                //        _refresh = [[UIRefreshControl alloc] init];
                //    }
                //    
                //    _refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
                //    [self.collectionView addSubview:_refresh];
                //    [_refresh addTarget:self action:@selector(refreshTableau:) forControlEvents:UIControlEventValueChanged];
                //******************** Refresh pull down code *************************//

                //******************** Load collection view to index *************************//

                //    UIBarButtonItem *rightButton1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings"] style:UIBarButtonItemStylePlain target:self   action:@selector(barButtonMenuPressed:)];
                //    self.navigationController.navigationBar.topItem.rightBarButtonItem = rightButton1;
                //    if ((NSInteger)[store.indexPath row] > 0) {
                //        NSIndexPath *ipath = [NSIndexPath indexPathForRow:8 inSection:0];
                //        [store.indexPath setValue:(int)[store.indexPath row]  forKey:@"path"];
                //        [self.collectionView scrollToItemAtIndexPath:ipath atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
                //    }
                //******************** Load collection view to index *************************//

}

//******************** Required for filter menu popover *************************//
- (UIModalPresentationStyle) adaptivePresentationStyleForPresentationController: (UIPresentationController * ) controller {
    return UIModalPresentationNone;
}


-(IBAction) filterButtonTapped:(UIButton*)btn
{
    //******************** Pop over filter menu for strains *************************//
    if (objectsArray.strainOrStore == strains) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"listStrainsFilterSBID"];
        vc.modalPresentationStyle = UIModalPresentationPopover;
        vc.preferredContentSize = CGSizeMake(175, 132);
        
        UIPopoverPresentationController *popOver = vc.popoverPresentationController;
        
        popOver.delegate = self;
        popOver.sourceView = _extView;
        popOver.sourceRect = btn.frame;
        popOver.permittedArrowDirections = UIPopoverArrowDirectionUp;
        popOver.backgroundColor = [UIColor colorWithRed:7.0/255.0 green:18.0/255.0 blue:17.0/255.0 alpha:1.0];
        
        [self presentViewController:vc animated:YES completion:NULL];
    }
    
    
    //******************** Pop over filter menu for stores *************************//
    else if (objectsArray.strainOrStore == stores){
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"listStoresFilterSBID"];
        vc.modalPresentationStyle = UIModalPresentationPopover;
        vc.preferredContentSize = CGSizeMake(175, 220);
        
        UIPopoverPresentationController *popOver = vc.popoverPresentationController;

        popOver.delegate = self;
        popOver.sourceView = _extView;
        popOver.sourceRect = btn.frame;
        popOver.permittedArrowDirections = UIPopoverArrowDirectionUp;
        popOver.backgroundColor = [UIColor colorWithRed:7.0/255.0 green:18.0/255.0 blue:17.0/255.0 alpha:1.0];
        
        [self presentViewController:vc animated:YES completion:NULL];
    }
}


//******************** Get user current location *************************//
- (IBAction)getUserCurrentLocation {
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
    
    user.latitude = coordinate.latitude;
    user.longitude = coordinate.longitude;
    
    [_locationManager stopUpdatingLocation];

    NSString *geocodingBaseURL = @"https://maps.googleapis.com/maps/api/geocode/json?address=";
    NSString *url = [NSString stringWithFormat:@"%@%f,%f&key=AIzaSyAsZ171sgZHuTcapToLRQ5-W9dl_WRLOh4",geocodingBaseURL, user.latitude, user.longitude];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *queryURL = [NSURL URLWithString:url];
    NSData *data = [NSData dataWithContentsOfURL:queryURL];
    NSError *error;
    NSDictionary *json = [NSJSONSerialization
                          JSONObjectWithData:data
                          options:kNilOptions
                          error:&error];
    NSArray *results = [json objectForKey:@"results"];
    
    for (NSInteger i = 0; i < results.count; i++) {
        NSDictionary *result = [results objectAtIndex:0];
        NSArray * address = [result objectForKey:@"address_components"];
        
        for (NSInteger i = 0; i <address.count; i++) {
            NSDictionary *dict = [address objectAtIndex:i];
            NSString *types = [[dict objectForKey:@"types"] objectAtIndex:0];
            
            if ([types isEqual:@"administrative_area_level_2"]) {
                NSString *county = [dict objectForKey:@"long_name"];
                user.county = county;
            }
        }
    }
}



//******************** Configuring Extension View *************************//
- (void) loadExtView{
    _extView = [[extensionViewClass alloc] init];
    [_extView setView:CGRectGetWidth(self.view.bounds)];
    [_extView addButtons:CGRectGetWidth(self.view.bounds)];

    [_extView.fourthButton addTarget:self action:@selector(filterButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    if(objectsArray.strainOrStore == strains){
        [_extView.extensionViewLabel setText:@"Strains"];
    }
    if(objectsArray.strainOrStore == stores){
        [_extView.extensionViewLabel setText:@"Stores & Clubs"];
    }

    [self.view bringSubviewToFront:_extView];
    [self.shyNavBarManager setExtensionView:_extView];
    [self.shyNavBarManager setStickyExtensionView:NO];
}


//******************** Extension View Button Action *************************//
-(IBAction)storeButtonPressed:(UIButton*)btn {
    objectsArray.filterSelected = 10;
    objectsArray.strainOrStore = stores;
    [user goToStrainsStoresViewController:self];
}
-(IBAction)strainButtonPressed:(UIButton*)btn {
    objectsArray.filterSelected = 10;
    objectsArray.strainOrStore = strains;
    [user goToStrainsViewController:self];
}
-(IBAction)newsFeedButtonPressed:(UIButton*)btn {
    [user goToNewsFeedViewController:self];
}
-(IBAction)userProfileButtonPressed:(UIButton*)btn {
    FIRUser *youser = [FIRAuth auth].currentUser;
    if(youser.anonymous){
        [user goToUserNotSignedInViewController:self];
    }
    else{
        [user goToCurrentUserProfileViewController:self];
    }
}


//******************** Load strain or store objects *************************//
- (void) loadStoreStrain{
    switch (objectsArray.filterSelected) {
        case 10:
            //******************** Initialize *************************//
            _filteredObjectsArray = [[objectsArrayClass alloc] init];
            objectsArray = [[objectsArrayClass alloc] init];

            //******************** Load objects *************************//
            [self newLoadStores];
//            [self loadstrains];
//            [self loadStores];
            
            break;
        case 1:
            if (objectsArray.strainOrStore == strains){
                //******************** Load your recommended strains *************************//
                
                //******************** Initialize *************************//
                _filteredObjectsArray = [[objectsArrayClass alloc] init];
            }
            else if (objectsArray.strainOrStore == stores){
                
                //******************** Initialize *************************//
                _filteredObjectsArray = [[objectsArrayClass alloc] init];
                
                //******************** Load distance from user to stores *************************//
                
                //******************** Sort *************************//
                [_filteredObjectsArray.storeObjectArray sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"distanceValue" ascending:YES selector:@selector(compare:)]]];
                
                //******************** Reload *************************//
                [self.collectionView reloadData];}
            break;
        case 2:
            if (objectsArray.strainOrStore == strains){
                
                //******************** Initialize *************************//
                _filteredObjectsArray.strainObjectArray = [[NSMutableArray alloc] init];
                
                //******************** Copy from array data store to filtered array *************************//
                for (int i = 0; i <objectsArray.strainObjectArray.count; i++)
                    [_filteredObjectsArray.strainObjectArray addObject:[objectsArray.strainObjectArray objectAtIndex:i]];
                
                //******************** Sort *************************//
                [_filteredObjectsArray.strainObjectArray sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"strainName" ascending:YES selector:@selector(caseInsensitiveCompare:)]]];
                
                //******************** Reload *************************//
                [self.collectionView reloadData];}
            
            else if (objectsArray.strainOrStore == stores){
                
                //******************** Initialize *************************//
                _filteredObjectsArray = [[objectsArrayClass alloc] init];

                //******************** Copy from array data store to filtered array *************************//
                for (int i = 0; i <objectsArray.storeObjectArray.count; i++)
                    [_filteredObjectsArray.storeObjectArray addObject:[objectsArray.storeObjectArray objectAtIndex:i]];
                
                //******************** Sort *************************//
                [_filteredObjectsArray.storeObjectArray sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"storeName" ascending:YES selector:@selector(caseInsensitiveCompare:)]]];
                
                //******************** Reload *************************//
                [self.collectionView reloadData];}
            break;
            
        case 3:
            if (objectsArray.strainOrStore == strains){
                
                //******************** Initialize *************************//
                _filteredObjectsArray = [[objectsArrayClass alloc] init];

                //******************** Match strain tried key with objects strain key *************************//
                for (int i = 0; i < user.strainsTried.count; i++) {
                    NSString *strainsTriedKey = [user.strainsTried objectAtIndex:i];
                    for(int j = 0; j < objectsArray.strainObjectArray.count; j++){
                        strainClass *tempStrain = [objectsArray.strainObjectArray objectAtIndex:j];
                        if ([strainsTriedKey isEqual:tempStrain.strainKey]) {
                            [_filteredObjectsArray.strainObjectArray addObject:tempStrain];}}}
                
                //******************** Reload *************************//
                [self.collectionView reloadData];}
            
            else if (objectsArray.strainOrStore == stores){
                //******************** Initialize *************************//
                _filteredObjectsArray = [[objectsArrayClass alloc] init];

                //******************** Match store visited key with objects store key *************************//
                for (int i = 0; i < user.storesVisited.count; i++) {
                    NSString *storeVisitedKey = [user.storesVisited objectAtIndex:i];
                    for(int j = 0; j < objectsArray.storeObjectArray.count; j++){
                        storeClass *tempStore = [objectsArray.storeObjectArray objectAtIndex:j];
                        if ([storeVisitedKey isEqual:tempStore.storeKey]) {
                            [_filteredObjectsArray.storeObjectArray addObject:tempStore];}}}
                
                //******************** Reload *************************//
                [self.collectionView reloadData];}
            break;
            
        case 4:
            //******************** Initialize *************************//
            _filteredObjectsArray = [[objectsArrayClass alloc] init];

            //******************** Match store wishlist key with objects store key *************************//
            for (int i = 0; i < user.wishList.count; i++) {
                NSString *wishListKey = [user.wishList objectAtIndex:i];
                for(int j = 0; j < objectsArray.strainObjectArray.count; j++){
                    strainClass *tempStrain = [objectsArray.strainObjectArray objectAtIndex:j];
                    if ([wishListKey isEqual:tempStrain.strainKey]) {
                        [_filteredObjectsArray.strainObjectArray addObject:tempStrain];}}}
            
            //******************** Reload *************************//
            [self.collectionView reloadData];
        default:
            break;
    }
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateLayoutForOrientation:[UIApplication sharedApplication].statusBarOrientation];
    [self loadExtView];
//    if (objectsArray.filterSelected == 0) {
//        [user gotoMapViewViewController:self];
//    }
}

//******************** NEW Load store objects *************************//
//******************** NEW Load store objects *************************//
//******************** NEW Load store objects *************************//
//******************** NEW Load store objects *************************//
- (void) newLoadStores {
    objectsArray.strainOrStore = 1;
    _storeKeys = [[NSArray alloc] init];
    _imagesArray = [[NSMutableArray alloc] init];
    objectsArray.storeObjectArray = [[NSMutableArray alloc] init];


    [self getStoreKeys];
}

- (void) getStoreKeys{
    //******************** Firebase get all store keys *************************//
    [[firebaseRef.ref child:@"storeKeys"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            _storeKeys = [snapshot.value allKeys];
            [self getStoreInformation];
        }
    }];
}

- (void) getStoreInformation{
    /* need to change from count to 20 items per page*/
    for (int i = 0; i < _storeKeys.count; i++){

        storeClass *myStore = [[storeClass alloc] init];
        [objectsArray.storeObjectArray addObject:myStore];

        myStore = [objectsArray.storeObjectArray objectAtIndex:i];
        myStore.storeKey = [_storeKeys objectAtIndex:i];
        [objectsArray.storeObjectArray replaceObjectAtIndex:i withObject:myStore];

        [self sortStoresByDistances];
        [self getStoreLocations: i];
        [self getImagesForNearestTwentyStores: i];
        [self getDownVotes:i];
        [self getUpVotes:i];
        [self sortStoreImagesByVotes: i];
        [self getStoreName: i];
        [self getStoreURL: i];
        [self getPhoneNumber: i];
        [self getGooglePlaceID: i];
        [self getRatingScore: i];
        [self getTotalCount: i];
        [self getMontlyCount: i];
        [self getDailyCount: i];
    }
}

- (void) getStoreLocations:(NSInteger) i{
    storeClass *myStore = [[storeClass alloc] init];
    myStore = [objectsArray.storeObjectArray objectAtIndex:i];

    [[[firebaseRef.ref child:@"location"] child:myStore.storeKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null

        myStore.latitude = [snapshot.value valueForKey:@"latitude"];
        myStore.longitude = [snapshot.value valueForKey:@"longitude"];
        myStore.address = [snapshot.value valueForKey:@"address"];
        myStore.city = [snapshot.value valueForKey:@"city"];
        myStore.county = [snapshot.value valueForKey:@"county"];
        myStore.state = [snapshot.value valueForKey:@"state"];
        myStore.zipcode = [snapshot.value valueForKey:@"zipcode"];
        
        NSLog(@"object location is %@,%@", myStore.latitude, myStore.longitude);
        
        [objectsArray.storeObjectArray replaceObjectAtIndex:i withObject:myStore];
            [self currentDistanceToStores: i];
        }
    }];
}

-(void) currentDistanceToStores:(NSInteger) i{
    storeClass *myStore = [[storeClass alloc] init];
    myStore = [objectsArray.storeObjectArray objectAtIndex:i];
    

    NSString *geocodingBaseURL = @"https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=";
    NSString *url = [NSString stringWithFormat:@"%@%f,%f&destinations=%@,%@&key=AIzaSyAsZ171sgZHuTcapToLRQ5-W9dl_WRLOh4", geocodingBaseURL, user.latitude,user.longitude,myStore.latitude,myStore.longitude];

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
                myStore.distanceToMe = description;
                myStore.distanceValue = value;
                
                [objectsArray.storeObjectArray replaceObjectAtIndex:i withObject:myStore];
            }
        }
    }
}

- (void) sortStoresByDistances{
    [objectsArray.storeObjectArray sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"distanceValue" ascending:YES selector:@selector(compare:)]]];
}

- (void) getImagesForNearestTwentyStores:(NSInteger) i {
    storeClass *myStore = [[storeClass alloc] init];
    myStore = [objectsArray.storeObjectArray objectAtIndex:i];
    

        [[[[firebaseRef.ref child:@"images"] child:@"stores"] child:myStore.storeKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            NSArray *imageKeys = [[NSArray alloc] init];
            if ([NSNull null] != snapshot.value){                                   //check snapshot is null
                NSLog(@"snapshot is %@", snapshot.value);

                imageKeys = [snapshot.value allKeys];
                
                for(id key in imageKeys){
                    _image = [[imageClass alloc] init];
                    _image.imageKey = key;
                    _image.imageURL = [snapshot.value valueForKey:_image.imageKey];
                    [myStore.imagesArray addObject:_image];
                }
                
                NSLog(@"object image count is %lu", (unsigned long)[myStore.imagesArray count]);

                [objectsArray.storeObjectArray replaceObjectAtIndex:i withObject:myStore];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.collectionView reloadData];
                });

//                [self loadImageCells: i];
            }
        }];
}

- (void) getDownVotes:(NSInteger) i {
    storeClass *myStore = [[storeClass alloc] init];
    myStore = [objectsArray.storeObjectArray objectAtIndex:i];

        for (int j = 0; j < myStore.imagesArray.count; j++){
            _image = [[imageClass alloc] init];
            _image = [myStore.imagesArray objectAtIndex:j];

            [[[firebaseRef.ref child:@"thumbsDown"] child:_image.imageKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
                if ([NSNull null] != snapshot.value){                                   //check snapshot is null

//                _image.imageThumbsDown = [NSMutableArray arrayWithArray:[snapshot.value allKeys]];
                
                [myStore.imagesArray addObject:_image];
                [objectsArray.storeObjectArray replaceObjectAtIndex:i withObject:myStore];
                }
            }];
        }
}

- (void) getUpVotes:(NSInteger) i {
    storeClass *myStore = [[storeClass alloc] init];
    myStore = [objectsArray.storeObjectArray objectAtIndex:i];

        for (int j = 0; j < myStore.imagesArray.count; j++){
            _image = [[imageClass alloc] init];
            _image = [myStore.imagesArray objectAtIndex:j];

            [[[firebaseRef.ref child:@"thumbsUp"] child:_image.imageKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
                if ([NSNull null] != snapshot.value){                                   //check snapshot is null

//                _image.imageThumbsUp = [NSMutableArray arrayWithArray:[snapshot.value allKeys]];
                _image.voteScore = _image.imageThumbsUp.count - _image.imageThumbsDown.count;
                
                [myStore.imagesArray addObject:_image];
                [objectsArray.storeObjectArray replaceObjectAtIndex:i withObject:myStore];
                }
            }];
    }
}

- (void) sortStoreImagesByVotes:(NSInteger) i{
    storeClass *myStore = [[storeClass alloc] init];
    myStore = [objectsArray.storeObjectArray objectAtIndex:i];

    [myStore.imagesArray sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"voteScore" ascending:NO selector:@selector(compare:)]]];
}

- (void) getStoreName:(NSInteger) i {
    storeClass *myStore = [[storeClass alloc] init];
    myStore = [objectsArray.storeObjectArray objectAtIndex:i];
    
        [[[firebaseRef.ref child:@"storeNames"] child:myStore.storeKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            if ([NSNull null] != snapshot.value){                                   //check snapshot is null

            myStore.storeName = [snapshot.value valueForKey:@"name"];
            
//            NSLog(@"object name is %@", myStore.storeName);

            [objectsArray.storeObjectArray replaceObjectAtIndex:i withObject:myStore];
            }
        }];
}
- (void) getStoreURL:(NSInteger) i {
    storeClass *myStore = [[storeClass alloc] init];
    myStore = [objectsArray.storeObjectArray objectAtIndex:i];

        [[[firebaseRef.ref child:@"storeURL"] child:myStore.storeKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            if ([NSNull null] != snapshot.value){                                   //check snapshot is null

            myStore.url = [snapshot.value valueForKey:@"url"];
            
            NSLog(@"object url is %@", myStore.url);

            [objectsArray.storeObjectArray replaceObjectAtIndex:i withObject:myStore];
            }
        }];
}

- (void) getPhoneNumber:(NSInteger) i {
    storeClass *myStore = [[storeClass alloc] init];
    myStore = [objectsArray.storeObjectArray objectAtIndex:i];

        [[[firebaseRef.ref child:@"phoneNumbers"] child:myStore.storeKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            if ([NSNull null] != snapshot.value){                                   //check snapshot is null

            myStore.phone_number = [snapshot.value valueForKey:@"phoneNumber"];

            NSLog(@"object phone number is %@", myStore.phone_number);

            [objectsArray.storeObjectArray replaceObjectAtIndex:i withObject:myStore];
            }
        }];
}

- (void) getGooglePlaceID:(NSInteger) i {
    storeClass *myStore = [[storeClass alloc] init];
    myStore = [objectsArray.storeObjectArray objectAtIndex:i];
    
        [[[firebaseRef.ref child:@"googlePlaceID"] child:myStore.storeKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            if ([NSNull null] != snapshot.value){                                   //check snapshot is null

            myStore.googlePlaceID = [snapshot.value valueForKey:@"googlePlaceID"];

            NSLog(@"object google place ID is %@", myStore.googlePlaceID);
            
            [objectsArray.storeObjectArray replaceObjectAtIndex:i withObject:myStore];
            }
        }];
}

- (void) getRatingScore:(NSInteger) i {
    storeClass *myStore = [[storeClass alloc] init];
    myStore = [objectsArray.storeObjectArray objectAtIndex:i];
    
        [[[[firebaseRef.ref child:@"starRating"] child:@"stores"] child:myStore.storeKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            if ([NSNull null] != snapshot.value){                                   //check snapshot is null
                myStore.ratingCount = [snapshot.value allKeys].count;
                NSArray *scores = [[NSArray alloc] init];
                scores = [snapshot.value allValues];
                
                for (int j = 0; j< scores.count; j++){
                    myStore.ratingScore = myStore.ratingScore + [[scores objectAtIndex:j] floatValue];
                }
                
                NSLog(@"object rating score is %f", myStore.ratingScore);

                [objectsArray.storeObjectArray replaceObjectAtIndex:i withObject:myStore];
            }
        }];
}

- (void) getTotalCount:(NSInteger) i {
    storeClass *myStore = [[storeClass alloc] init];
    myStore = [objectsArray.storeObjectArray objectAtIndex:i];

        [[[[firebaseRef.ref child:@"metrics"] child:@"stores"] child:myStore.storeKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            if ([NSNull null] != snapshot.value){                                   //check snapshot is null

                myStore.totalViews = [[snapshot.value valueForKey:@"totalViews"] integerValue];
                
                NSLog(@"object total views is %ld", (long)myStore.totalViews);

                [objectsArray.storeObjectArray replaceObjectAtIndex:i withObject:myStore];
            }
        }];
}
- (void) getMontlyCount:(NSInteger) i {
    storeClass *myStore = [[storeClass alloc] init];
    myStore = [objectsArray.storeObjectArray objectAtIndex:i];

        [[[[[firebaseRef.ref child:@"metrics"] child:@"stores"] child:myStore.storeKey] child:@"monthlyViews"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            if ([NSNull null] != snapshot.value){                                   //check snapshot is null

            myStore.monthlyViews = [[snapshot.value valueForKey:@"February 2017"]integerValue];
            
            NSLog(@"object montly views is %ld", (long)myStore.monthlyViews);

            [objectsArray.storeObjectArray replaceObjectAtIndex:i withObject:myStore];
            }
        }];
}
- (void) getDailyCount:(NSInteger) i {
    storeClass *myStore = [[storeClass alloc] init];
    myStore = [objectsArray.storeObjectArray objectAtIndex:i];

        [[[[[firebaseRef.ref child:@"metrics"] child:@"stores"] child:myStore.storeKey] child:@"dailyViews"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            if ([NSNull null] != snapshot.value){                                   //check snapshot is null

            myStore.dailyViews = [[snapshot.value valueForKey:@"01-Jan-2017"]integerValue];
            
            NSLog(@"object daily views is %ld", (long)myStore.dailyViews);

            [objectsArray.storeObjectArray replaceObjectAtIndex:i withObject:myStore];
            }
        }];
}



- (void) loadImageCells:(NSInteger) i {
//    dispatch_async(dispatch_get_global_queue(0,0), ^{
//        storeClass *myStore = [[storeClass alloc] init];
//        myStore = [objectsArray.storeObjectArray objectAtIndex:i];
//
//        FIRStorage *storage = [FIRStorage storage];
//        FIRStorageReference *storageRef = [storage reference];
//
//        __block imageClass *tempImage = [[imageClass alloc] init];
//
//        if (myStore.imagesArray.count > 0) {
//            tempImage = [myStore.imagesArray objectAtIndex:0];
//        }
//
//        FIRStorageReference *spaceRef = [storageRef child:tempImage.imageURL];
//
//        [spaceRef dataWithMaxSize:1 * 1024 * 1024 completion:^(NSData *data, NSError *error){
//            if (error != nil) {
//                NSLog(@"Uh-oh, an error occurred! %@", error);
//            }
//            else {
//                tempImage.data = data;
//                [myStore.imagesArray replaceObjectAtIndex:0 withObject:tempImage];
//                
//                [objectsArray.storeObjectArray replaceObjectAtIndex:i withObject:myStore];
//            }
//        }];
//
//        if( tempImage.data == nil ){
//            NSLog(@"image is nil");
//            return;
//        }
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.collectionView reloadData];
//        });
//    });
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
  [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
  [self updateLayoutForOrientation:toInterfaceOrientation];
}

- (void)updateLayoutForOrientation:(UIInterfaceOrientation)orientation {
//  CHTCollectionViewWaterfallLayout *layout = (CHTCollectionViewWaterfallLayout *)self.collectionView.collectionViewLayout;
//  layout.columnCount = UIInterfaceOrientationIsPortrait(orientation) ? 2 : 3;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
        return objectsArray.storeObjectArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  CHTCollectionViewWaterfallCell *cell =
  (CHTCollectionViewWaterfallCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    
    if (objectsArray.strainOrStore == stores){
        if ([objectsArray.storeObjectArray count] > 0) {
                storeClass *tempStore = [[storeClass alloc] init];
                
                tempStore = [objectsArray.storeObjectArray objectAtIndex:indexPath.row];
                
                if ([tempStore.imagesArray count] > 0) {
                    
                    FIRStorage *storage = [FIRStorage storage];
                    FIRStorageReference *storageRef = [storage reference];
                    
                    imageClass *image = [[imageClass alloc] init];
                    image = [tempStore.imagesArray objectAtIndex:0];

                    
                    NSLog(@"store key is %@", tempStore.storeKey);
                    NSLog(@"image link is %@", image.imageURL);
                    FIRStorageReference *spaceRef = [[[storageRef child:@"stores"] child:tempStore.storeKey] child:image.imageURL];
                    NSLog(@"ref is %@", spaceRef);
                    
                    UIImage *placeHolder = [[UIImage alloc] init];
                    [cell.imageView sd_setImageWithStorageReference:spaceRef placeholderImage:placeHolder];
                    
                    
//                    cell.imageView.image = [UIImage imageWithData:image.data];
                }
                
                cell.imageView.backgroundColor = [UIColor colorWithRed:18.0/255.0 green:24.0/255.0 blue:23.0/255.0 alpha:1.0];
                //                [cell.imageView.layer.mask addSublayer:gradientMask];
                cell.label.text = tempStore.storeName;
                NSString *cityState = [NSString stringWithFormat:@"%@, %@", tempStore.city, tempStore.state];
                cell.locationLabel.text = cityState;
                NSString *reviewCount = [NSString stringWithFormat:@"%lu Reviews", (unsigned long)tempStore.reviews.count];
                cell.reviewCountLabel.text = reviewCount;
                cell.steviaImageView.image = [UIImage imageNamed:@"DistanceSmartObject"];
                cell.steviaImageView.contentMode = UIViewContentModeScaleAspectFit;
                if(tempStore.distanceToMe != nil){
                    cell.distanceToMeLabel.text = tempStore.distanceToMe;
                }
                
                CAGradientLayer *gradientMask2 = [CAGradientLayer layer];
                gradientMask2.frame = cell.bounds;
                gradientMask2.colors = @[(id)[UIColor clearColor].CGColor,
                                         (id)[UIColor clearColor].CGColor,
                                         (id)[UIColor colorWithRed:208.0/255.0 green:210.0/255.0 blue:210.0/255.0 alpha:1.0].CGColor,
                                         (id)[UIColor whiteColor].CGColor];
                gradientMask2.locations = @[@0.0, @0.95, @0.95, @0.97];
                [cell.layer addSublayer:gradientMask2];
            
        }
    }
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (objectsArray.strainOrStore == stores){
        store = [objectsArray.storeObjectArray objectAtIndex:indexPath.row];
        objectsArray.filterSelected = 10;
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        StoreProfileViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Store Profile VC SB ID"];
        vc.passedString = store.storeName;
        [self.navigationController pushViewController:vc animated:false];

//        [user goToStoreProfileViewController:self];
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
  UICollectionReusableView *reusableView = nil;

  if ([kind isEqualToString:CHTCollectionElementKindSectionHeader]) {
    reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                      withReuseIdentifier:HEADER_IDENTIFIER
                                                             forIndexPath:indexPath];
  } else if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
    reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                      withReuseIdentifier:FOOTER_IDENTIFIER
                                                             forIndexPath:indexPath];
  }

  return reusableView;
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return [self.cellSizes[indexPath.item % 4] CGSizeValue];
}


                        //******************** Search Button Configurations *************************//
                        //- (void)searchButtonTapped:(id)sender {
                        //
                        //    [UIView animateWithDuration:0.5 animations:^{
                        //        _rightButton.alpha = 0.0f;
                        //
                        //    } completion:^(BOOL finished) {
                        //
                        //        self.navigationController.navigationBar.topItem.rightBarButtonItems = nil;
                        //        self.navigationController.navigationBar.topItem.titleView = _searchBar;
                        //        _searchBar.alpha = 0.0;
                        //
                        //        [UIView animateWithDuration:0.5
                        //                         animations:^{
                        //                             _searchBar.alpha = 1.0;
                        //                         } completion:^(BOOL finished) {
                        //                             [_searchBar becomeFirstResponder];
                        //                         }];
                        //
                        //    }];
                        //}

                        //- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
                        //    [UIView animateWithDuration:0.5f animations:^{
                        //        _searchBar.alpha = 0.0;
                        //    } completion:^(BOOL finished) {
                        //        self.navigationController.navigationBar.topItem.titleView = nil;
                        //        [UIView animateWithDuration:0.5f animations:^ {
                        //            _rightButton.alpha = 1.0;
                        //        }];
                        //
                        //
                        //        UIBarButtonItem *leftButton1 = [[UIBarButtonItem alloc] initWithTitle:@"Stores" style:UIBarButtonItemStylePlain target:self action:nil];
                        //        UIBarButtonItem *rightButton1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings"] style:UIBarButtonItemStylePlain target:self   action:@selector(barButtonMenuPressed:)];
                        //        rightButton1.width = 40.f;
                        //        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mapview"] style:UIBarButtonItemStylePlain target:self   action:@selector(barButtonCustomPressed:)];
                        //        rightButton.width = 40.f;
                        //
                        //
                        //        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
                        //        self.navigationController.navigationBar.topItem.leftBarButtonItem = leftButton1;
                        //        self.navigationController.navigationBar.topItem.rightBarButtonItem = rightButton1;
                        //        self.navigationController.navigationBar.topItem.rightBarButtonItems = [NSArray arrayWithObjects:rightButton1, rightButton, nil];
                        //
                        //
                        //        if (objectsArray.strainOrStore == strains){
                        //            _filteredObjectsArray.strainObjectArray = [[NSMutableArray alloc] init];
                        //
                        //            for (int i = 0; i <objectsArray.strainObjectArray.count; i++)
                        //                [_filteredObjectsArray.strainObjectArray addObject:[objectsArray.strainObjectArray objectAtIndex:i]];
                        //
                        //            [_filteredObjectsArray.strainObjectArray sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"strainName" ascending:YES selector:@selector(caseInsensitiveCompare:)]]];
                        //            [self.collectionView reloadData];}
                        //
                        //        else if (objectsArray.strainOrStore == stores){
                        //            _filteredObjectsArray.storeObjectArray = [[NSMutableArray alloc] init];
                        //
                        //            for (int i = 0; i <objectsArray.storeObjectArray.count; i++)
                        //                [_filteredObjectsArray.storeObjectArray addObject:[objectsArray.storeObjectArray objectAtIndex:i]];
                        //
                        //            [_filteredObjectsArray.storeObjectArray sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"storeName" ascending:YES selector:@selector(caseInsensitiveCompare:)]]];
                        //            [self.collectionView reloadData];}
                        //    }];
                        //}
                        //******************** Search Button Configurations *************************//


                        //******************** Refresh pull down configurations *************************//
                        //- (void)refreshTableau:(UIRefreshControl *)refresh {
                        //    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing data..."];
                        //    objectsArray.filterSelected = 0;
                        //
                        //    if (objectsArray.strainOrStore == 0){
                        //            [self loadstrains];
                        //    }
                        //    else{
                        //            [self loadStores];
                        //    }
                        //    [refresh endRefreshing];
                        //}
                        //******************** Refresh pull down configurations *************************//


                        //******************** Search bar configurations *************************//
                        //-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
                        //    if(searchBar.text.length == 0){
                        //        if (objectsArray.strainOrStore == 0){
                        //            _filteredObjectsArray.strainObjectArray = [[NSMutableArray alloc] init];
                        //
                        //            for (int i = 0; i <objectsArray.strainObjectArray.count; i++)
                        //                [_filteredObjectsArray.strainObjectArray addObject:[objectsArray.strainObjectArray objectAtIndex:i]];
                        //
                        //            [_filteredObjectsArray.strainObjectArray sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"strainName" ascending:YES selector:@selector(caseInsensitiveCompare:)]]];
                        //            [self.collectionView reloadData];}
                        //
                        //        else if (objectsArray.strainOrStore == 1){
                        //            _filteredObjectsArray.storeObjectArray = [[NSMutableArray alloc] init];
                        //
                        //            for (int i = 0; i <objectsArray.storeObjectArray.count; i++)
                        //                [_filteredObjectsArray.storeObjectArray addObject:[objectsArray.storeObjectArray objectAtIndex:i]];
                        //
                        //            [_filteredObjectsArray.storeObjectArray sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"storeName" ascending:YES selector:@selector(caseInsensitiveCompare:)]]];
                        //            [self.collectionView reloadData];}
                        //    }
                        //    else
                        //        [self searchForSearchBarText];
                        //}
                        //
                        //-(void) searchForSearchBarText{
                        //    if (objectsArray.strainOrStore == 0){
                        //        _filteredObjectsArray.strainObjectArray = [[NSMutableArray alloc] init];
                        //
                        //        for (int i = 0; i < objectsArray.strainObjectArray.count; i++) {
                        //            strainClass *tempStrain = [objectsArray.strainObjectArray objectAtIndex:i];
                        //            if ([tempStrain.strainName.lowercaseString hasPrefix:_searchBar.text.lowercaseString]) {
                        //                NSLog(@"strain found %@", tempStrain.strainName);
                        //                [_filteredObjectsArray.strainObjectArray addObject:tempStrain];
                        //            }
                        //        }
                        //
                        //        [self.collectionView reloadData];}
                        //
                        //    else if (objectsArray.strainOrStore == 1){
                        //        _filteredObjectsArray.storeObjectArray = [[NSMutableArray alloc] init];
                        //
                        //        for (int i = 0; i < objectsArray.storeObjectArray.count; i++) {
                        //             storeClass *tempStore = [objectsArray.storeObjectArray objectAtIndex:i];
                        //             if ([tempStore.storeName.lowercaseString hasPrefix:_searchBar.text.lowercaseString]) {
                        //                 NSLog(@"store found %@", tempStore.storeName);
                        //                 [_filteredObjectsArray.storeObjectArray addObject:tempStore];
                        //             }
                        //        }
                        //
                        //        [self.collectionView reloadData];}
                        //}
                        //******************** Search bar configurations *************************//


@end



