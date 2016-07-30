//
//  SecondViewController.h
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "storeClass.h"
#import "ICHObjectPrinter.h"
#import "FirebaseReferenceClass.h"
@import Firebase;

@interface StoreListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *AddStoreButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet NSMutableArray *storeObjectArray;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *optionsListButton;
@property (strong, nonatomic) IBOutlet NSDictionary *storeObjectDictionary;

@end

