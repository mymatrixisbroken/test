//
//  StoreReviewCell.h
//  myProject
//
//  Created by Guy on 10/24/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "reviewClass.h"
@import HCSStarRatingView;

@interface StoreReviewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *userImageView;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet HCSStarRatingView *reviewStarRating;
@property (strong, nonatomic) IBOutlet UILabel *reviewMessageLabel;
@property (strong, nonatomic) IBOutlet UILabel *reviewLikesLabel;

-(void)uploadCellWithReview:(reviewClass *)tempReview;

@end
