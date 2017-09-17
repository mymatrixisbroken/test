//
//  searchViewController.h
//  myProject
//
//  Created by Guy on 8/26/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TLYShyNavBar/TLYShyNavBarManager.h>
#import "extensionViewClass.h"
#import "FirebaseReferenceClass.h"
#import "userClass.h"
#import "storeClass.h"
#import "searchResultTableViewCell.h"
#import "UserProfileViewController.h"
#import "StoreProfileViewController.h"
@import Firebase;


@interface searchViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *searchTableView;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet extensionViewClass *extView;
@property (strong, nonatomic) IBOutlet NSMutableArray *usernamesArray;
@property (strong, nonatomic) IBOutlet NSMutableArray *storeNamesArray;
@property (strong, nonatomic) IBOutlet NSMutableArray *strainNamesArray;

@end
