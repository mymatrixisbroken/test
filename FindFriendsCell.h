//
//  FindFriendsCell.h
//  myProject
//
//  Created by Guy on 9/16/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirebaseReferenceClass.h"
#import "findFriendClass.h"
#import "userClass.h"

@interface FindFriendsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageview;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UIButton *addButton;

-(void) uploadCell:(NSString *)key
      withUsername:(NSString *)username
              data:(NSData *)data;
@end