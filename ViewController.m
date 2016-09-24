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
      
      
    CGRect frame = CGRectMake(0, 63, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) -64);
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
    _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge]; [self.view addSubview:_activity];

    if (objectsArray.selection == 0){
        [self loadstrains];
    }
    else if (objectsArray.selection == 1){
        [self loadStores];
    }

    self.shyNavBarManager.scrollView = self.collectionView;
    [self.view addSubview:self.collectionView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateLayoutForOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

-(void) loadstrains{
    [objectsArray.strainObjectArray removeAllObjects];
    [firebaseRef.strainsRef observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        _strainObjectDictionary = snapshot.value; //Creates a dictionary of of the JSON node strains
        NSArray *keys = [_strainObjectDictionary allKeys]; //Creates an array with only the strain key uID
        
        for(int i=0; i<keys.count ; i++){
            NSString *key = keys[i];
            NSDictionary *strainDict = [_strainObjectDictionary valueForKey:key];
            NSDictionary *highDict = [strainDict valueForKey:@"highType"];
            NSArray *array = [strainDict valueForKey:@"images"] ;
            
            NSArray *availableAtArray = [[strainDict valueForKey:@"availableAt"] allKeys];
            
            NSArray *ratingsArray = [[strainDict valueForKey:@"ratings"] allValues];
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
        }
    }];
}

- (void) loadStores {
    [objectsArray.storeObjectArray removeAllObjects];
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
        }
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
                
                cell.imageView.image = [UIImage imageWithData:tempStore.data];
                cell.label.text = tempStore.storeName;
            }
        }
    }
    else if (objectsArray.selection == 0){
        if ([objectsArray.strainObjectArray count] > 0) {
            for(int i=1; i<[objectsArray.strainObjectArray count]; i++){
                strainClass *tempStrain = [[strainClass alloc] init];
                tempStrain = [objectsArray.strainObjectArray objectAtIndex:indexPath.row];
                
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



