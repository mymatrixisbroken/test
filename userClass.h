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
@property NSString *sortStoreType;
@property NSString *storeOwnerKey;
@property NSData *data;
@property NSString *avatarDataString;

@property NSMutableArray *badges;
@property NSInteger badgeCount;

@property NSMutableArray *checkIns;
@property NSInteger checkInCount;

@property NSMutableArray *friendsEvents;
@property NSMutableArray *activityArray;
@property NSInteger *friendsEventsCount;

@property NSMutableArray *friendsKeys;
@property NSMutableArray *friendsUsers;
@property NSInteger friendsCount;

@property NSMutableArray *reviews;
@property NSInteger reviewsCount;

@property NSMutableArray *imageKeys;
@property NSMutableArray *imageLinks;

@property NSMutableArray *storesVisited;
@property NSMutableArray *storeBookmarks;
@property NSInteger storesVisitedCount;

@property NSMutableArray *strainsTried;
@property NSMutableArray *strainBookmarks;
@property NSInteger strainsTriedCount;

@property NSMutableArray *wishList;
@property NSInteger wishListCount;

@property NSMutableArray *friendRequestsIncomingKeys;
@property NSMutableArray *friendRequestsIncomingUsers;

@property NSMutableArray *friendRequestsOutgoingKeys;

@property double latitude;
@property double longitude;
@property NSString *county;
@property (assign, nonatomic) enum mainNavigationSelected mainNavigationSelected;



enum mainNavigationSelected
{
    newsFeed = 0,
    map = 1,
    searchStuff = 2,
    storesNew = 3,
};


+ (userClass *)sharedInstance;

-(id)createUser:(NSString *)createAccountEmail
       SignedUp:(NSString *)createAccountUsername;

-(id)set:(NSString *)uid
    user:(NSString *)name
   image:(NSString *)url;

-(id)setUserObject:key
    fromDictionary:(NSDictionary *)userDict;

-(id)setUserObject:key
    fromDictionary:(NSDictionary *)userDict
            badges:(NSMutableArray *)array1
          checkIns:(NSMutableArray *)array2
           friends:(NSMutableArray *)array3
           reviews:(NSMutableArray *)array4
     storesVisited:(NSMutableArray *)array5
      strainsTried:(NSMutableArray *)array6
          wishList:(NSMutableArray *)array7
friendRequestsKeys:(NSMutableArray *)array8;


-(void)goToSelectPhotosViewController:(UIViewController *)viewController;
-(void)goToAddStoreController:(UIViewController *)viewController;
-(void)goToNewsFeedViewController:(UIViewController *)viewController;
-(void)goToStrainsStoresViewController:(UIViewController *)viewController;
-(void)goToStrainsViewController:(UIViewController *)viewController;
-(void)goToSearchViewController:(UIViewController *)viewController;
-(void)goToSearchUsersViewController:(UIViewController *)viewController;
-(void)goToUserNotSignedInViewController:(UIViewController *)viewController;
-(void)goToCurrentUserProfileViewController:(UIViewController *)viewController;
-(void)goToLoginViewController:(UIViewController *)viewController;
-(void)goToWriteReviewViewController:(UIViewController *)viewController;
-(void)gotoOptionListViewController:(UIViewController *)viewController;
-(void)gotoOptionListSignedInViewController:(UIViewController *)viewController;
-(void)gotoMapViewViewController:(UIViewController *)viewController;
-(void)goToStrainProfileViewController:(UIViewController *)viewController;
-(void)goToStoreProfileViewController:(UIViewController *)viewController;
-(void)goToPopoverImageViewController:(UIViewController *)viewController;
-(void)goToUserNotFoundViewController:(UIViewController *)viewController;
-(void)gotoCreateAccountViewController:(UIViewController *)viewController;
-(void)presentLoginErrorAlert:(UIViewController *)viewController;
-(void)presentImageNotSelectedAlert:(UIViewController *)viewController;
-(void)presentUsernameInvalidAlert:(UIViewController *)viewController;
-(void)presentEmailTakenAlert:(UIViewController *)viewController;
-(void)presentUsernameTakenAlert:(UIViewController *)viewController;
-(void)presentPasswordInvalidAlert:(UIViewController *)viewController;
-(void)presentTermsNotAgreedAlert:(UIViewController *)viewController;
-(void)presentEmailInvalidAlert:(UIViewController *)viewController;
-(void)presentStrainEditAlert:(UIViewController *)viewController;
@end
