//
//  UserProfileViewController.m
//  myProject
//
//  Created by Guy on 9/11/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import "UserProfileViewController.h"

@interface UserProfileViewController ()

@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(screenSwipedLeft)];
    swipeLeft.numberOfTouchesRequired = 1;
    swipeLeft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];

    
    [self loadNavController];
    [self loadUserFromFirebaseDatabase];
    self.scrollView.contentSize = self.view.bounds.size;
    self.shyNavBarManager.scrollView = self.scrollView;
    //    [self loadExtView];
}

-(void) screenSwipedLeft{
    FIRUser *currentUser = [FIRAuth auth].currentUser;
    if(currentUser.anonymous){
        [user gotoOptionListViewController:self];
    } else {
        [user gotoOptionListSignedInViewController:self];
    }
}

- (void) loadUserFromFirebaseDatabase {
    _otherUser = [[userClass alloc] init];
    NSLog(@"other user name is %@",_passedString);
    _otherUser.username = _passedString;
    _usernameLabel.text = _otherUser.username;
    
    NSString *lowerString = [_otherUser.username lowercaseString];
    
    
    FIRDatabaseQuery *queryLowerUserName = [[[firebaseRef.ref child:@"usernames"] queryOrderedByChild:@"lowerUsername"] queryEqualToValue:lowerString];
    
    [queryLowerUserName observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            NSLog(@"snapshot is %@", snapshot.value);
            if ([[snapshot.value allKeys] count]== 1) {                         //check one email found
                _otherUser.userKey = [[snapshot.value allKeys] objectAtIndex:0];
                
//                [self getUsername];
                [self getDateJoined];
                [self getLastSignedIn];
                [self getAccountType];
                [self getUserImages];
                [self getUserBadges];
                [self getCheckIns];
                [self getFriends];
                [self getStoresVisited];
                [self getStrainsTried];
                [self getStoreBookMarks];
                [self getStrainBookMarks];
                [self getFriendRequestInbound];
                [self getFriendRequestOutbound];
                [self getImagesUploadedByUser];
                [self getReviewKeys];
//                [self loadReviewsFromFirebase];
                [self setFriendButton];
            }
        }
    }];
    
}

//- (void) getUsername{
//    [[[firebaseRef.ref child:@"usernames"] child:_otherUser.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
//        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
//            _otherUser.username = [snapshot.value valueForKey:@"username"];
//        }
//    }];
//}

- (void) getDateJoined{
    [[[firebaseRef.ref child:@"dateJoined"] child:_otherUser.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            _otherUser.dateJoined = [snapshot.value valueForKey:@"dateJoined"];
        }
    }];
}

- (void) getLastSignedIn{
    [[[firebaseRef.ref child:@"dateLastSignedIn"] child:_otherUser.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            _otherUser.lastSignedIn = [snapshot.value valueForKey:@"dateLastSignedIn"];
        }
    }];
}

- (void) getAccountType{
    [[[firebaseRef.ref child:@"accountType"] child:_otherUser.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            _otherUser.accountType = [snapshot.value valueForKey:@"accountType"];
        }
    }];
}

- (void) getUserImages{
    [[[[firebaseRef.ref child:@"images"] child:@"users"] child:_otherUser.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            for (id key in snapshot.value) {
                [_otherUser.imageKeys addObject:key];
                [_otherUser.imageLinks addObject:[snapshot.value valueForKey:key]];
            }
            [self loadProfilePicture];
        }
    }];
}

- (void) getUserBadges{
    [[[firebaseRef.ref child:@"badges"] child:_otherUser.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            for (id key in snapshot.value) {
                NSString *value = [snapshot.value valueForKey:key];
                if ([value isEqualToString:@"true"]) {
                    [_otherUser.badges addObject:key];
                }
            }
            _badgesNumber.text = [NSString stringWithFormat:@"%lu", (unsigned long)_otherUser.badges.count];
        }
    }];
}

- (void) getCheckIns{
    [[[firebaseRef.ref child:@"checkIns"] child:_otherUser.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            for (id key in snapshot.value) {
                [_otherUser.checkIns addObject:key];
            }
        }
    }];
}

