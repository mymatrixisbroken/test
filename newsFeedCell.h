//
//  newsFeedCell.h
//  myProject
//
//  Created by Guy on 9/14/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Hexadecimal.h"
#import "FirebaseReferenceClass.h"
#import "userClass.h"
#import "eventClass.h"
#import "objectsArrayClass.h"
@import HCSStarRatingView;


@interface newsFeedCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *userImageView;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventLabel;
@property (strong, nonatomic) IBOutlet UIButton *likeButton;
@property (strong, nonatomic) IBOutlet UIButton *commentsButton;

@property (strong, nonatomic) IBOutlet UIImageView *strainImageView;
@property (strong, nonatomic) IBOutlet UILabel *strainNameLabel;
@property (strong, nonatomic) IBOutlet HCSStarRatingView *strainRatingView;

-(void) uploadCellWithUsernameEventData:(eventClass *)tempEvent;
@end
