//
//  UserProfileTableViewCell.h
//  myProject
//
//  Created by Guy on 9/11/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "reviewClass.h"
@import HCSStarRatingView;

@interface UserProfileReviewsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *objectImageView;
@property (strong, nonatomic) IBOutlet UILabel *objectNameLabel;
@property (strong, nonatomic) IBOutlet HCSStarRatingView *reviewRating;
@property (strong, nonatomic) IBOutlet UILabel *reviewMessage;

-(void)uploadCellWithReview:(reviewClass *)tempReview;

@end