- (void) getFriends{
    [[[firebaseRef.ref child:@"friends"] child:_otherUser.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            for (id key in snapshot.value) {
                [_otherUser.friendsKeys addObject:key];
            }
            _myFriendsNumber.text = [NSString stringWithFormat:@"%lu", (unsigned long)_otherUser.friendsKeys.count];
        }
    }];
}

- (void) getStoresVisited{
    [[[firebaseRef.ref child:@"storesVisited"] child:_otherUser.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            for (id key in snapshot.value) {
                [_otherUser.storesVisited addObject:key];
            }
            _storesVisitedNumber.text = [NSString stringWithFormat:@"%lu", (unsigned long)_otherUser.storesVisited.count];
        }
    }];
}

- (void) getStrainsTried{
    [[[firebaseRef.ref child:@"strainsTried"] child:_otherUser.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            for (id key in snapshot.value) {
                [_otherUser.strainsTried addObject:key];
            }
            _strainsTriedNumber.text = [NSString stringWithFormat:@"%lu", (unsigned long)_otherUser.friendRequestsIncomingKeys.count];
        }
    }];
}

- (void) getStoreBookMarks{
    [[[[firebaseRef.ref  child:@"bookmarks"] child:_otherUser.userKey] child:@"stores"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            for (id key in snapshot.value) {
                [_otherUser.storeBookmarks addObject:key];
            }
            _badgesNumber.text = [NSString stringWithFormat:@"%lu", (unsigned long)_otherUser.storeBookmarks.count];
        }
    }];
}

- (void) getStrainBookMarks{
    [[[[firebaseRef.ref  child:@"bookmarks"] child:_otherUser.userKey] child:@"strains"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            for (id key in snapshot.value) {
                [_otherUser.strainBookmarks addObject:key];
            }
        }
    }];
}

- (void) getFriendRequestInbound{
    [[[firebaseRef.ref  child:@"friendRequestInbound"] child:_otherUser.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            for (id key in snapshot.value) {
                [_otherUser.friendRequestsIncomingKeys addObject:key];
            }
        }
    }];
}

- (void) getFriendRequestOutbound{
    [[[firebaseRef.ref  child:@"friendRequestOutbound"] child:_otherUser.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            for (id key in snapshot.value) {
                [_otherUser.friendRequestsOutgoingKeys addObject:key];
            }
        }
    }];
}

-(void) getImagesUploadedByUser{
    [[[firebaseRef.ref child:@"userAddedImage"] child:_otherUser.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            _otherUser.imagesUploaded = [[NSMutableArray alloc] init];
            NSArray *imageKeys = [[NSArray alloc] init];
            imageKeys = [snapshot.value allKeys];
            
            for(NSString *key in imageKeys){
                imageClass *image = [[imageClass alloc] init];
                image.imageKey = key;
                image.imageType = [snapshot.value valueForKey:key];
                [self getObjectKeyForImage:image];
            }
        }
    }];
}

-(void) getObjectKeyForImage:(imageClass *) image{
    [[[firebaseRef.ref child:@"imageForObject"] child:image.imageKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            image.objectKey = [[snapshot.value allKeys] objectAtIndex:0];
            [_otherUser.imagesUploaded addObject:image];
        }
        _strainsTriedNumber.text = [NSString stringWithFormat:@"%lu", (unsigned long)_otherUser.imagesUploaded.count];
    }];
}


-(void) getReviewKeys{
    [[[firebaseRef.ref child:@"reviewUserWroteReview"] child:_otherUser.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            _otherUser.reviews = [[NSMutableArray alloc] init];
            NSArray *reviewKeys = [[NSArray alloc] init];
            reviewKeys = [snapshot.value allKeys];
            
            for(NSString *key in reviewKeys){
                reviewClassNew *review = [[reviewClassNew alloc] init];
                review.reviewKey = key;
                [_otherUser.reviews addObject:review];
            }
            _myReviewsNumber.text = [NSString stringWithFormat:@"%lu", (unsigned long)_otherUser.reviews.count];
            
            [self getReviewObject];
            [self getReviewMessage];
            [self getReviewRating];
        }
        [self.view setNeedsDisplay];
    }];
}

