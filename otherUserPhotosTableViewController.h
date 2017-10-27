//
//  otherUserPhotosTableViewController.h
//  myProject
//
//  Created by Guy on 10/26/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userClass.h"
#import "imageClass.h"
#import "userPhotosTableViewCell.h"
#import <FirebaseStorageUI/FirebaseStorageUI.h>
@import Firebase;

@interface otherUserPhotosTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet userClass *otherUser;
@property (strong, nonatomic) IBOutlet UILabel *photoCountLabel;

@end
