//
//  FirstViewController.h
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "objectsArrayClass.h"
@import Firebase;

@interface SearchTableViewController : UITableViewController  <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) NSInteger cellSelected;
@property (strong, nonatomic) IBOutlet NSDictionary *storeObjectDictionary;
@property (strong, nonatomic) IBOutlet NSDictionary *strainObjectDictionary;

@end

