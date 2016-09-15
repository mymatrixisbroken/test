//
//  FirstViewController.h
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@import Firebase;

@interface SearchTableViewController : UITableViewController  <UITableViewDelegate, UITableViewDataSource>
@property BOOL cellSelected;

@end

