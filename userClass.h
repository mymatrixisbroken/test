//
//  userClass.h
//  myProject
//
//  Created by Guy on 7/27/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class userClass;
extern userClass *user;

@interface userClass : NSObject
@property NSString *userKey;
@property NSString *email;
@property NSString *username;
@property NSString *dateJoined;
@property NSString *lastSignedIn;
@property NSString *accountType;
@property NSString *avatarURL;
@property NSData *data;

@property NSMutableArray *badges;
@property NSInteger badgeCount;

@property NSMutableArray *checkIns;
@property NSInteger checkInCount;

@property NSMutableArray *friendsEvents;
@property NSInteger *friendsEventsCount;

@property NSMutableArray *friends;
@property NSInteger friendsCount;

@property NSMutableArray *reviews;
@property NSInteger reviewsCount;

@property NSMutableArray *storesVisited;
@property NSInteger storesVisitedCount;

@property NSMutableArray *strainsTried;
@property NSInteger strainsTriedCount;

@property NSMutableArray *wishList;
@property NSInteger wishListCount;




+ (userClass *)sharedInstance;
-(id)createUser:(NSString *)createAccountEmail SignedUp:(NSString *)createAccountUsername;
-(id)setUserObject:key
    fromDictionary:(NSDictionary *)userDict
            badges:(NSMutableArray *)array1
          checkIns:(NSMutableArray *)array2
           friends:(NSMutableArray *)array3
           reviews:(NSMutableArray *)array4
     storesVisited:(NSMutableArray *)array5
      strainsTried:(NSMutableArray *)array6
          wishList:(NSMutableArray *)array7;

-(void)goToNewsFeedViewController:(UIViewController *)viewController;
-(void)goToStrainsStoresViewController:(UIViewController *)viewController;
-(void)goToUserNotSignedInViewController:(UIViewController *)viewController;
-(void)goToCurrentUserProfileViewController:(UIViewController *)viewController;
-(void)goToLoginViewController:(UIViewController *)viewController;
-(void)goToWriteReviewViewController:(UIViewController *)viewController;
-(void)gotoOptionListViewController:(UIViewController *)viewController;
-(void)goToStrainProfileViewController:(UIViewController *)viewController;
-(void)goToUserNotFoundViewController:(UIViewController *)viewController;
-(void)gotoCreateAccountViewController:(UIViewController *)viewController;
-(void)presentLoginErrorAlert:(UIViewController *)viewController;
-(void)presentImageNotSelectedAlert:(UIViewController *)viewController;
-(void)presentUsernameInvalidAlert:(UIViewController *)viewController;
-(void)presentUsernameTakenAlert:(UIViewController *)viewController;
-(void)presentPasswordInvalidAlert:(UIViewController *)viewController;
-(void)presentEmailInvalidAlert:(UIViewController *)viewController;
-(void)presentStrainEditAlert:(UIViewController *)viewController;
@end
