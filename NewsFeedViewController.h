//
//  SecondViewController.h
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TLYShyNavBar/TLYShyNavBarManager.h>
#import "extensionViewClass.h"
#import "userClass.h"
#import "eventClass.h"
#import "newsFeedCell.h"
#import "FirebaseReferenceClass.h"
#import "objectsArrayClass.h"
@import Firebase;

@interface NewsFeedViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet NSMutableArray *queriesArray;
@property (strong, nonatomic) IBOutlet NSMutableDictionary *dict;

@end

