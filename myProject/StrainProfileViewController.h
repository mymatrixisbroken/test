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
#import "FirebaseReferenceClass.h"
@import Cosmos;
@import Firebase;

@interface StrainProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *strainImage;
@property (weak, nonatomic) IBOutlet CosmosView *starRating;
@property (strong, nonatomic) IBOutlet UILabel *strainNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *strainTHCLabel;
@property (strong, nonatomic) IBOutlet UILabel *strainCBDLabel;
@property (strong, nonatomic) IBOutlet UILabel *strainHighTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *strainFlavorLabel;
@property (strong, nonatomic) IBOutlet UILabel *strainAromaLabel;
@property (strong, nonatomic) IBOutlet UILabel *strainSpeciesLabel;
@property (strong, nonatomic) IBOutlet UILabel *strainGrowerLabel;
@property (strong, nonatomic) IBOutlet UIView *infoView;
@property (strong, nonatomic) IBOutlet UILabel *ratingCount;
@end

