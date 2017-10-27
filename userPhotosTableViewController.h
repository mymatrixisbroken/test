//
//  userPhotosTableViewController.h
//  myProject
//
//  Created by Guy on 10/25/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userClass.h"
#import "imageClass.h"
#import "userPhotosTableViewCell.h"
#import <FirebaseStorageUI/FirebaseStorageUI.h>
@import Firebase;

@interface userPhotosTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UILabel *photosCountLabel;

@end
