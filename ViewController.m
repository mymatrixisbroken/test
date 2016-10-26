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
    layout.headerHeight = 0;
    layout.footerHeight = 0;
    layout.minimumColumnSpacing = 1;
    layout.minimumInteritemSpacing = 1;
      
      
//    CGRect frame = CGRectMake(0, 63, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) -64);
//    _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    
      
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor blackColor];
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
      [NSValue valueWithCGSize:CGSizeMake(1024, 1024)],
      [NSValue valueWithCGSize:CGSizeMake(1024, 1024)],
      [NSValue valueWithCGSize:CGSizeMake(1024, 1024)],
      [NSValue valueWithCGSize:CGSizeMake(1024, 1024)]
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

    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    _searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    _searchBar.showsCancelButton = YES;
    _searchBar.delegate = self;
    _searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    if (objectsArray.searchType == search) {
        [UIView animateWithDuration:0.5 animations:^{
            //        _rightButton.alpha = 0.0f;
            
        } completion:^(BOOL finished) {
            
            self.navigationController.navigationBar.topItem.rightBarButtonItems = nil;
            self.navigationController.navigationBar.topItem.titleView = _searchBar;
            _searchBar.alpha = 0.0;
            
            [UIView animateWithDuration:0.5
                             animations:^{
                                 _searchBar.alpha = 1.0;
                             } completion:^(BOOL finished) {
                                 [_searchBar becomeFirstResponder];
                             }];
        }];
    }
    
    [self loadStoreStrain];

    self.shyNavBarManager.scrollView = self.collectionView;
    [self.view addSubview:self.collectionView];
    [self loadExtView];
    
    if (_refresh == nil) {
        _refresh = [[UIRefreshControl alloc] init];
    }
    
    _refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [self.collectionView addSubview:_refresh];
    [_refresh addTarget:self action:@selector(refreshTableau:) forControlEvents:UIControlEventValueChanged];
    
    
    
    
    
    UIBarButtonItem *rightButton1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings"] style:UIBarButtonItemStylePlain target:self   action:@selector(barButtonMenuPressed:)];
    self.navigationController.navigationBar.topItem.rightBarButtonItem = rightButton1;

    if ((NSInteger)[store.indexPath row] > 0) {
        NSIndexPath *ipath = [NSIndexPath indexPathForRow:8 inSection:0];
//        [store.indexPath setValue:(int)[store.indexPath row]  forKey:@"path"];
        [self.collectionView scrollToItemAtIndexPath:ipath atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
    }
}



-(IBAction) barButtonMenuPressed:(UIBarButtonItem*)btn
{
    NSArray *menuItems = @[
                           [KxMenuItem menuItem:@"Wish List"
                                          image:[UIImage imageNamed:@"search"]
                                         target:self
                                         action:@selector(tappedWishListButton:)],
                           [KxMenuItem menuItem:@"A to Z"
                                          image:[UIImage imageNamed:@"search"]
                                         target:self
                                         action:@selector(tappedAtoZButton:)],
                           [KxMenuItem menuItem:@"Have Smoked"
                                          image:[UIImage imageNamed:@"search"]
                                         target:self
                                         action:@selector(tappedVisitedSmokedButton:)],
                           [KxMenuItem menuItem:@"Search"
                                          image:[UIImage imageNamed:@"search"]
                                         target:self
                                         action:@selector(tappedSearchButton:)],
                           ];
    
    NSArray *menuItems1 = @[
                            [KxMenuItem menuItem:@"Map View"
                                           image:[UIImage imageNamed:@"search"]
                                          target:self
                                          action:@selector(barButtonCustomPressed:)],
                            [KxMenuItem menuItem:@"Near Me"
                                           image:[UIImage imageNamed:@"search"]
                                          target:self
                                          action:@selector(tappednearMeRecommendedButton:)],
                            [KxMenuItem menuItem:@"A to Z"
                                           image:[UIImage imageNamed:@"search"]
                                          target:self
                                          action:@selector(tappedAtoZButton:)],
                            [KxMenuItem menuItem:@"Have Visited"
                                           image:[UIImage imageNamed:@"search"]
                                          target:self
                                          action:@selector(tappedVisitedSmokedButton:)],
                            [KxMenuItem menuItem:@"Search"
                                           image:[UIImage imageNamed:@"search"]
                                          target:self
                                          action:@selector(tappedSearchButton:)],
                            ];

    
    UIView *view = [btn valueForKey:@"view"];
    CGRect rect = view.frame;
    UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;

    
    if (objectsArray.selection == 0) {
        [KxMenu showMenuInView:currentWindow
                      fromRect:rect
                     menuItems:menuItems];
    }
    else if (objectsArray.selection == 1){
        [KxMenu showMenuInView:currentWindow
                      fromRect:rect
                     menuItems:menuItems1];
    }
}

