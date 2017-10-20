//
//  EditStoreViewController.h
//  myProject
//
//  Created by Guy on 9/19/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "storeClass.h"
#import "FirebaseReferenceClass.h"
@import GoogleMaps;


@interface EditStoreViewController : UIViewController <UITabBarDelegate>
@property (strong, nonatomic) IBOutlet UITextField *addressField;
@property (strong, nonatomic) IBOutlet UITextField *cityStateZipField;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberField;
@property (strong, nonatomic) IBOutlet UITextField *storeHoursField;
@property (strong, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (strong, nonatomic) IBOutlet UITabBarItem *promosTabBarItem;
@property (strong, nonatomic) IBOutlet UITabBarItem *strainsTabBarItem;
@property (strong, nonatomic) IBOutlet UITabBarItem *reviewsTabBarItem;
@property (strong, nonatomic) IBOutlet UITabBar *tabBar;
@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIButton *confirmButton;
@property (strong, nonatomic) IBOutlet UIView *mapView;
@property double storeLat;
@property double storeLng;

@end
