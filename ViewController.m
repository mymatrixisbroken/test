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
    _cellSelected  = [[NSUserDefaults standardUserDefaults] boolForKey:@"integer"];
  [self.view addSubview:self.collectionView];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self updateLayoutForOrientation:[UIApplication sharedApplication].statusBarOrientation];
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
    if(_cellSelected){
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
  (CHTCollectionViewWaterfallCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER
                                                                              forIndexPath:indexPath];

    if(_cellSelected){
        if ([objectsArray.storeObjectArray count] > 0) {
            for(int i=1; i<[objectsArray.storeObjectArray count]; i++){
                storeClass *tempStore = [[storeClass alloc] init];
                tempStore = [objectsArray.storeObjectArray objectAtIndex:indexPath.row];                
                dispatch_async(dispatch_get_global_queue(0,0), ^{
                    NSInteger length = [[tempStore.imageNames objectAtIndex:0] length];
                    NSString *smallImageURL = [[tempStore.imageNames objectAtIndex:0] substringWithRange:NSMakeRange(0, length-4)];
                    smallImageURL = [smallImageURL stringByAppendingString:@"m.jpg"];
                    
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
    else{
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
                    smallImageURL = [smallImageURL stringByAppendingString:@"m.jpg"];
                
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
    if(_cellSelected){
        store = [objectsArray.storeObjectArray objectAtIndex:indexPath.row];
        [self performSegueWithIdentifier:@"listToStoreProfileSegue" sender:self];
    }
    else if (!_cellSelected){
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



