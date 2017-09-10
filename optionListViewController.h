//
//  FirstViewController.h
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

@interface optionListViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *menuView;
@property (strong, nonatomic) IBOutlet UITableView *optionTableView;
@property (strong, nonatomic) IBOutlet FIRUser *currentUser;
@property NSInteger rowCount;


@end