- (IBAction)tappednearMeRecommendedButton:(UIButton *)sender {
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

    objectsArray.searchType = nearMeRecommended;    
    [self viewDidLoad];
    
}


- (IBAction)tappedAtoZButton:(UIButton *)sender {
    objectsArray.searchType = AtoZ;
    [self viewDidLoad];
    
}

- (IBAction)tappedVisitedSmokedButton:(UIButton *)sender {
    objectsArray.searchType = visitedSmoked;
    [self viewDidLoad];
    
}

- (IBAction)tappedWishListButton:(UIButton *)sender {
    objectsArray.searchType = wishList;
    [self viewDidLoad];
}

- (IBAction)tappedSearchButton:(UIButton *)sender {
    objectsArray.searchType = search;
    [self viewDidLoad];
}



-(IBAction) barButtonCustomPressed:(UIBarButtonItem*)btn
{
    [user gotoMapViewViewController:self];
}


- (void) loadExtView{
    extensionViewClass *extView = [[extensionViewClass alloc] init];
    [extView setView:CGRectGetWidth(self.view.bounds)];
    [extView addButtons:CGRectGetWidth(self.view.bounds)];
    [extView.storeButton addTarget:self action:@selector(storeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [extView.strainButton addTarget:self action:@selector(strainButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [extView.newsFeedButton addTarget:self action:@selector(newsFeedButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [extView.userProfileButton addTarget:self action:@selector(userProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    if(objectsArray.selection == 0){
        extView.strainButton.highlighted = YES;
    }
    if(objectsArray.selection == 1){
        extView.storeButton.highlighted = YES;
    }

    [self.view bringSubviewToFront:extView];
    [self.shyNavBarManager setExtensionView:extView];
    [self.shyNavBarManager setStickyExtensionView:NO];
}

-(IBAction)storeButtonPressed:(UIButton*)btn {
    objectsArray.searchType = 0;
    objectsArray.selection = 1;
    [user goToStrainsStoresViewController:self];
}

-(IBAction)strainButtonPressed:(UIButton*)btn {
    objectsArray.searchType = 0;
    objectsArray.selection = 0;
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

- (void)searchButtonTapped:(id)sender {
    
    [UIView animateWithDuration:0.5 animations:^{
//        _rightButton.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        
        self.navigationController.navigationBar.topItem.rightBarButtonItems = nil;
        self.navigationController.navigationBar.topItem.titleView = _searchBar;
        _searchBar.alpha = 0.0;
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             _searchBar.alpha = 1.0;
                         } completion:^(BOOL finished) {
                             [_searchBar becomeFirstResponder];
                         }];
        
    }];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [UIView animateWithDuration:0.5f animations:^{
        _searchBar.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.navigationController.navigationBar.topItem.titleView = nil;
        [UIView animateWithDuration:0.5f animations:^ {
//            _rightButton.alpha = 1.0;
        }];
        

//        UIBarButtonItem *leftButton1 = [[UIBarButtonItem alloc] initWithTitle:@"Stores" style:UIBarButtonItemStylePlain target:self action:nil];
        UIBarButtonItem *rightButton1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings"] style:UIBarButtonItemStylePlain target:self   action:@selector(barButtonMenuPressed:)];
        rightButton1.width = 40.f;
//        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mapview"] style:UIBarButtonItemStylePlain target:self   action:@selector(barButtonCustomPressed:)];
//        rightButton.width = 40.f;


        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
//        self.navigationController.navigationBar.topItem.leftBarButtonItem = leftButton1;
        self.navigationController.navigationBar.topItem.rightBarButtonItem = rightButton1;
//        self.navigationController.navigationBar.topItem.rightBarButtonItems = [NSArray arrayWithObjects:rightButton1, rightButton, nil];

        
        if (objectsArray.selection == 0){
            _objectsArrayCopy.strainObjectArray = [[NSMutableArray alloc] init];
            
            for (int i = 0; i <objectsArray.strainObjectArray.count; i++)
                [_objectsArrayCopy.strainObjectArray addObject:[objectsArray.strainObjectArray objectAtIndex:i]];
            
            [_objectsArrayCopy.strainObjectArray sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"strainName" ascending:YES selector:@selector(caseInsensitiveCompare:)]]];
            [self.collectionView reloadData];}
        
        else if (objectsArray.selection == 1){
            _objectsArrayCopy.storeObjectArray = [[NSMutableArray alloc] init];
            
            for (int i = 0; i <objectsArray.storeObjectArray.count; i++)
                [_objectsArrayCopy.storeObjectArray addObject:[objectsArray.storeObjectArray objectAtIndex:i]];
            
            [_objectsArrayCopy.storeObjectArray sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"storeName" ascending:YES selector:@selector(caseInsensitiveCompare:)]]];
            [self.collectionView reloadData];}
    }];
}

- (void) loadStoreStrain{
    switch (objectsArray.searchType) {
        case 0:
            _objectsArrayCopy = [[objectsArrayClass alloc] init];
            _objectsArrayCopy.storeObjectArray = [[NSMutableArray alloc] init];
            _objectsArrayCopy.strainObjectArray = [[NSMutableArray alloc] init];


            [self loadstrains];
            [self loadStores];
            
            break;
            
        case 1:
            self.navigationController.navigationBar.topItem.titleView = nil;
            [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
            self.navigationController.navigationBar.topItem.title = @"Near me";

            if (objectsArray.selection == 0){
//                load your recommended strains}
                _objectsArrayCopy.strainObjectArray = [[NSMutableArray alloc] init];
            }

            else if (objectsArray.selection == 1){
                _objectsArrayCopy.storeObjectArray = [[NSMutableArray alloc] init];
                [self loadDistances];
                [_objectsArrayCopy.storeObjectArray sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"distanceValue" ascending:YES selector:@selector(compare:)]]];
                [self.collectionView reloadData];}
            
            break;
            
        case 2:
            self.navigationController.navigationBar.topItem.titleView = nil;
            [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
            self.navigationController.navigationBar.topItem.title = @"A to Z";

            if (objectsArray.selection == 0){
                _objectsArrayCopy.strainObjectArray = [[NSMutableArray alloc] init];
  
                for (int i = 0; i <objectsArray.strainObjectArray.count; i++)
                    [_objectsArrayCopy.strainObjectArray addObject:[objectsArray.strainObjectArray objectAtIndex:i]];
                
                [_objectsArrayCopy.strainObjectArray sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"strainName" ascending:YES selector:@selector(caseInsensitiveCompare:)]]];
                [self.collectionView reloadData];}
            
            else if (objectsArray.selection == 1){
                _objectsArrayCopy.storeObjectArray = [[NSMutableArray alloc] init];

                for (int i = 0; i <objectsArray.storeObjectArray.count; i++)
                    [_objectsArrayCopy.storeObjectArray addObject:[objectsArray.storeObjectArray objectAtIndex:i]];
                
                [_objectsArrayCopy.storeObjectArray sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"storeName" ascending:YES selector:@selector(caseInsensitiveCompare:)]]];
                [self.collectionView reloadData];}
            
            break;
            
        case 3:
            if (objectsArray.selection == 0){
                self.navigationController.navigationBar.topItem.titleView = nil;
                [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
                self.navigationController.navigationBar.topItem.title = @"Smoked";

                _objectsArrayCopy.strainObjectArray = [[NSMutableArray alloc] init];

                for (int i = 0; i < user.strainsTried.count; i++) {
                    NSString *strainsTriedKey = [user.strainsTried objectAtIndex:i];
                    for(int j = 0; j < objectsArray.strainObjectArray.count; j++){
                        strainClass *tempStrain = [objectsArray.strainObjectArray objectAtIndex:j];
                        if ([strainsTriedKey isEqual:tempStrain.strainKey]) {
                            [_objectsArrayCopy.strainObjectArray addObject:tempStrain];}}}
                [self.collectionView reloadData];}
            
            else if (objectsArray.selection == 1){
                self.navigationController.navigationBar.topItem.titleView = nil;
                [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
                self.navigationController.navigationBar.topItem.title = @"Visited";

                _objectsArrayCopy.storeObjectArray = [[NSMutableArray alloc] init];

                for (int i = 0; i < user.storesVisited.count; i++) {
                    NSString *storeVisitedKey = [user.storesVisited objectAtIndex:i];
                    for(int j = 0; j < objectsArray.storeObjectArray.count; j++){
                        storeClass *tempStore = [objectsArray.storeObjectArray objectAtIndex:j];
                        if ([storeVisitedKey isEqual:tempStore.storeKey]) {
                            [_objectsArrayCopy.storeObjectArray addObject:tempStore];}}}
                [self.collectionView reloadData];}
            
            break;
            
        case 4:
            self.navigationController.navigationBar.topItem.titleView = nil;
            [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
            self.navigationController.navigationBar.topItem.title = @"Wish List";

            _objectsArrayCopy.strainObjectArray = [[NSMutableArray alloc] init];

            for (int i = 0; i < user.wishList.count; i++) {
                NSString *wishListKey = [user.wishList objectAtIndex:i];
                for(int j = 0; j < objectsArray.strainObjectArray.count; j++){
                    strainClass *tempStrain = [objectsArray.strainObjectArray objectAtIndex:j];
                    if ([wishListKey isEqual:tempStrain.strainKey]) {
                        [_objectsArrayCopy.strainObjectArray addObject:tempStrain];}}}
            [self.collectionView reloadData];
            
        default:
            break;
    }

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateLayoutForOrientation:[UIApplication sharedApplication].statusBarOrientation];
    [self loadExtView];
    
    self.navigationController.navigationBar.topItem.titleView = nil;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    
    if (objectsArray.selection == 0){
//        self.navigationController.navigationBar.topItem.title = @"Wish List";
    }
    else if (objectsArray.selection == 1){
//        self.navigationController.navigationBar.topItem.title = @"Near me";
    }
}

- (void)refreshTableau:(UIRefreshControl *)refresh {
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing data..."];
    objectsArray.searchType = 0;
    
    if (objectsArray.selection == 0){
            [self loadstrains];
    }
    else{
            [self loadStores];
    }
    [refresh endRefreshing];
}

-(void) loadstrains{
    objectsArray.strainObjectArray = [[NSMutableArray alloc] init];
    _objectsArrayCopy.strainObjectArray = [[NSMutableArray alloc] init];

    [firebaseRef.strainsRef observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        _strainObjectDictionary = snapshot.value; //Creates a dictionary of of the JSON node strains
        NSArray *keys = [_strainObjectDictionary allKeys]; //Creates an array with only the strain key uID
        
        for(int i=0; i<keys.count ; i++){
            NSString *key = keys[i];
            NSDictionary *strainDict = [_strainObjectDictionary valueForKey:key];
            NSDictionary *highDict = [strainDict valueForKey:@"highType"];
            NSMutableArray *imagesArray = [[NSMutableArray alloc] init];
            
            for (NSInteger j = 0; j < [[strainDict valueForKey:@"images"] count]; j++) {
                imageClass *image = [[imageClass alloc] init];
                image.imageURL = [[[strainDict valueForKey:@"images"] objectAtIndex:j] valueForKey:@"imageURL"];
                
                image.imageThumbsUp = [NSMutableArray arrayWithArray:[[[[strainDict valueForKey:@"images"] objectAtIndex:j] valueForKey:@"thumbsUp"] allKeys]];
                image.imageThumbsDown = [NSMutableArray arrayWithArray:[[[[strainDict valueForKey:@"images"] objectAtIndex:j] valueForKey:@"thumbsDown"] allKeys]];
                
                image.voteScore = image.imageThumbsUp.count - image.imageThumbsDown.count;
                image.firebaseIndex = j;
                
                image.dataString = [[[strainDict valueForKey:@"images"] objectAtIndex:0] valueForKey:@"data"];
                image.data =  [[NSData alloc] initWithBase64EncodedString:image.dataString options:0];

                [imagesArray addObject:image];
            }
            
            [imagesArray sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"voteScore" ascending:NO selector:@selector(compare:)]]];


            
            NSArray *availableAtArray = [[strainDict valueForKey:@"availableAt"] allKeys];
            
            NSArray *ratingsArray = [[strainDict valueForKey:@"ratingCount"] allValues];
            float ratingScore = 0.0;
            for (int i =0; i < ratingsArray.count; i++) {
                ratingScore += [[ratingsArray objectAtIndex:i] floatValue];
            }
            ratingScore = ratingScore / (float)ratingsArray.count;

            //you have to delcare a new object instance to load table cells!!!!!!!!!!!!!!!!!!!
            strainClass *strainLoop = [[strainClass alloc] init];
            [strainLoop setStrainObject:key
                         fromDictionary:strainDict
                               highType:highDict
                                 images:imagesArray
                            availableAt:availableAtArray
                            ratingCount:ratingsArray.count
                            ratingScore:ratingScore];
//            [strainLoop.imageNames removeObjectAtIndex:0];
            
//            dispatch_async(dispatch_get_global_queue(0,0), ^{
//                imageClass *tempImage = [[imageClass alloc] init];
//                tempImage = [strainLoop.imagesArray objectAtIndex:0];
//
//                NSInteger length = [tempImage.imageURL length];
//                NSString *smallImageURL = [tempImage.imageURL substringWithRange:NSMakeRange(0, length-4)];
//                smallImageURL = [smallImageURL stringByAppendingString:@"m.jpg"];
//
//                NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:smallImageURL]];
//                if( data == nil ){
//                    NSLog(@"image is nil");
//                    return;
//                }
//                else{
////                    strainLoop.data = data;
//                }
//
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.collectionView reloadData];
                });
