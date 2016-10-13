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
    layout.headerHeight = 44;
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
            
            self.navigationController.navigationBar.topItem.rightBarButtonItem = nil;
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
    
//    _rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Search"] style:UIBarButtonItemStylePlain target:self   action:@selector(searchButtonTapped:)];
    
//    self.navigationController.navigationBar.topItem.rightBarButtonItem = _rightButton;
    
    self.navigationController.navigationBar.topItem.titleView = nil;
    
    if (objectsArray.selection == 0){
        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
        self.navigationController.navigationBar.topItem.title = @"Strains";
    }
    else if(objectsArray.selection == 1){
        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
        self.navigationController.navigationBar.topItem.title = @"Stores";
    }
    
    [self loadStoreStrain];

    self.shyNavBarManager.scrollView = self.collectionView;
    [self.view addSubview:self.collectionView];
    
    if (_refresh == nil) {
        _refresh = [[UIRefreshControl alloc] init];
    }
    
    _refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [self.collectionView addSubview:_refresh];
    [_refresh addTarget:self action:@selector(refreshTableau:) forControlEvents:UIControlEventValueChanged];
}

- (void)searchButtonTapped:(id)sender {
    
    [UIView animateWithDuration:0.5 animations:^{
//        _rightButton.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        
        self.navigationController.navigationBar.topItem.rightBarButtonItem = nil;
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
        self.navigationController.navigationBar.topItem.rightBarButtonItem = _rightButton;
//        _rightButton.alpha = 0.0;  // set this *after* adding it back
        [UIView animateWithDuration:0.5f animations:^ {
//            _rightButton.alpha = 1.0;
        }];
        
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mapview"] style:UIBarButtonItemStylePlain target:self   action:@selector(barButtonCustomPressed:)];

        self.navigationController.navigationBar.topItem.rightBarButtonItem = rightButton;

        
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

-(IBAction) barButtonCustomPressed:(UIBarButtonItem*)btn
{
    [user gotoMapViewViewController:self];
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
                _objectsArrayCopy.strainObjectArray = [[NSMutableArray alloc] init];

                for (int i = 0; i < user.strainsTried.count; i++) {
                    NSString *strainsTriedKey = [user.strainsTried objectAtIndex:i];
                    for(int j = 0; j < objectsArray.strainObjectArray.count; j++){
                        strainClass *tempStrain = [objectsArray.strainObjectArray objectAtIndex:j];
                        if ([strainsTriedKey isEqual:tempStrain.strainKey]) {
                            [_objectsArrayCopy.strainObjectArray addObject:tempStrain];}}}
                [self.collectionView reloadData];}
            
            else if (objectsArray.selection == 1){
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
            NSArray *array = [strainDict valueForKey:@"images"] ;
            
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
                                 images:array
                            availableAt:availableAtArray
                            ratingCount:ratingsArray.count
                            ratingScore:ratingScore];
            [strainLoop.imageNames removeObjectAtIndex:0];
            
            dispatch_async(dispatch_get_global_queue(0,0), ^{
                NSInteger length = [[strainLoop.imageNames objectAtIndex:0] length];
                NSString *smallImageURL = [[strainLoop.imageNames objectAtIndex:0] substringWithRange:NSMakeRange(0, length-4)];
                smallImageURL = [smallImageURL stringByAppendingString:@"m.jpg"];

                NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:smallImageURL]];
                if( data == nil ){
                    NSLog(@"image is nil");
                    return;
                }
                else{
                    strainLoop.data = data;
                }

                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.collectionView reloadData];
                });
            });
            [objectsArray.strainObjectArray addObject:strainLoop];
            [_objectsArrayCopy.strainObjectArray addObject:strainLoop];
            
        }
    }];
}

-(void) loadDistances{
    
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

   
    for (int i = 0; i < objectsArray.storeObjectArray.count; i++) {
        storeClass *storeloop = [objectsArray.storeObjectArray objectAtIndex:i];
    
        NSString *geocodingBaseURL = @"https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=";
        NSString *url = [NSString stringWithFormat:@"%@%f,%f&destinations=%@,%@&key=AIzaSyAsZ171sgZHuTcapToLRQ5-W9dl_WRLOh4", geocodingBaseURL, coordinate.latitude,coordinate.longitude,storeloop.latitude,storeloop.longitude];
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *queryURL = [NSURL URLWithString:url];
        NSData *data = [NSData dataWithContentsOfURL:queryURL];
        
        NSError *error;
        NSDictionary *json = [NSJSONSerialization
                              JSONObjectWithData:data
                              options:kNilOptions
                              error:&error];
        if (coordinate.latitude != 0.00){
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
    [_locationManager stopUpdatingLocation];
    
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
            NSArray *imagesArray = [storeDict valueForKey:@"images"];
            
            //you have to delcare a new object instance to load table cells!!!!!!!!!!!!!!!!!!!
            storeClass *storeloop = [[storeClass alloc] init];
            [storeloop setStoreObject:key
                       fromDictionary:storeDict
                               images:imagesArray];
            [storeloop.imageNames removeObjectAtIndex:0];
            dispatch_async(dispatch_get_global_queue(0,0), ^{
                NSInteger length = [[storeloop.imageNames objectAtIndex:0] length];
                NSString *smallImageURL = [[storeloop.imageNames objectAtIndex:0] substringWithRange:NSMakeRange(0, length-4)];
                smallImageURL = [smallImageURL stringByAppendingString:@"m.jpg"];
                
                NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:smallImageURL]];
                if( data == nil ){
                    NSLog(@"image is nil");
                    return;
                }
                else{
                    storeloop.data = data;
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.collectionView reloadData];
                });
            });
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
                
                cell.imageView.image = [UIImage imageWithData:tempStore.data];
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
                
                cell.imageView.image = [UIImage imageWithData:tempStrain.data];
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



