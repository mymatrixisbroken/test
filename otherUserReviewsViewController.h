//
//  otherUserReviewsViewController.h
//  myProject
//
//  Created by Guy on 10/26/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import "ViewController.h"
#import "userClass.h"
#import "userReviewCell.h"
#import "reviewClass.h"
#import <FirebaseStorageUI/FirebaseStorageUI.h>
#import <UIKit/UIKit.h>

@interface otherUserReviewsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet userClass *otherUser;

@end
