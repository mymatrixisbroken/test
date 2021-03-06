//
//  userFriendsViewController.h
//  myProject
//
//  Created by Guy on 10/17/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userClass.h"
#import "FirebaseReferenceClass.h"
#import "userFriendsCell.h"
#import "findFriendClass.h"
#import <FirebaseStorageUI/FirebaseStorageUI.h>
#import "UserProfileViewController.h"
@import Firebase;

@interface userFriendsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet NSMutableArray *friendsArray;

@end
