//
//  otherUserFriendsViewController.h
//  myProject
//
//  Created by Guy on 10/26/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userClass.h"
#import "FirebaseReferenceClass.h"
#import "userFriendsCell.h"
#import "findFriendClass.h"
#import <FirebaseStorageUI/FirebaseStorageUI.h>
#import "UserProfileViewController.h"
@import Firebase;

@interface otherUserFriendsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet NSMutableArray *friendsArray;
@property (strong, nonatomic) IBOutlet userClass *otherUser2;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