//            });
            [objectsArray.strainObjectArray addObject:strainLoop];
            [_objectsArrayCopy.strainObjectArray addObject:strainLoop];
            
        }
    }];
}

-(void) loadDistances{
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
    
    for (int i = 0; i <objectsArray.storeObjectArray.count; i++) {
        [_objectsArrayCopy.storeObjectArray addObject:[objectsArray.storeObjectArray objectAtIndex:i]];
    }
}

- (void) loadStores {
    objectsArray.storeObjectArray = [[NSMutableArray alloc] init];
    _objectsArrayCopy.storeObjectArray = [[NSMutableArray alloc] init];

    [firebaseRef.storesRef observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        _storeObjectDictionary = snapshot.value; //Creates a dictionary of of the JSON node strains
        NSArray *keys = [_storeObjectDictionary allKeys]; //Creates an array with only the strain key uID
        
        for(int i=0; i<keys.count ; i++){
            NSString *key = keys[i];
            NSDictionary *storeDict = [_storeObjectDictionary valueForKey:key];
            NSMutableArray *imagesArray = [[NSMutableArray alloc] init];

            for (NSInteger j = 0; j < [[storeDict valueForKey:@"images"] count]; j++) {
                imageClass *image = [[imageClass alloc] init];
                image.imageURL = [[[storeDict valueForKey:@"images"] objectAtIndex:j] valueForKey:@"imageURL"];
                
                image.imageThumbsUp = [NSMutableArray arrayWithArray:[[[[storeDict valueForKey:@"images"] objectAtIndex:j] valueForKey:@"thumbsUp"] allKeys]];
                image.imageThumbsDown = [NSMutableArray arrayWithArray:[[[[storeDict valueForKey:@"images"] objectAtIndex:j] valueForKey:@"thumbsDown"] allKeys]];
                
                image.voteScore = image.imageThumbsUp.count - image.imageThumbsDown.count;
                image.firebaseIndex = j;
                
                image.dataString = [[[storeDict valueForKey:@"images"] objectAtIndex:0] valueForKey:@"data"];
                image.data =  [[NSData alloc] initWithBase64EncodedString:image.dataString options:0];

                [imagesArray addObject:image];
            }
            
            [imagesArray sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"voteScore" ascending:NO selector:@selector(compare:)]]];
            
            //you have to delcare a new object instance to load table cells!!!!!!!!!!!!!!!!!!!
            storeClass *storeloop = [[storeClass alloc] init];
            [storeloop setStoreObject:key
                       fromDictionary:storeDict
                               images:imagesArray];
//            dispatch_async(dispatch_get_global_queue(0,0), ^{
//                imageClass *tempImage = [[imageClass alloc] init];
//                tempImage = [storeloop.imagesArray objectAtIndex:0];
//
//                NSInteger length = [tempImage.imageURL length];
//
//                NSString *smallImageURL = [tempImage.imageURL substringWithRange:NSMakeRange(0, length-4)];
//                smallImageURL = [smallImageURL stringByAppendingString:@"m.jpg"];
//                
//                
//                NSString *stringForm = [[[storeDict valueForKey:@"images"] objectAtIndex:0] valueForKey:@"data"];
//                NSData * data = [stringForm dataUsingEncoding:NSUTF8StringEncoding];
//
//                if( data == nil ){
//                    NSLog(@"image is nil");
//                    return;
//                }
//                else{
////                    storeloop.data = data;
//
////                    tempImage.data = data1;
//                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.collectionView reloadData];
                });
