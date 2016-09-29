//
//  optionsListTableViewController.h
//  myProject
//
//  Created by Guy on 9/20/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userClass.h"
@import Firebase;

@interface optionsListTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet FIRUser *currentUser;
@property (strong, nonatomic) IBOutlet UIStoryboard *sb;
@property (strong, nonatomic) IBOutlet UIViewController *vc;

@end

