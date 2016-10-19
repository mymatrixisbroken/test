//
//  userReviewsViewController.h
//  myProject
//
//  Created by Guy on 10/18/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "ViewController.h"
#import "userClass.h"
#import "userReviewCell.h"
#import "reviewClass.h"

@interface userReviewsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
