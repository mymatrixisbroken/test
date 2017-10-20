//
//  ModerateStrainTableViewCell.h
//  myProject
//
//  Created by Guy on 10/1/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModerateStrainsTableViewController.h"
#import "objectsArrayClass.h"
#import "userClass.h"
#import "strainClass.h"

@interface ModerateStrainTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UITextField *strainNameField;
@property (strong, nonatomic) IBOutlet UISegmentedControl *familyTypeSegment;
@property (strong, nonatomic) IBOutlet UITextField *cbdField;
@property (strong, nonatomic) IBOutlet UITextField *thcField;
@property (strong, nonatomic) IBOutlet UITextField *cbnField;
@property (strong, nonatomic) IBOutlet UIButton *approveButton;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong, nonatomic) IBOutlet strainClass *myStrain;

@end
