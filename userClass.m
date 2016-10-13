//
//  userClass.m
//  myProject
//
//  Created by Guy on 7/27/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "userClass.h"

userClass *user;

@implementation userClass
@synthesize userKey;
@synthesize email;
@synthesize username;
@synthesize dateJoined;
@synthesize lastSignedIn;
@synthesize accountType;
@synthesize avatarURL;
@synthesize data;
@synthesize badges;
@synthesize badgeCount;

@synthesize checkIns;
@synthesize checkInCount;

@synthesize friendsEvents;
@synthesize friendsEventsCount;

@synthesize friends;
@synthesize friendsCount;

@synthesize reviews;
@synthesize reviewsCount;

@synthesize storesVisited;
@synthesize storesVisitedCount;

@synthesize strainsTried;
@synthesize strainsTriedCount;

@synthesize wishList;
@synthesize wishListCount;

@synthesize latitude;
@synthesize longitude;



+ (userClass *)sharedInstance {
    static dispatch_once_t onceToken;
    static userClass *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[userClass alloc] init];
    });
    return instance;
}


- (id)init {
    self = [super init];
    if (self) {
        self.userKey = @"";
        self.email = @"";
        self.username = @"";
        self.dateJoined = @"";
        self.lastSignedIn = @"";
        self.accountType = @"user";
        self.avatarURL = @"";
        self.data = [[NSData alloc] init];
        self.badges = [[NSMutableArray alloc] init];
        self.badgeCount = 0;
        
        self.checkIns = [[NSMutableArray alloc] init];
        self.checkInCount = 0;
        
        self.friendsEvents = [[NSMutableArray alloc] init];
        self.friendsEventsCount = 0;
        
        self.friends = [[NSMutableArray alloc] init];
        self.friendsCount = 0;
        
        self.reviews = [[NSMutableArray alloc] init];
        self.reviewsCount = 0;
        
        self.storesVisited = [[NSMutableArray alloc] init];
        self.storesVisitedCount = 0;
        
        self.strainsTried = [[NSMutableArray alloc] init];
        self.strainsTriedCount = 0;
        
        self.wishList = [[NSMutableArray alloc] init];
        self.wishListCount = 0;
        
        self.latitude = 0;
        self.longitude = 0;
    }
    return self;
}

-(id)createUser:(NSString *)createAccountEmail SignedUp:(NSString *)createAccountUsername{
    self.email = createAccountEmail;
    self.username = createAccountUsername;
    
    return self;
}

-(id)set:(NSString *)uid
    user:(NSString *)name
   image:(NSString *)url{
    self.userKey = uid;
    self.username = name;
    self.avatarURL = url;
    
    return self;
}


-(id)setUserObject:key
    fromDictionary:(NSDictionary *)userDict
            badges:(NSMutableArray *)array1
          checkIns:(NSMutableArray *)array2
           friends:(NSMutableArray *)array3
           reviews:(NSMutableArray *)array4
     storesVisited:(NSMutableArray *)array5
      strainsTried:(NSMutableArray *)array6
          wishList:(NSMutableArray *)array7{
    
    self.userKey = key;
    self.email = [userDict valueForKey:@"email"];
    self.username = [userDict valueForKey:@"username"];
    self.dateJoined = [userDict valueForKey:@"dateJoined"];
    self.lastSignedIn = [userDict valueForKey:@"lastSignedIn"];
    self.accountType = [userDict valueForKey:@"accountType"];
    self.avatarURL = [userDict valueForKey:@"avatarURL"];
    
    self.badges = array1;
    self.badgeCount = 0;
    
    self.checkIns = array2;
    self.checkInCount = 0;
    
    self.friendsEventsCount = 0;
    
    self.friends = array3;
    self.friendsCount = 0;
    
    self.reviews = array4;
    self.reviewsCount = 0;
    
    self.storesVisited = array5;
    self.storesVisitedCount = 0;
    
    self.strainsTried = array6;
    self.strainsTriedCount = 0;
    
    self.wishList = array7;
    self.wishListCount = 0;
    
    return self;
}

-(void)goToNewsFeedViewController:(UIViewController *)viewController{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"News Feed Navigation SB ID"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [viewController presentViewController:vc animated:YES completion:NULL];
}

-(void)goToStrainsStoresViewController:(UIViewController *)viewController{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"List View Controller  SB ID"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [viewController presentViewController:vc animated:YES completion:NULL];
}

