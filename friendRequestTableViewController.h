//
//  friendRequestTableViewController.h
//  myProject
//
//  Created by Guy on 10/21/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userClass.h"
#import "imageClass.h"
#import "FirebaseReferenceClass.h"
#import "friendRequestTableViewCell.h"
#import "objectsArrayClass.h"
#import <FirebaseStorageUI/FirebaseStorageUI.h>
@import Firebase;

@interface friendRequestTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet NSMutableArray *requestUsersArray;

@end
