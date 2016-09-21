//
//  optionsListTableViewController.h
//  myProject
//
//  Created by Guy on 9/20/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;
@interface optionsListTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet FIRUser *currentUser;
@end