-(void)goToSearchUsersViewController:(UIViewController *)viewController{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Friends Navigation SB ID"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [viewController presentViewController:vc animated:YES completion:NULL];
}

-(void)goToUserNotSignedInViewController:(UIViewController *)viewController{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"User Not Found SB ID"];
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [viewController presentViewController:vc animated:YES completion:NULL];
}

-(void)goToCurrentUserProfileViewController:(UIViewController *)viewController{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"User Profile Navigation SB ID"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [viewController presentViewController:vc animated:YES completion:NULL];
}

-(void)goToLoginViewController:(UIViewController *)viewController{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Login View SB ID"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [viewController presentViewController:vc animated:YES completion:NULL];
}

-(void)goToWriteReviewViewController:(UIViewController *)viewController{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Write Review SB ID"];
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [viewController presentViewController:vc animated:YES completion:NULL];
}

-(void)gotoOptionListViewController:(UIViewController *)viewController{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Option list SB ID"];
    //    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [viewController presentViewController:vc animated:YES completion:NULL];
}

-(void)gotoMapViewViewController:(UIViewController *)viewController{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Map view SB ID"];
    //    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [viewController presentViewController:vc animated:YES completion:NULL];
}



-(void)goToStrainProfileViewController:(UIViewController *)viewController{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Strain Profile SB ID"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [viewController presentViewController:vc animated:YES completion:NULL];
}

-(void)goToStoreProfileViewController:(UIViewController *)viewController{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Store Profile SB ID"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [viewController presentViewController:vc animated:YES completion:NULL];
}

-(void)goToPopoverImageViewController:(UIViewController *)viewController{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Popover Image SB ID"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [viewController presentViewController:vc animated:YES completion:NULL];

}

-(void)goToUserNotFoundViewController:(UIViewController *)viewController{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"User Not Found SB ID"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [viewController presentViewController:vc animated:YES completion:NULL];
}
-(void)gotoCreateAccountViewController:(UIViewController *)viewController{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Create Account SB ID"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [viewController presentViewController:vc animated:YES completion:NULL];
}


-(void)presentLoginErrorAlert:(UIViewController *)viewController{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Error Login"
                                          message:@"Username or password is incorrect."
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {}];
    
    [alertController addAction:okAction];
    [viewController presentViewController:alertController animated:YES completion:nil];
}

-(void)presentImageNotSelectedAlert:(UIViewController *)viewController{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Uh-oh!"
                                          message:@"Image not selected."
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {}];
    
    [alertController addAction:okAction];
    [viewController presentViewController:alertController animated:YES completion:nil];
}

-(void)presentUsernameInvalidAlert:(UIViewController *)viewController{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Invalid username"
                                          message:nil
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {}];
    
    [alertController addAction:okAction];
    [viewController presentViewController:alertController animated:YES completion:nil];
}

-(void)presentUsernameTakenAlert:(UIViewController *)viewController{    UIAlertController *alertController = [UIAlertController
                                                                                                              alertControllerWithTitle:@"Username taken"
                                                                                                              message:nil
                                                                                                              preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {}];
    
    [alertController addAction:okAction];
    [viewController presentViewController:alertController animated:YES completion:nil];
}

-(void)presentPasswordInvalidAlert:(UIViewController *)viewController{    UIAlertController *alertController = [UIAlertController
                                                                                                                alertControllerWithTitle:@"Invalid password"
                                                                                                                message:@"Please use minimum 5 characters"
                                                                                                                preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {}];
    
    [alertController addAction:okAction];
    [viewController presentViewController:alertController animated:YES completion:nil];
}

-(void)presentEmailInvalidAlert:(UIViewController *)viewController{    UIAlertController *alertController = [UIAlertController
                                                                                                             alertControllerWithTitle:@"Invalid email"
                                                                                                             message:@"Please use format email@domain.com"
                                                                                                             preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {}];
    
    [alertController addAction:okAction];
    [viewController presentViewController:alertController animated:YES completion:nil];
}
-(void)presentStrainEditAlert:(UIViewController *)viewController{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Menu" message:@"Select Option" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Edit Strain" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Strain Edit SB ID"];
        vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [viewController presentViewController:vc animated:YES completion:NULL];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }]];
    
    [viewController presentViewController:actionSheet animated:YES completion:nil];
}
@end
