//
//  imageCollectionViewController.h
//  myProject
//
//  Created by Guy on 9/24/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "imageCollectionViewLayout.h"
#import "strainClass.h"
#import "storeClass.h"
#import "objectsArrayClass.h"
#import <TLYShyNavBar/TLYShyNavBarManager.h>
#import "extensionViewClass.h"

@interface imageCollectionViewController : UIViewController  <UICollectionViewDataSource, imageCollectionViewDelegateLayout>
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet NSDictionary *storeObjectDictionary;
@property (strong, nonatomic) IBOutlet NSDictionary *strainObjectDictionary;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;


@end
