//
//  UserProfileViewController.h
//  myProject
//
//  Created by Guy on 9/11/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userClass.h"
#import "FirebaseReferenceClass.h"
#import <TLYShyNavBar/TLYShyNavBarManager.h>
#import "extensionViewClass.h"
#import "objectsArrayClass.h"
#import <FirebaseStorageUI/FirebaseStorageUI.h>
#import "friendRequestTableViewController.h"
#import "reviewClass.h"
#import "otherUserReviewsViewController.h"
#import "otherUserBookmarksViewController.h"
#import "otherUserFriendsViewController.h"
#import "otherUserPhotosTableViewController.h"
@import Firebase;

@interface UserProfileViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    UIImagePickerController *picker;
    UIImagePickerController *picker2;
    UIImage *image;
}
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *badgesNumber;
@property (strong, nonatomic) IBOutlet UILabel *storesVisitedNumber;
@property (strong, nonatomic) IBOutlet UILabel *strainsTriedNumber;
@property (strong, nonatomic) IBOutlet UILabel *myReviewsNumber;
@property (strong, nonatomic) IBOutlet UILabel *myFriendsNumber;
@property (strong, nonatomic) IBOutlet userClass *otherUser;
@property (copy, nonatomic) NSString *passedString;
@property (strong, nonatomic) IBOutlet UIButton *addFriendButton;


@end
