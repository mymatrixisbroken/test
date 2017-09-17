//
//  FirstViewController.h
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "storeClass.h"
#import "FirebaseReferenceClass.h"
#import <QuartzCore/QuartzCore.h>
#import "userClass.h"
#import "reviewClass.h"
#import "imageClass.h"
#import <FirebaseStorageUI/FirebaseStorageUI.h>
#import "popOverImageViewController.h"
@import HCSStarRatingView;
@import Firebase;
@import GoogleMaps;

@interface StoreProfileViewController : UIViewController <GMSMapViewDelegate, UITabBarDelegate>

@property (strong, nonatomic) IBOutlet UIButton *back_button;
@property (strong, nonatomic) IBOutlet UIButton *edit_button;
@property (strong, nonatomic) IBOutlet UIImageView *store_image_view;
@property (strong, nonatomic) IBOutlet HCSStarRatingView *store_rating_score;
@property (strong, nonatomic) IBOutlet UILabel *store_rating_count;
@property (strong, nonatomic) IBOutlet UILabel *store_name_label;
@property (strong, nonatomic) IBOutlet UILabel *store_address_label;
@property (strong, nonatomic) IBOutlet UILabel *store_city_label;
@property (strong, nonatomic) IBOutlet UILabel *store_state_label;
@property (strong, nonatomic) IBOutlet UILabel *store_url_label;
@property (strong, nonatomic) IBOutlet UILabel *store_phone_number_label;
@property (strong, nonatomic) IBOutlet UIButton *checkInButton;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *hoursLabel;
@property (strong, nonatomic) IBOutlet UILabel *openNowLabel;
@property (strong, nonatomic) IBOutlet UIView *mapView;
@property (strong, nonatomic) IBOutlet UITabBar *tabBar;
@property (strong, nonatomic) IBOutlet UITabBarItem *aboutBarItem;
@property (strong, nonatomic) IBOutlet UITabBarItem *strainsBarItem;
@property (strong, nonatomic) IBOutlet UITabBarItem *reviewsBarItem;
@property (strong, nonatomic) IBOutlet UITabBarItem *photosBarItem;
@property (strong, nonatomic) IBOutlet UITabBarItem *favoriteBarItem;
@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet UITableViewController *tablevc;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (copy, nonatomic) NSString *passedString;


@end

