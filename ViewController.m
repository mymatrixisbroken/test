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
      
      
    CGRect frame = CGRectMake(0, self.view.bounds.origin.y + 200, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) -64);
    //_collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    
      
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
    
    if (objectsArray.selection == 0){
        [self loadstrains];
    }
    else if (objectsArray.selection == 1){
        [self loadStores];
    }

    
    self.shyNavBarManager.scrollView = self.collectionView;
     
     extensionViewClass *extView = [[extensionViewClass alloc] init];
     [extView setView:CGRectGetWidth(self.view.bounds)];
     [extView addButtons:CGRectGetWidth(self.view.bounds)];
     [extView.newsFeedButton addTarget:self action:@selector(newsFeedButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
     [extView.friendsButton addTarget:self action:@selector(friendsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
     [extView.strainButton addTarget:self action:@selector(strainButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
     [extView.storeButton addTarget:self action:@selector(storeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
     [extView.userProfileButton addTarget:self action:@selector(userProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
     
     //[self.shyNavBarManager setExtensionView:extView];
     //[self.shyNavBarManager setStickyExtensionView:YES];
    
    
    
    [self.view addSubview:self.collectionView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self updateLayoutForOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

-(void) loadstrains{
    _activity = [[UIActivityIndicatorView alloc] init];
    [_activity startAnimating];
    
    [objectsArray.strainObjectArray removeAllObjects];
    [firebaseRef.strainsRef observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        _strainObjectDictionary = snapshot.value; //Creates a dictionary of of the JSON node strains
        NSArray *keys = [_strainObjectDictionary allKeys]; //Creates an array with only the strain key uID
        
        for(int i=0; i<keys.count ; i++){
            NSString *key = keys[i];
            NSDictionary *dict = [_strainObjectDictionary valueForKey:key];
            NSDictionary *dict2 = [dict valueForKey:@"high_type"];
            NSArray *array = [dict valueForKey:@"images"];
            
            NSDictionary *dict3 = [dict valueForKey:@"rating_count"];
            _ratingScore = 0.0;
            _ratingCount = 0;
            NSArray *arr = [dict3 allValues];
            _ratingCount = arr.count;
            for (int i =0; i < _ratingCount; i++) {
                _ratingScore += [[arr objectAtIndex:i] floatValue];
            }
            _ratingScore = _ratingScore / (float)_ratingCount;
            

            
            //you have to delcare a new object instance to load table cells!!!!!!!!!!!!!!!!!!!
            strainClass *strainLoop = [[strainClass alloc] init];
            [strainLoop setClassObject:key Values:dict Image:array highType:dict2 :_ratingCount :_ratingScore];

            [strainLoop.imageNames removeObjectAtIndex:0];
                        
            [objectsArray.strainObjectArray addObject:strainLoop];
        }
        [_activity stopAnimating];
        [self.collectionView reloadData];
    }];
}

- (void) loadStores {
    _activity = [[UIActivityIndicatorView alloc] init];
    [_activity startAnimating];
    [objectsArray.storeObjectArray removeAllObjects];
    
    [firebaseRef.storesRef observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        _storeObjectDictionary = snapshot.value; //Creates a dictionary of of the JSON node strains
        NSArray *keys = [_storeObjectDictionary allKeys]; //Creates an array with only the strain key uID
        
        for(int i=0; i<keys.count ; i++){
            NSString *key = keys[i];
            NSDictionary *dict = [_storeObjectDictionary valueForKey:key];
            NSArray *array = [dict valueForKey:@"images"];
            
            //you have to delcare a new object instance to load table cells!!!!!!!!!!!!!!!!!!!
            storeClass *storeloop = [[storeClass alloc] init];
            [storeloop setClassObject:key Values:dict Image:array];
            [storeloop.imageNames removeObjectAtIndex:0];
            
            [objectsArray.storeObjectArray addObject:storeloop];
        }
        [_activity stopAnimating];
        [self.collectionView reloadData];
    }];

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
    if (objectsArray.selection == 1){
        return [objectsArray.storeObjectArray count];
    }
    else{
        return [objectsArray.strainObjectArray count];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  CHTCollectionViewWaterfallCell *cell =
  (CHTCollectionViewWaterfallCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];


    if (objectsArray.selection == 1){
        if ([objectsArray.storeObjectArray count] > 0) {
            for(int i=1; i<[objectsArray.storeObjectArray count]; i++){
                storeClass *tempStore = [[storeClass alloc] init];
                tempStore = [objectsArray.storeObjectArray objectAtIndex:indexPath.row];
                cell.label.text = tempStore.store_name;

                dispatch_async(dispatch_get_global_queue(0,0), ^{
                    NSInteger length = [[tempStore.imageNames objectAtIndex:0] length];
                    NSString *smallImageURL = [[tempStore.imageNames objectAtIndex:0] substringWithRange:NSMakeRange(0, length-4)];
                    smallImageURL = [smallImageURL stringByAppendingString:@"b.jpg"];
                    
                    NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:smallImageURL]];
                    if( data == nil ){
                        NSLog(@"image is nil");
                        return;
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // WARNING: is the cell still using the same data by this point??
                        cell.imageView.image = [UIImage imageWithData: data];
                    });
                });
            }
        }
    }
    else if (objectsArray.selection == 0){
        if ([objectsArray.strainObjectArray count] > 0) {
            for(int i=1; i<[objectsArray.strainObjectArray count]; i++){
                strainClass *tempStrain = [[strainClass alloc] init];
                tempStrain = [objectsArray.strainObjectArray objectAtIndex:indexPath.row];
                cell.label.text = tempStrain.strain_name;
                
                if ([tempStrain.species isEqual:@"stevia"]) {
                    cell.steviaImageView.image = [UIImage imageNamed:@"stevia"];
                }
                else if ([tempStrain.species isEqual:@"indica"]){
                    cell.indicaImageView.image = [UIImage imageNamed:@"indica"];
                }

                dispatch_async(dispatch_get_global_queue(0,0), ^{
                    NSInteger length = [[tempStrain.imageNames objectAtIndex:0] length];
                    NSString *smallImageURL = [[tempStrain.imageNames objectAtIndex:0] substringWithRange:NSMakeRange(0, length-4)];
                    smallImageURL = [smallImageURL stringByAppendingString:@"b.jpg"];
                
                    NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:smallImageURL]];
                    if( data == nil ){
                        NSLog(@"image is nil");
                        return;
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // WARNING: is the cell still using the same data by this point??
                        cell.imageView.image = [UIImage imageWithData: data];
                    });
                });
            }
        }
    }
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (objectsArray.selection == 1){
        store = [objectsArray.storeObjectArray objectAtIndex:indexPath.row];
        [self performSegueWithIdentifier:@"listToStoreProfileSegue" sender:self];
    }
    if (objectsArray.selection == 0){
        strain = [objectsArray.strainObjectArray objectAtIndex:indexPath.row];
        [self performSegueWithIdentifier:@"listToStrainProfileSegue" sender:self];
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



