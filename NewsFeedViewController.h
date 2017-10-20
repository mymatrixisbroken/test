//
//  SecondViewController.h
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TLYShyNavBar/TLYShyNavBarManager.h>
#import "extensionViewClass.h"
#import "userClass.h"
#import "activityClass.h"
#import "newsFeedStoreAddPhotosCell.h"
#import "newsFeedCheckInCell.h"
#import "newsFeedWroteReviewStoreCell.h"
#import "newsFeedWroteReviewStrainCell.h"
#import "FirebaseReferenceClass.h"
#import "objectsArrayClass.h"
#import "imageClass.h"
#import "StoreProfileViewController.h"
#import <FirebaseStorageUI/FirebaseStorageUI.h>
@import Firebase;

@interface NewsFeedViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet NSMutableArray *queriesArray;
@property (strong, nonatomic) IBOutlet NSMutableDictionary *dict;
@property (strong, nonatomic) IBOutlet UIView *emptyStateView;

@end

