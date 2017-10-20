//
//  StoreReviewTableViewController.h
//  myProject
//
//  Created by Guy on 10/24/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreReviewCell.h"
#import "storeClass.h"
#import "reviewClassNew.h"
#import "userClass.h"
#import <FirebaseStorageUI/FirebaseStorageUI.h>
@import Firebase;


@interface StoreReviewTableViewController : UITableViewController  <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UILabel *ratingLabel;
@property (strong, nonatomic) IBOutlet UILabel *reviewCountLabel;

@end
