//
//  userFriendRequestViewController.h
//  myProject
//
//  Created by Guy on 10/18/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userFriendRequestCell.h"
#import "userClass.h"
#import "findFriendClass.h"
#import "firebaseReferenceClass.h"

@interface userFriendRequestViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