- (void) getReviewObject {
    NSLog(@" key  is %lu", _otherUser.reviews.count);
    
    for (int j = 0; j < _otherUser.reviews.count; j++){
        reviewClassNew *review = [[reviewClassNew alloc] init];
        review = [_otherUser.reviews objectAtIndex:j];
        NSLog(@"review key  is %@", review.reviewKey);
        
        
        [[[firebaseRef.ref child:@"reviewAboutObject"] child:review.reviewKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            if ([NSNull null] != snapshot.value){                                   //check snapshot is null
                review.objectKey = [[snapshot.value allKeys] objectAtIndex:0];
                review.objectType = [[snapshot.value allValues] objectAtIndex:0];
                
                [_otherUser.reviews replaceObjectAtIndex:j withObject:review];
                
                if ([review.objectType isEqualToString:@"store"]) {
                    [self getStoreName: j];
                    [self getStoreRatingScore: j];
                    [self getStoreImage: j];
                }
            }
        }];
    }
}

- (void) getStoreName:(NSInteger) i {
    reviewClassNew *review = [[reviewClassNew alloc] init];
    review = [_otherUser.reviews objectAtIndex:i];
    
    [[[firebaseRef.ref child:@"storeNames"] child:review.objectKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            review.objectName = [snapshot.value valueForKey:@"name"];
            [_otherUser.reviews replaceObjectAtIndex:i withObject:review];
            
        }
    }];
}

- (void) getStoreRatingScore:(NSInteger) i {
    reviewClassNew *review = [[reviewClassNew alloc] init];
    review = [_otherUser.reviews objectAtIndex:i];
    
    [[[[firebaseRef.ref child:@"starRating"] child:@"stores"] child:review.objectKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            NSArray *scores = [[NSArray alloc] init];
            scores = [snapshot.value allValues];
            review.objectReviewCount = [scores count];
            
            if ([scores count] > 0) {
                float ratingFloat = [review.objectRating floatValue];
                for (id i in scores){
                    ratingFloat = ratingFloat + [i floatValue];
                }
                review.objectRating = [NSString stringWithFormat:@"%lf",ratingFloat];
            }
            [_otherUser.reviews replaceObjectAtIndex:i withObject:review];
        }
    }];
}

- (void) getStoreImage:(NSInteger) i {
    reviewClassNew *review = [[reviewClassNew alloc] init];
    review = [_otherUser.reviews objectAtIndex:i];
    
    [[[[firebaseRef.ref child:@"images"] child:@"stores"] child:review.objectKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            for (id key in snapshot.value) {
                [review.objectImageLink addObject:[snapshot.value valueForKey:key]];
            }
            [_otherUser.reviews replaceObjectAtIndex:i withObject:review];
        }
    }];
}



- (void) getReviewMessage {
    NSLog(@"review key  is %lu", _otherUser.reviews.count);
    
    for (int j = 0; j < _otherUser.reviews.count; j++){
        reviewClassNew *review = [[reviewClassNew alloc] init];
        review = [_otherUser.reviews objectAtIndex:j];
        NSLog(@"review key  is %@", review.reviewKey);
        
        [[[firebaseRef.ref child:@"reviewMessage"] child:review.reviewKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            if ([NSNull null] != snapshot.value){                                   //check snapshot is null
                review.message = [[snapshot.value allValues] objectAtIndex:0];
                
                [_otherUser.reviews replaceObjectAtIndex:j withObject:review];
            }
        }];
    }
}

- (void) getReviewRating {
    NSLog(@"review key  is %lu", _otherUser.reviews.count);
    
    for (int j = 0; j < _otherUser.reviews.count; j++){
        reviewClassNew *review = [[reviewClassNew alloc] init];
        review = [_otherUser.reviews objectAtIndex:j];
        NSLog(@"review key  is %@", review.reviewKey);
        
        
        [[[firebaseRef.ref child:@"reviewRating"] child:review.reviewKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            if ([NSNull null] != snapshot.value){                                   //check snapshot is null
                review.rating = [[snapshot.value allValues] objectAtIndex:0];
                
                [_otherUser.reviews replaceObjectAtIndex:j withObject:review];
            }
        }];
    }
}


