//
//  userReviewCell.h
//  myProject
//
//  Created by Guy on 10/18/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "reviewClass.h"
#import "SWTableViewCell.h"
@import HCSStarRatingView;

@interface userReviewCell : SWTableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *objectImageView;
@property (strong, nonatomic) IBOutlet HCSStarRatingView *reviewRatingView;
@property (strong, nonatomic) IBOutlet UILabel *objectNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *reviewMessageLabel;
@property (strong, nonatomic) IBOutlet HCSStarRatingView *objectRatingView;
@property (strong, nonatomic) IBOutlet UILabel *objectReviewCount;

-(void)uploadCellWithReview:(reviewClass *)tempReview;

@end
