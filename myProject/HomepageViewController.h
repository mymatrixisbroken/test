//
//  FirstViewController.h
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

@interface HomepageViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet NSString *label;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

