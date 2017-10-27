//
//  searchStrainsViewController.h
//  myProject
//
//  Created by Guy on 10/8/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TLYShyNavBar/TLYShyNavBarManager.h>
#import "userClass.h"
#import "strainClass.h"
#import "searchStrainTableViewCell.h"
#import "UserProfileViewController.h"
#import "extensionViewClass.h"
#import "priceStrainViewController.h"


@interface searchStrainsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *searchStrainsTableView;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet NSMutableArray *strainNamesArray;
@property (strong, nonatomic) IBOutlet NSMutableArray *strainsDownloadOnce;
@property (strong, nonatomic) IBOutlet NSMutableArray *displayStrains;
@property (strong, nonatomic) IBOutlet NSMutableArray *selectedStrains;
@property (strong, nonatomic) IBOutlet NSArray *strainKeys;
@property (strong, nonatomic) IBOutlet extensionViewClass *extView;
@property (strong, nonatomic) IBOutlet UIButton *addButton;
@property (strong, nonatomic) IBOutlet UIView *menuView;

@end
