//
//  SecondViewController.h
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "storeClass.h"
#import "strainClass.h"
#import "FirebaseReferenceClass.h"
#import "ICHObjectPrinter.h"
@import Firebase;

@interface ListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIBarButtonItem *optionsListButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property BOOL optionSelected;

@end

