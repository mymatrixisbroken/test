//
//  newsFeedWroteReviewStoreCell.h
//  myProject
//
//  Created by Guy on 10/17/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "eventClass.h"
#import "FirebaseReferenceClass.h"
#import "objectsArrayClass.h"
#import "userClass.h"
@import HCSStarRatingView;


@interface newsFeedWroteReviewStoreCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *userImageView;
@property (strong, nonatomic) IBOutlet UILabel *eventLabel;
@property (strong, nonatomic) IBOutlet UIImageView *storeImageView;
@property (strong, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (strong, nonatomic) IBOutlet HCSStarRatingView *storeRatingView;
@property (strong, nonatomic) IBOutlet HCSStarRatingView *reviewRatingView;
@property (strong, nonatomic) IBOutlet UILabel *reviewMessageLabel;
@property (strong, nonatomic) IBOutlet UIButton *likeButton;
@property (strong, nonatomic) IBOutlet UIButton *commentButton;

-(void) uploadCellWithUsernameEventData:(eventClass *)tempEvent;

@end