//-(void)loadReviewsFromFirebase{
//    //    FIRDatabaseQuery *reviewQuery = [[ queryOrderedByChild:@"reviewData"] queryEqualToValue:_otherUser.userKey];
//
//    [[[firebaseRef.ref child:@"reviewData"] child:_otherUser.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
//        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
//            for (id key in snapshot.value) {
//                reviewClass *tempReview = [[reviewClass alloc] init];
//                tempReview.reviewKey = key;
//
//                NSDictionary *dictionary = [[NSDictionary alloc] init];
//                dictionary = [snapshot.value valueForKey:tempReview.reviewKey];
//                tempReview.message = [dictionary valueForKey:@"message"];
//                tempReview.objectImageURL = [dictionary valueForKey:@"objectImageKey"];
//                tempReview.objectKey = [dictionary valueForKey:@"objectKey"];
//                tempReview.objectName = [dictionary valueForKey:@"objectName"];
//                tempReview.objectType = [dictionary valueForKey:@"objectType"];
//                tempReview.userKey = [dictionary valueForKey:@"userKey"];
//                tempReview.rating = [dictionary valueForKey:@"rating"];
//
//                [_otherUser.reviews addObject:tempReview];
//            }
//            _myReviewsNumber.text = [NSString stringWithFormat:@"%lu", (unsigned long)_otherUser.reviews.count];
//        }
//        [self.view setNeedsDisplay];
//    }];
//
//}

- (void) setFriendButton{
    if ([user.friendsKeys indexOfObject:_otherUser.userKey] != NSNotFound){
        [_addFriendButton setBackgroundImage:[UIImage imageNamed:@"buttonGreenBackground"] forState:UIControlStateNormal];
        [_addFriendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addFriendButton setTitle:@"Friends" forState:UIControlStateNormal];
    }
    else if ([user.friendRequestsOutgoingKeys indexOfObject:_otherUser.userKey] != NSNotFound){
        [_addFriendButton setBackgroundImage:[UIImage imageNamed:@"buttonGreenBackground"] forState:UIControlStateNormal];
        [_addFriendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addFriendButton setTitle:@"Pending" forState:UIControlStateNormal];
    }
    else if ([user.friendRequestsIncomingKeys indexOfObject:_otherUser.userKey] != NSNotFound){
        [_addFriendButton setBackgroundImage:[UIImage imageNamed:@"buttonGreenBackground"] forState:UIControlStateNormal];
        [_addFriendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addFriendButton setTitle:@"View Request" forState:UIControlStateNormal];
        _addFriendButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    }
}

//- (void) loadExtView{
//    extensionViewClass *extView = [[extensionViewClass alloc] init];
//    [extView setView:CGRectGetWidth(self.view.bounds)];
//    [extView addButtons:CGRectGetWidth(self.view.bounds)];
//    [extView.firstButton addTarget:self action:@selector(storeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [extView.secondButton addTarget:self action:@selector(strainButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [extView.thirdButton addTarget:self action:@selector(newsFeedButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [extView.fourthButton addTarget:self action:@selector(userProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    extView.fourthButton.highlighted = YES;
//    [self.shyNavBarManager setExtensionView:extView];
//    [self.shyNavBarManager setStickyExtensionView:YES];
//}

//-(IBAction)storeButtonPressed:(UIButton*)btn {
//    objectsArray.strainOrStore = 1;
//    [user goToStrainsStoresViewController:self];
//}
//
//-(IBAction)strainButtonPressed:(UIButton*)btn {
//    objectsArray.strainOrStore = 0;
//    [user goToStrainsViewController:self];
//}
//
//-(IBAction)newsFeedButtonPressed:(UIButton*)btn {
//    [user goToNewsFeedViewController:self];
//}
//
//-(IBAction)userProfileButtonPressed:(UIButton*)btn {
//    FIRUser *youser = [FIRAuth auth].currentUser;
//    if(yo_otherUser.anonymous){
//        [user goToUserNotSignedInViewController:self];
//    }
//    else{
//        [user goToCurrentUserProfileViewController:self];
//    }
//}


