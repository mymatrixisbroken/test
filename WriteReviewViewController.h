//
//  FirstViewController.h
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userClass.h"
#import "strainClass.h"
#import "storeClass.h"
#import "reviewClass.h"
#import "FirebaseReferenceClass.h"
#import "objectsArrayClass.h"
#import "imageClass.h"
@import Firebase;
@import HCSStarRatingView;

@interface WriteReviewViewController : UIViewController
@property (strong, nonatomic) IBOutlet HCSStarRatingView *storeStarRating;
@property (strong, nonatomic) IBOutlet UILabel *storeRatingLabel;
@property (strong, nonatomic) IBOutlet UILabel *storeReviewCount;
@property (strong, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (strong, nonatomic) IBOutlet UITextView *reviewTextField;
@property (strong, nonatomic) IBOutlet HCSStarRatingView *reviewStarRating;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
@end

