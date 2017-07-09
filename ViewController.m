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
    
    NSLog(@"latitude is %f", coordinate.latitude);
    
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
                NSLog(@"user county is %@",user.county);
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
    [user goToStrainsStoresViewController:self];
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

            //******************** Load objects *************************//
            [self loadstrains];
            [self loadStores];
            
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
                [self loadDistancesFromUserToStores];
                
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
    if (objectsArray.filterSelected == 0) {
        [user gotoMapViewViewController:self];
    }
}



//******************** Load strain objects *************************//
-(void) loadstrains{
    
    //******************** Initialize *************************//
    objectsArray.strainObjectArray = [[NSMutableArray alloc] init];
    _filteredObjectsArray = [[objectsArrayClass alloc] init];
    
    
    //******************** Firebase get all strain keys *************************//
    [firebaseRef.strainsRef observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        _strainObjectDictionary = snapshot.value; //Creates a dictionary of of the JSON node strains
        NSArray *keys = [_strainObjectDictionary allKeys]; //Creates an array with only the strain key uID
        
        for(int i=0; i<keys.count ; i++){
            NSString *key = keys[i];
            NSDictionary *strainDict = [_strainObjectDictionary valueForKey:key];
            NSDictionary *highDict = [strainDict valueForKey:@"highType"];
            NSMutableArray *imagesArray = [[NSMutableArray alloc] init];
            
            //******************** Create image array for all images to one strain *************************//
            for (NSInteger j = 0; j < [[strainDict valueForKey:@"images"] count]; j++) {
                imageClass *image = [[imageClass alloc] init];
                image.imageURL = [[[strainDict valueForKey:@"images"] objectAtIndex:j] valueForKey:@"imageURL"];
                
                image.imageThumbsUp = [NSMutableArray arrayWithArray:[[[[strainDict valueForKey:@"images"] objectAtIndex:j] valueForKey:@"thumbsUp"] allKeys]];
                image.imageThumbsDown = [NSMutableArray arrayWithArray:[[[[strainDict valueForKey:@"images"] objectAtIndex:j] valueForKey:@"thumbsDown"] allKeys]];
                
                image.voteScore = image.imageThumbsUp.count - image.imageThumbsDown.count;
                image.firebaseIndex = j;
            
                [imagesArray addObject:image];
            }
            
            //******************** Sort images based on votes *************************//
            [imagesArray sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"voteScore" ascending:NO selector:@selector(compare:)]]];


            
            NSArray *availableAtArray = [[strainDict valueForKey:@"availableAt"] allKeys];
            
            NSArray *ratingsArray = [[strainDict valueForKey:@"ratingCount"] allValues];
            float ratingScore = 0.0;
            for (int i =0; i < ratingsArray.count; i++) {
                ratingScore += [[ratingsArray objectAtIndex:i] floatValue];
            }
            ratingScore = ratingScore / (float)ratingsArray.count;

            
            //********* you have to delcare a new object instance to load table cells!!!!!!!!!!!!!!!! ***********//
            strainClass *strainLoop = [[strainClass alloc] init];
            [strainLoop setStrainObject:key
                         fromDictionary:strainDict
                               highType:highDict
                                 images:imagesArray
                            availableAt:availableAtArray
                            ratingCount:ratingsArray.count
                            ratingScore:ratingScore];
            
            dispatch_async(dispatch_get_global_queue(0,0), ^{
                imageClass *tempImage = [[imageClass alloc] init];
                tempImage = [strainLoop.imagesArray objectAtIndex:0];

                NSInteger length = [tempImage.imageURL length];
                NSString *smallImageURL = [tempImage.imageURL substringWithRange:NSMakeRange(0, length-4)];
                smallImageURL = [smallImageURL stringByAppendingString:@"m.jpg"];

                tempImage.data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:smallImageURL]];
                if( tempImage.data == nil ){
                    NSLog(@"image is nil");
                    return;
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.collectionView reloadData];
                });
            });
            
            [objectsArray.strainObjectArray addObject:strainLoop];
            [_filteredObjectsArray.strainObjectArray addObject:strainLoop];
        }
    }];
}



//******************** Get distance from user to stores *************************//
-(void) loadDistancesFromUserToStores{
    NSLog(@"2 count is %lu", objectsArray.storeObjectArray.count);
    for (int i = 0; i < objectsArray.storeObjectArray.count; i++) {
        storeClass *storeloop = [objectsArray.storeObjectArray objectAtIndex:i];
    
        NSString *geocodingBaseURL = @"https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=";
        NSString *url = [NSString stringWithFormat:@"%@%f,%f&destinations=%@,%@&key=AIzaSyAsZ171sgZHuTcapToLRQ5-W9dl_WRLOh4", geocodingBaseURL, user.latitude,user.longitude,storeloop.latitude,storeloop.longitude];
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
                    storeloop.distanceToMe = description;
                    storeloop.distanceValue = value;
                }
            }
        }
    }

    _filteredObjectsArray = [[objectsArrayClass alloc] init];
    for (int i = 0; i <objectsArray.storeObjectArray.count; i++) {
        [_filteredObjectsArray.storeObjectArray addObject:[objectsArray.storeObjectArray objectAtIndex:i]];
    }
    
}


