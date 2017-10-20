//
//  StoreReviewTableViewController.h
//  myProject
//
//  Created by Guy on 10/24/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreStrainsCell.h"
#import "storeClass.h"
#import "reviewClass.h"
#import "userClass.h"
#import "strainClass.h"
#import "StrainProfileViewController.h"
#import <QuartzCore/QuartzCore.h>
@import Firebase;


@interface StoreStrainsTableViewController : UITableViewController  <UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate>

@end
