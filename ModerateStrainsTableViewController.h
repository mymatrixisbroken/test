//
//  ModerateStrainsTableViewController.h
//  myProject
//
//  Created by Guy on 10/1/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirebaseReferenceClass.h"
#import "strainClass.h"
#import "userClass.h"
#import "objectsArrayClass.h"
#import "ModerateStrainTableViewCell.h"
@import Firebase;

@interface ModerateStrainsTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet NSArray *strainKeys;

@end
