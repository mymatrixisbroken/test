//
//  CurrentUserReviewsCell.h
//  myProject
//
//  Created by Guy on 10/17/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "reviewClass.h"
@import HCSStarRatingView;

@interface CurrentUserReviewsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *objectImageView;
@property (strong, nonatomic) IBOutlet UILabel *objectNameLabel;
@property (strong, nonatomic) IBOutlet HCSStarRatingView *reviewRating;
@property (strong, nonatomic) IBOutlet UILabel *reviewMessage;

-(void)uploadCellWithReview:(reviewClass *)tempReview;

@end