//******************** Load store objects *************************//
- (void) loadStores {
    
    //******************** Initialize *************************//
    objectsArray.storeObjectArray = [[NSMutableArray alloc] init];
    _filteredObjectsArray = [[objectsArrayClass alloc] init];

    
    //******************** Firebase get all store keys *************************//
    [firebaseRef.storesRef observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        _storeObjectDictionary = snapshot.value;
        NSArray *keys = [_storeObjectDictionary allKeys];
        
        for(int i=0; i<keys.count ; i++){
            NSString *key = keys[i];
            NSDictionary *storeDict = [_storeObjectDictionary valueForKey:key];
            NSMutableArray *imagesArray = [[NSMutableArray alloc] init];
            
            //******************** Create image array for all images to one strain *************************//
            for (NSInteger j = 0; j < [[storeDict valueForKey:@"images"] count]; j++) {
                imageClass *image = [[imageClass alloc] init];
                image.imageURL = [[[storeDict valueForKey:@"images"] objectAtIndex:j] valueForKey:@"imageURL"];
                
                image.imageThumbsUp = [NSMutableArray arrayWithArray:[[[[storeDict valueForKey:@"images"] objectAtIndex:j] valueForKey:@"thumbsUp"] allKeys]];
                image.imageThumbsDown = [NSMutableArray arrayWithArray:[[[[storeDict valueForKey:@"images"] objectAtIndex:j] valueForKey:@"thumbsDown"] allKeys]];
                
                image.voteScore = image.imageThumbsUp.count - image.imageThumbsDown.count;
                image.firebaseIndex = j;
                
                [imagesArray addObject:image];
            }
            
            //******************** Sort images by votes *************************//
            [imagesArray sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"voteScore" ascending:NO selector:@selector(compare:)]]];
            
            //********* you have to delcare a new object instance to load table cells!!!!!!!!!!!!!!!! ***********//
            storeClass *storeloop = [[storeClass alloc] init];
            [storeloop setStoreObject:key
                       fromDictionary:storeDict
                               images:imagesArray];
            
            dispatch_async(dispatch_get_global_queue(0,0), ^{
                imageClass *tempImage = [[imageClass alloc] init];
                tempImage = [storeloop.imagesArray objectAtIndex:0];

                //******************** Get medium image URL*************************//
                NSInteger length = [tempImage.imageURL length];
                NSString *smallImageURL = [tempImage.imageURL substringWithRange:NSMakeRange(0, length-4)];
                smallImageURL = [smallImageURL stringByAppendingString:@"m.jpg"];
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:smallImageURL]]];
                tempImage.data = UIImagePNGRepresentation(image);

                
                if( tempImage.data == nil ){
                    NSLog(@"image is nil");
                    return;
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.collectionView reloadData];
                });
            });
            [objectsArray.storeObjectArray addObject:storeloop];
            [_filteredObjectsArray.storeObjectArray addObject:storeloop];
        }
        [_locationManager stopUpdatingLocation];
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
    if (objectsArray.strainOrStore == 1)
        return [_filteredObjectsArray.storeObjectArray count];
    else
        return [_filteredObjectsArray.strainObjectArray count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  CHTCollectionViewWaterfallCell *cell =
  (CHTCollectionViewWaterfallCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    
    if (objectsArray.strainOrStore == stores){
        if ([_filteredObjectsArray.storeObjectArray count] > 0) {
            for(int i=0; i<[_filteredObjectsArray.storeObjectArray count]; i++){
//                CAGradientLayer *gradientMask = [CAGradientLayer layer];
//                gradientMask.frame = cell.imageView.bounds;
//                gradientMask.colors = @[(id)[UIColor clearColor].CGColor,
//                                        (id)[UIColor colorWithRed:18.0/255.0 green:24.0/255.0 blue:23.0/255.0 alpha:1.0].CGColor];
//                gradientMask.startPoint = CGPointMake(0.0, 0.5);   // start at left middle
//                gradientMask.endPoint = CGPointMake(1.0, 0.5);     // end at right middle

                
                
                
                storeClass *tempStore = [[storeClass alloc] init];
                tempStore = [_filteredObjectsArray.storeObjectArray objectAtIndex:indexPath.row];
                
                imageClass *image = [[imageClass alloc] init];
                image = [tempStore.imagesArray objectAtIndex:0];

                cell.imageView.image = [UIImage imageWithData:image.data];
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
    }
    else if (objectsArray.strainOrStore == strains){
        if ([_filteredObjectsArray.strainObjectArray count] > 0) {
            for(int i=0; i<[_filteredObjectsArray.strainObjectArray count]; i++){
                strainClass *tempStrain = [[strainClass alloc] init];
                tempStrain = [_filteredObjectsArray.strainObjectArray objectAtIndex:indexPath.row];
                
                imageClass *image = [[imageClass alloc] init];
                image = [tempStrain.imagesArray objectAtIndex:0];

                cell.imageView.image = [UIImage imageWithData:image.data];
                cell.label.text = tempStrain.strainName;
                
                if ([tempStrain.species isEqual:@"stevia"]) {
                    cell.steviaImageView.image = [UIImage imageNamed:@"stevia"];
                }
                else if ([tempStrain.species isEqual:@"indica"]){
                    cell.indicaImageView.image = [UIImage imageNamed:@"indica"];
                }
            }
        }
    }
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (objectsArray.strainOrStore == stores){
        store = [_filteredObjectsArray.storeObjectArray objectAtIndex:indexPath.row];
        objectsArray.filterSelected = 10;
        [user goToStoreProfileViewController:self];
    }
    else if (objectsArray.strainOrStore == strains){
        strain = [_filteredObjectsArray.strainObjectArray objectAtIndex:indexPath.row];
        objectsArray.filterSelected = 10;
        [user goToStrainProfileViewController:self];
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



