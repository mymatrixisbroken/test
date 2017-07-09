//
//  TableViewController.h
//  myProject
//
//  Created by Guy on 3/6/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "objectsArrayClass.h"
#import "userClass.h"
#import <CoreLocation/CoreLocation.h>


@interface FilterMenuTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet CAGradientLayer *gradientMask;
@property (strong, nonatomic) IBOutlet UITableViewCell *filterMenuCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *filterMenuCell3;
@property (strong, nonatomic) IBOutlet UITableViewCell *filterMenuCell2;
@property (strong, nonatomic) IBOutlet UITableViewCell *filterMenuCell4;
@property (strong, nonatomic) IBOutlet UITableViewCell *filterMenuCell5;

@end
