//
//  moderateStoreTableViewController.h
//  myProject
//
//  Created by Guy on 9/16/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirebaseReferenceClass.h"
#import "storeClass.h"
#import "userClass.h"
#import "objectsArrayClass.h"
#import "moderateStoreTableViewCell.h"
@import Firebase;

@interface moderateStoreTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet NSArray *storeKeys;

@end