//            });
            [objectsArray.storeObjectArray addObject:storeloop];
            [_objectsArrayCopy.storeObjectArray addObject:storeloop];
        }
        [_locationManager stopUpdatingLocation];
    }];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchBar.text.length == 0){
        if (objectsArray.selection == 0){
            _objectsArrayCopy.strainObjectArray = [[NSMutableArray alloc] init];
            
            for (int i = 0; i <objectsArray.strainObjectArray.count; i++)
                [_objectsArrayCopy.strainObjectArray addObject:[objectsArray.strainObjectArray objectAtIndex:i]];
            
            [_objectsArrayCopy.strainObjectArray sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"strainName" ascending:YES selector:@selector(caseInsensitiveCompare:)]]];
            [self.collectionView reloadData];}
        
        else if (objectsArray.selection == 1){
            _objectsArrayCopy.storeObjectArray = [[NSMutableArray alloc] init];
            
            for (int i = 0; i <objectsArray.storeObjectArray.count; i++)
                [_objectsArrayCopy.storeObjectArray addObject:[objectsArray.storeObjectArray objectAtIndex:i]];
            
            [_objectsArrayCopy.storeObjectArray sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"storeName" ascending:YES selector:@selector(caseInsensitiveCompare:)]]];
            [self.collectionView reloadData];}
    }
    else
        [self searchForSearchBarText];
}

