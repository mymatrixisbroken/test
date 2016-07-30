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
#import "FirebaseReferenceClass.h"
@import Firebase;
@import Cosmos;

@interface StrainWriteReviewViewController : UIViewController
@property (strong, nonatomic) IBOutlet CosmosView *star_rating;
@property (strong, nonatomic) IBOutlet UITextView *review_text;
@end