-(void) loadProfilePicture{
    //    self.imageView.image = [UIImage imageWithData:_otherUser.data];
    
    FIRStorage *storage = [FIRStorage storage];
    FIRStorageReference *storageRef = [storage reference];
    
    if ([_otherUser.imageLinks count] > 0){                                      //check images array is null
        NSLog(@"image link is %@", [_otherUser.imageLinks objectAtIndex:0]);
        FIRStorageReference *spaceRef = [[[storageRef child:@"users"] child:_otherUser.userKey] child:[_otherUser.imageLinks objectAtIndex:0]];
        NSLog(@"ref is %@", spaceRef);
        
        UIImage *placeHolder = [[UIImage alloc] init];
        [_imageView sd_setImageWithStorageReference:spaceRef placeholderImage:placeHolder];
    }
    
    //    [spaceRef dataWithMaxSize:1 * 1024 * 1024 completion:^(NSData *data, NSError *error){
    //        if (error != nil) {
    //            NSLog(@"Uh-oh, an error occurred! %@", error);
    //        }
    //        else {
    //            tempImage.data = data;
    
}

- (IBAction)signOutButtonTapped:(UIButton *)sender {
    NSError *error;
    [user init];
    [[FIRAuth auth] signOut:&error];
    if (!error) {
        // Sign-out succeeded
        [[FIRAuth auth] signInAnonymouslyWithCompletion:^(FIRUser * _Nullable youser, NSError * _Nullable error) {
            if (error != nil) {
                // Uh-oh, an error occurred!
                NSLog(@"Anonymous Firebase User is NOT signed in..");
                NSLog(@"%@", error.localizedDescription);
            }
            else {
                //Assign current Firebase user to a variable called user
                if([FIRAuth auth].currentUser.anonymous){
                    [user goToLoginViewController:self];
                }
            }
        }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tappedAddFriend:(UIButton *)sender {
    FIRUser *youser = [FIRAuth auth].currentUser;
    if (youser.email == nil) {
        [user goToUserNotSignedInViewController:self];
    }
    else{
        if ([user.friendsKeys indexOfObject:_otherUser.userKey] != NSNotFound){
            UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Are you sure you want to delete friend?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                // Cancel button tappped.
            }]];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:@"Delete friend" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                [[[[firebaseRef.ref child:@"friends"] child:user.userKey] child:_otherUser.userKey] removeValue];
                [[[[firebaseRef.ref child:@"friends"] child:_otherUser.userKey] child:user.userKey] removeValue];

//                NSInteger index = [user.friendsKeys indexOfObject:_otherUser.userKey];
//                [user.friendsKeys removeObjectAtIndex:index];
                
                [_addFriendButton setBackgroundImage:nil forState:UIControlStateNormal];
                [_addFriendButton setTitleColor:[UIColor colorWithRed:8.0/255.0 green:197.0/255.0 blue:103.0/255.0 alpha:1.0] forState:UIControlStateNormal];
                [_addFriendButton setTitle:@"Add Friend" forState:UIControlStateNormal];
                
                [user.friendsKeys removeObject:_otherUser.userKey];
            }]];
            
            [self presentViewController:actionSheet animated:YES completion:nil];             // Present action sheet.

        }
        else if ([user.friendRequestsOutgoingKeys indexOfObject:_otherUser.userKey] != NSNotFound){
            [[[[firebaseRef.ref child:@"friendRequestOutbound"] child:user.userKey] child:_otherUser.userKey] removeValue];
            [[[[firebaseRef.ref child:@"friendRequestInbound"] child:_otherUser.userKey] child:user.userKey] removeValue];
            
            //            NSInteger index = [user.friendRequestsOutgoingKeys indexOfObject:_otherUser.userKey];
            //            [user.friendRequestsOutgoingKeys removeObjectAtIndex:index];
            
            [_addFriendButton setBackgroundImage:nil forState:UIControlStateNormal];
            [_addFriendButton setTitleColor:[UIColor colorWithRed:8.0/255.0 green:197.0/255.0 blue:103.0/255.0 alpha:1.0] forState:UIControlStateNormal];
            [_addFriendButton setTitle:@"Add Friend" forState:UIControlStateNormal];
            
            [user.friendRequestsOutgoingKeys removeObject:_otherUser.userKey];
        }
        else if ([user.friendRequestsIncomingKeys indexOfObject:_otherUser.userKey] != NSNotFound){
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            friendRequestTableViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Friend Request SB ID"];
            [self presentViewController:vc animated:YES completion:^{}];
        }
        else {
            [[[[firebaseRef.ref child:@"friendRequestOutbound"] child:user.userKey] child:_otherUser.userKey] setValue:@"test"];
            [[[[firebaseRef.ref child:@"friendRequestInbound"] child:_otherUser.userKey] child:user.userKey] setValue:@"test"];
            
            if ([user.friendRequestsOutgoingKeys indexOfObject:_otherUser.userKey] == NSNotFound){   //check array doesn't have other.userkey
                [user.friendRequestsOutgoingKeys addObject:_otherUser.userKey];
            }
            
            [_addFriendButton setBackgroundImage:[UIImage imageNamed:@"buttonGreenBackground"] forState:UIControlStateNormal];
            [_addFriendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_addFriendButton setTitle:@"Pending" forState:UIControlStateNormal];
        }
    }
}

