//
//  userFriendsCell.h
//  myProject
//
//  Created by Guy on 10/17/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"
//#import <TLYShyNavBar/TLYShyNavBarManager.h>


@interface userFriendsCell : SWTableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *friendImageView;
@property (strong, nonatomic) IBOutlet UILabel *userFriendLabel;

@end
