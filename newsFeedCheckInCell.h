//
//  NewsFeedCheckInCell.h
//  myProject
//
//  Created by Guy on 10/17/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "activityClass.h"
#import "objectsArrayClass.h"
#import "FirebaseReferenceClass.h"
#import "userClass.h"
@import HCSStarRatingView;

@interface newsFeedCheckInCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *userImageView;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventLabel;
@property (strong, nonatomic) IBOutlet UIImageView *storeImageView;
@property (strong, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (strong, nonatomic) IBOutlet HCSStarRatingView *storeRatingView;
@property (strong, nonatomic) IBOutlet UIButton *commentsButton;
@property (strong, nonatomic) IBOutlet UIButton *likeButton;

-(void) uploadCellWithUsernameEventData:(activityClass *)tempActivity;


@end
