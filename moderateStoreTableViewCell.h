//
//  moderateStoreTableViewCell.h
//  myProject
//
//  Created by Guy on 9/16/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "moderateStoreTableViewController.h"
#import "objectsArrayClass.h"
#import "userClass.h"
#import "storeClass.h"

@interface moderateStoreTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UITextField *storeName;
@property (strong, nonatomic) IBOutlet UITextField *address;
@property (strong, nonatomic) IBOutlet UITextField *cityStateZip;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumber;
@property (strong, nonatomic) IBOutlet UITextField *storeHours;
@property (strong, nonatomic) IBOutlet UIButton *approveButton;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong, nonatomic) IBOutlet storeClass *myStore;

@end