- (IBAction)tappedImageView:(UITapGestureRecognizer *)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select Image" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        // Cancel button tappped.
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        picker2 = [[UIImagePickerController alloc] init];
        self->picker2.delegate = self;
        [picker2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentViewController:picker2 animated:YES completion:NULL];
        // Distructive button tapped.[self dismissViewControllerAnimated:YES completion:^{}];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        picker = [[UIImagePickerController alloc] init];
        self->picker.delegate = self;
        [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:picker animated:YES completion:NULL];
        // OK button tapped. [self dismissViewControllerAnimated:YES completion:^{}];
    }]];
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.imageView.contentMode  = UIViewContentModeScaleAspectFit;
    [self.imageView setImage:image];
    
    
    CGSize size = CGSizeMake(500, 500);
    UIImage *sizedImage = [[self class] imageWithImage:self.imageView.image scaledToSize:size];
    NSData *encodedString = UIImagePNGRepresentation(sizedImage);
    NSLog(@"image encoded= %@", encodedString);
    
    NSURL *theURL = [NSURL URLWithString:@"https://api.imgur.com/3/image"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0f];
    
    //Specify method of request(Get or Post)
    [theRequest setHTTPMethod:@"POST"];
    
    //Pass some default parameter(like content-type etc.)
    [theRequest setValue:@"Client-ID bceb6364428afba" forHTTPHeaderField:@"Authorization"];
    [theRequest setHTTPBody:encodedString];
    NSURLResponse *theResponse = NULL;
    NSError *theError = NULL;
    NSData *theResponseData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&theResponse error:&theError];
    
    
    
    NSDictionary *dataDictionaryResponse = [NSJSONSerialization JSONObjectWithData:theResponseData options:0 error:&theError];
    NSLog(@"url to send request= %@",theURL);
    NSLog(@"%@",dataDictionaryResponse);
    
    
    NSDictionary *output = [dataDictionaryResponse valueForKey:@"data"];
    
    [[[firebaseRef.usersRef child:_otherUser.userKey] child:@"avatarData"] setValue:_otherUser.avatarDataString];
    
    
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (IBAction)tappedBadges:(UITapGestureRecognizer *)sender {
    //do something
}
- (IBAction)tappedFriends:(UITapGestureRecognizer *)sender {
    //do something
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    otherUserFriendsViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Other user friends VC SB ID"];
    vc.otherUser2 = [[userClass alloc] init];
    vc.otherUser2 = _otherUser;
    [self.navigationController pushViewController:vc animated:false];
}
- (IBAction)tappedMyReviews:(UITapGestureRecognizer *)sender {
    //do something
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    otherUserReviewsViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Other user reviews VC SB ID"];
    vc.otherUser = [[userClass alloc] init];
    vc.otherUser = _otherUser;
    [self.navigationController pushViewController:vc animated:false];
}
- (IBAction)tappedBookmarks:(UITapGestureRecognizer *)sender {
    //do something
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    otherUserBookmarksViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Other user bookmarks VC SB ID"];
    vc.otherUser = [[userClass alloc] init];
    vc.otherUser = _otherUser;
    [self.navigationController pushViewController:vc animated:false];
}
- (IBAction)tappedPhotos:(UITapGestureRecognizer *)sender {
    //do something
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    otherUserPhotosTableViewController *vc = [sb instantiateViewControllerWithIdentifier:@"Other user photos VC SB ID"];
    vc.otherUser = [[userClass alloc] init];
    vc.otherUser = _otherUser;
    [self.navigationController pushViewController:vc animated:false];
    
}
- (IBAction)tappedStoresVisited:(UITapGestureRecognizer *)sender {
    //do something
}


