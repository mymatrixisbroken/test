//
//  userFriendRequestCell.h
//  myProject
//
//  Created by Guy on 10/18/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userClass.h"
#import "firebaseReferenceClass.h"
#import "findFriendClass.h"
@import Firebase;

@interface userFriendRequestCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *requestorImageView;
@property (strong, nonatomic) IBOutlet UILabel *requestorNameLabel;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong, nonatomic) IBOutlet UIButton *confirmButton;

//-(void) uploadCell:(NSString *)key
//      withUsername:(NSString *)username
//              data:(NSData *)data;

@end
