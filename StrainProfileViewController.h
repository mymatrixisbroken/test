//
//  FirstViewController.h
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "strainClass.h"
#import "userClass.h"
#import "YLProgressBar.h"
#import "FirebaseReferenceClass.h"
#import "imageClass.h"
#import <FirebaseStorageUI/FirebaseStorageUI.h>
@import HCSStarRatingView;
@import Firebase;

@interface StrainProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *strainImage;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *starRating;
@property (strong, nonatomic) IBOutlet UILabel *strainNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *strainTHCLabel;
@property (strong, nonatomic) IBOutlet UILabel *strainCBDLabel;
@property (strong, nonatomic) IBOutlet UILabel *strainCBNLabel;
@property (strong, nonatomic) IBOutlet UILabel *strainFlavorLabel;
@property (strong, nonatomic) IBOutlet UILabel *strainAromaLabel;
@property (strong, nonatomic) IBOutlet UILabel *strainSpeciesLabel;
@property (strong, nonatomic) IBOutlet UILabel *strainGrowerLabel;
@property (strong, nonatomic) IBOutlet UIView *infoView;
@property (strong, nonatomic) IBOutlet YLProgressBar *happinessView;
@property (strong, nonatomic) IBOutlet YLProgressBar *upliftedView;
@property (strong, nonatomic) IBOutlet YLProgressBar *euphoricView;
@property (strong, nonatomic) IBOutlet YLProgressBar *energeticView;
@property (strong, nonatomic) IBOutlet UILabel *availableAtLabel;
@property (strong, nonatomic) IBOutlet YLProgressBar *relaxedView;
@property (strong, nonatomic) IBOutlet UILabel *ratingCount;
@property (strong, nonatomic) IBOutlet UIButton *smokedButton;
@property (copy, nonatomic) NSString *passedString;
@property (copy, nonatomic) NSString *passedStringSegueFromStore;
@property (strong, nonatomic) IBOutlet UIView *priceView;
@property (strong, nonatomic) IBOutlet UITableView *reviewsTableView;
@property UIActivityIndicatorView *spinner;

@end