- (void) loadNavController{
    
    UIButton *btn1 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0,0,25,25);
    [btn1 setBackgroundImage:[UIImage imageNamed:@"newsFeedWhiteIcon"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(newsFeedButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonOne = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    
    
    UIButton *btn2 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0,0,25,25);
    [btn2 setBackgroundImage:[UIImage imageNamed:@"mapWhiteIcon"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(strainButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonTwo = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    
    
    UIButton *btn3 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(0,0,25,25);
    [btn3 setBackgroundImage:[UIImage imageNamed:@"searchWhiteIcon"] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(searchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonThree = [[UIBarButtonItem alloc] initWithCustomView:btn3];
    
    
    UIButton *btn4 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(0,0,25,25);
    [btn4 setBackgroundImage:[UIImage imageNamed:@"storesWhiteIcon"] forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(storeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonFour = [[UIBarButtonItem alloc] initWithCustomView:btn4];
    
    
    UIButton *btn5 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn5.frame = CGRectMake(0,0,25,25);
    [btn5 setBackgroundImage:[UIImage imageNamed:@"hamburgerWhiteIcon"] forState:UIControlStateNormal];
    [btn5 addTarget:self action:@selector(barButtonCustomPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonFive = [[UIBarButtonItem alloc] initWithCustomView:btn5];
    
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    space.width = 55;
    
    NSArray *buttons = @[buttonOne, space, buttonTwo, space, buttonThree, space, buttonFour, space, buttonFive];
    
    self.navigationController.navigationBar.topItem.title = nil;
    self.navigationController.navigationBar.topItem.leftBarButtonItems = buttons;
}

-(IBAction)newsFeedButtonPressed:(UIButton*)btn {
    user.mainNavigationSelected = 0;
    [user goToNewsFeedViewController:self];
}

-(IBAction)strainButtonPressed:(UIButton*)btn {
    [user gotoMapViewViewController:self];
    
    //    user.mainNavigationSelected = 1;
    //    objectsArray.filterSelected = 10;
    //    objectsArray.strainOrStore = 0;
    //    [user goToStrainsViewController:self];
}

-(IBAction)searchButtonPressed:(UIButton*)btn {
    user.mainNavigationSelected = 2;
    [user goToSearchViewController:self];
}


-(IBAction)userProfileButtonPressed:(UIButton*)btn {
    user.mainNavigationSelected = 2;
    FIRUser *youser = [FIRAuth auth].currentUser;
    if(youser.anonymous){
        [user goToUserNotSignedInViewController:self];
    }
    else{
        [user goToCurrentUserProfileViewController:self];
    }
}

-(IBAction)storeButtonPressed:(UIButton*)btn {
    user.mainNavigationSelected = 3;
    objectsArray.filterSelected = 10;
    objectsArray.strainOrStore = 1;
    [user goToStrainsStoresViewController:self];
}


-(IBAction)barButtonCustomPressed:(UIBarButtonItem*)btn
{
    FIRUser *currentUser = [FIRAuth auth].currentUser;
    if(currentUser.anonymous){
        [user gotoOptionListViewController:self];
        
    } else {
        [user gotoOptionListSignedInViewController:self];
    }
}

@end
