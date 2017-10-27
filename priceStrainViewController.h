//
//  priceStrainViewController.h
//  myProject
//
//  Created by Guy on 10/16/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userClass.h"
#import "strainClass.h"
#import "storeClass.h"
#import "priceStrainTableViewCell.h"
#import "StoreProfileViewController.h"
#import "FirebaseReferenceClass.h"
@import Firebase;

@interface priceStrainViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet NSMutableArray *strainArray;
@property (strong, nonatomic) IBOutlet UITableView *priceStrainsTableView;
@property (strong, nonatomic) IBOutlet UIButton *confirmButton;
@property (strong, nonatomic) IBOutlet UIView *menuView;

@end
