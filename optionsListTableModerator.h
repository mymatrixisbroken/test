//
//  optionsListTableModerator.h
//  myProject
//
//  Created by Guy on 9/16/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userClass.h"
#import "objectsArrayClass.h"
@import Firebase;

@interface optionsListTableModerator : UITableViewController
@property (strong, nonatomic) IBOutlet FIRUser *currentUser;
@property (strong, nonatomic) IBOutlet UIStoryboard *sb;
@property (strong, nonatomic) IBOutlet UIViewController *vc;
@property NSInteger rowCount;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *photoCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *activityCountLabel;

@end
