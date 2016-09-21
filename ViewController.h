//
//  ViewController.h
//  Demo
//
//  Created by Nelson on 12/11/27.
//  Copyright (c) 2012年 Nelson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHTCollectionViewWaterfallLayout.h"
#import "strainClass.h"
#import "storeClass.h"
#import "objectsArrayClass.h"
#import <TLYShyNavBar/TLYShyNavBarManager.h>
#import "extensionViewClass.h"



@interface ViewController : UIViewController <UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout>
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet NSDictionary *storeObjectDictionary;
@property (strong, nonatomic) IBOutlet NSDictionary *strainObjectDictionary;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property float ratingScore;
@property NSInteger ratingCount;

@end
