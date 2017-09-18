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
        [self getStoreName: i];
        [self getRatingScore: i];
        [self loadReviewsFromFirebase: i];
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

                [myStore.imagesArray sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"voteScore" ascending:NO selector:@selector(compare:)]]];

                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.collectionView reloadData];
                });
            }
        }];
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

-(void)loadReviewsFromFirebase:(NSInteger) i{
    storeClass *myStore = [[storeClass alloc] init];
    myStore = [objectsArray.storeObjectArray objectAtIndex:i];

    FIRDatabaseQuery *reviewQuery = [[firebaseRef.reviewsRef queryOrderedByChild:@"objectKey"] queryEqualToValue:myStore.storeKey];
    
    [reviewQuery observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
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
                
                [myStore.reviews addObject:tempReview];
            }
        }
    }];
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
    
    cell.imageView.contentMode = UIViewContentModeScaleToFill;
    CAGradientLayer *gradientMask = [CAGradientLayer layer];
    gradientMask.frame = cell.imageView.frame;
    gradientMask.colors = @[(id)[UIColor clearColor].CGColor, (id)[UIColor colorWithRed:1.0/255.0 green:1.0/255.0 blue:1.0/255.0 alpha:1.0].CGColor];
    gradientMask.startPoint = CGPointMake(0.75, 0.5);   // start at left middle
    gradientMask.endPoint = CGPointMake(1.0, 0.5);     // end at right middle

    [cell.imageView.layer addSublayer:gradientMask];

    
    if (objectsArray.strainOrStore == stores){
        if ([objectsArray.storeObjectArray count] > 0) {
                storeClass *tempStore = [[storeClass alloc] init];
                tempStore = [objectsArray.storeObjectArray objectAtIndex:indexPath.row];
                
                if ([tempStore.imagesArray count] > 0) {
                    FIRStorage *storage = [FIRStorage storage];
                    FIRStorageReference *storageRef = [storage reference];
                    
                    imageClass *image = [[imageClass alloc] init];
                    image = [tempStore.imagesArray objectAtIndex:0];
                    FIRStorageReference *spaceRef = [[[storageRef child:@"stores"] child:tempStore.storeKey] child:image.imageURL];
                    
                    UIImage *placeHolder = [[UIImage alloc] init];
                    [cell.imageView sd_setImageWithStorageReference:spaceRef placeholderImage:placeHolder];
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
                cell.distanceToMeLabel.text = tempStore.distanceToMe;
            
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

@end



