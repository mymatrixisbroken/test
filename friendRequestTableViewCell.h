//
//  friendRequestTableViewCell.h
//  myProject
//
//  Created by Guy on 10/21/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userClass.h"
#import "FirebaseReferenceClass.h"

@interface friendRequestTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *friendRequestImageView;
@property (strong, nonatomic) IBOutlet UILabel *requestUsernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *requestActivityCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *requestPhotosCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *requestBookmarksCountLabel;
@property (strong, nonatomic) IBOutlet UIButton *acceptButton;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong, nonatomic) IBOutlet userClass *otherUser;

@end
