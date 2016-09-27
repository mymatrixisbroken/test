//
//  ViewController.m
//  Demo
//
//  Created by Nelson on 12/11/27.
//  Copyright (c) 2012年 Nelson. All rights reserved.
//

#import "imageCollectionViewController.h"
#import "imageCollectionViewCell.h"
#import "imageCollectionViewHeader.h"
#import "imageCollectionViewFooter.h"

#define CELL_COUNT 30
#define CELL_IDENTIFIER @"imageCollectionViewCell"
#define HEADER_IDENTIFIER @"imageCollectionViewHeader"
#define FOOTER_IDENTIFIER @"imageCollectionViewFooter"

@interface imageCollectionViewController ()
@property (nonatomic, strong) NSArray *cellSizes;
@property (nonatomic, strong) NSArray *cats;
@end

@implementation imageCollectionViewController

#pragma mark - Accessors

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        imageCollectionViewLayout *layout = [[imageCollectionViewLayout alloc] init];
        
        layout.sectionInset = UIEdgeInsetsMake(3, 3, 3 ,3);
        layout.headerHeight = 44;
        layout.footerHeight = 0;
        layout.minimumColumnSpacing = 1;
        layout.minimumInteritemSpacing = 1;
        
        
        //CGRect frame = CGRectMake(0, 63, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) -64);
        //_collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor blackColor];
        [_collectionView registerClass:[imageCollectionViewCell class]
            forCellWithReuseIdentifier:CELL_IDENTIFIER];
        [_collectionView registerClass:[imageCollectionViewHeader class]
            forSupplementaryViewOfKind:imageCollectionViewElementKindSectionHeader
                   withReuseIdentifier:HEADER_IDENTIFIER];
        [_collectionView registerClass:[imageCollectionViewFooter class]
            forSupplementaryViewOfKind:imageCollectionViewElementKindSectionFooter
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

    self.shyNavBarManager.scrollView = self.collectionView;
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
    imageCollectionViewLayout *layout =
    (imageCollectionViewLayout *)self.collectionView.collectionViewLayout;
    layout.columnCount = UIInterfaceOrientationIsPortrait(orientation) ? 2 : 3;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (objectsArray.selection == 1){
        return [store.imageNames count];
    }
    else{
        return [strain.imageNames count];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    imageCollectionViewCell *cell =
    (imageCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    
    if (objectsArray.selection == 1){
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:[store.imageNames objectAtIndex:indexPath.row]]];
            if( data == nil ){
                NSLog(@"image is nil");
                return;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imageView.image = [UIImage imageWithData:data];
            });
        });
    }
    else if (objectsArray.selection == 0){
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:[strain.imageNames objectAtIndex:indexPath.row]]];
            if( data == nil ){
                NSLog(@"image is nil");
                return;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imageView.image = [UIImage imageWithData:data];
            });
        });
    }
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (objectsArray.selection == 1){
        store.data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:[store.imageNames objectAtIndex:indexPath.row]]];
        [self performSegueWithIdentifier:@"collectionViewToImageView" sender:self];
    }
    else if (objectsArray.selection == 0){
        strain.data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:[strain.imageNames objectAtIndex:indexPath.row]]];
        [self performSegueWithIdentifier:@"collectionViewToImageView" sender:self];
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    
    if ([kind isEqualToString:imageCollectionViewElementKindSectionHeader]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:HEADER_IDENTIFIER
                                                                 forIndexPath:indexPath];
    } else if ([kind isEqualToString:imageCollectionViewElementKindSectionFooter]) {
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