-(void) searchForSearchBarText{
    if (objectsArray.selection == 0){
        _objectsArrayCopy.strainObjectArray = [[NSMutableArray alloc] init];

        for (int i = 0; i < objectsArray.strainObjectArray.count; i++) {
            strainClass *tempStrain = [objectsArray.strainObjectArray objectAtIndex:i];
            if ([tempStrain.strainName.lowercaseString hasPrefix:_searchBar.text.lowercaseString]) {
                NSLog(@"strain found %@", tempStrain.strainName);
                [_objectsArrayCopy.strainObjectArray addObject:tempStrain];
            }
        }
        
        [self.collectionView reloadData];}
    
    else if (objectsArray.selection == 1){
        _objectsArrayCopy.storeObjectArray = [[NSMutableArray alloc] init];

        for (int i = 0; i < objectsArray.storeObjectArray.count; i++) {
             storeClass *tempStore = [objectsArray.storeObjectArray objectAtIndex:i];
             if ([tempStore.storeName.lowercaseString hasPrefix:_searchBar.text.lowercaseString]) {
                 NSLog(@"store found %@", tempStore.storeName);
                 [_objectsArrayCopy.storeObjectArray addObject:tempStore];
             }
        }
        
        [self.collectionView reloadData];}
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
  [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
  [self updateLayoutForOrientation:toInterfaceOrientation];
}

- (void)updateLayoutForOrientation:(UIInterfaceOrientation)orientation {
  CHTCollectionViewWaterfallLayout *layout =
  (CHTCollectionViewWaterfallLayout *)self.collectionView.collectionViewLayout;
  layout.columnCount = UIInterfaceOrientationIsPortrait(orientation) ? 2 : 3;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (objectsArray.selection == 1)
        return [_objectsArrayCopy.storeObjectArray count];
    else
        return [_objectsArrayCopy.strainObjectArray count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  CHTCollectionViewWaterfallCell *cell =
  (CHTCollectionViewWaterfallCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];


    if (objectsArray.selection == 1){
        if ([_objectsArrayCopy.storeObjectArray count] > 0) {
            for(int i=0; i<[_objectsArrayCopy.storeObjectArray count]; i++){
                storeClass *tempStore = [[storeClass alloc] init];
                tempStore = [_objectsArrayCopy.storeObjectArray objectAtIndex:indexPath.row];
                
                imageClass *image = [[imageClass alloc] init];
                image = [tempStore.imagesArray objectAtIndex:0];

                cell.imageView.image = [UIImage imageWithData:image.data];
                cell.label.text = tempStore.storeName;
                if(tempStore.distanceToMe != nil){
                    cell.distanceToMeLabel.text = tempStore.distanceToMe;
                }
            }
        }
    }
    else if (objectsArray.selection == 0){
        if ([_objectsArrayCopy.strainObjectArray count] > 0) {
            for(int i=0; i<[_objectsArrayCopy.strainObjectArray count]; i++){
                strainClass *tempStrain = [[strainClass alloc] init];
                tempStrain = [_objectsArrayCopy.strainObjectArray objectAtIndex:indexPath.row];
                
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
    if (objectsArray.selection == 1){
        store = [_objectsArrayCopy.storeObjectArray objectAtIndex:indexPath.row];
        objectsArray.searchType = 0;
        [user goToStoreProfileViewController:self];
    }
    else if (objectsArray.selection == 0){
        strain = [_objectsArrayCopy.strainObjectArray objectAtIndex:indexPath.row];
        objectsArray.searchType = 0;
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

@end



