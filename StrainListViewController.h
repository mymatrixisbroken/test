//
//  SecondViewController.h
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "strainClass.h"
#import "FirebaseReferenceClass.h"
#import "ICHObjectPrinter.h"
@import Firebase;

@interface StrainListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *AddStrainButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet NSMutableArray *strainObjectArray;
@property (strong, nonatomic) IBOutlet NSDictionary *strainObjectDictionary;

@end

