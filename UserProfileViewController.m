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
    [self loadNavController];
    [self loadUserFromFirebaseDatabase];
    self.scrollView.contentSize = self.view.bounds.size;
    self.shyNavBarManager.scrollView = self.scrollView;
    //    [self loadExtView];
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
                [self loadReviewsFromFirebase];
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

-(void)loadReviewsFromFirebase{
    //    FIRDatabaseQuery *reviewQuery = [[ queryOrderedByChild:@"reviewData"] queryEqualToValue:_otherUser.userKey];
    
    [[[firebaseRef.ref child:@"reviewData"] child:_otherUser.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            for (id key in snapshot.value) {
                reviewClass *tempReview = [[reviewClass alloc] init];
                tempReview.reviewKey = key;
                
                NSDictionary *dictionary = [[NSDictionary alloc] init];
                dictionary = [snapshot.value valueForKey:tempReview.reviewKey];
                tempReview.message = [dictionary valueForKey:@"message"];
                tempReview.objectImageURL = [dictionary valueForKey:@"objectImageKey"];
                tempReview.objectKey = [dictionary valueForKey:@"objectKey"];
                tempReview.objectName = [dictionary valueForKey:@"objectName"];
                tempReview.objectType = [dictionary valueForKey:@"objectType"];
                tempReview.userKey = [dictionary valueForKey:@"userKey"];
                tempReview.rating = [dictionary valueForKey:@"rating"];
                
                [_otherUser.reviews addObject:tempReview];
            }
            _myReviewsNumber.text = [NSString stringWithFormat:@"%lu", (unsigned long)_otherUser.reviews.count];
        }
        [self.view setNeedsDisplay];
    }];
    
}

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

                NSInteger index = [user.friendsKeys indexOfObject:_otherUser.userKey];
                [user.friendsKeys removeObjectAtIndex:index];
                
                [_addFriendButton setBackgroundImage:nil forState:UIControlStateNormal];
                [_addFriendButton setTitleColor:[UIColor colorWithRed:8.0/255.0 green:197.0/255.0 blue:103.0/255.0 alpha:1.0] forState:UIControlStateNormal];
                [_addFriendButton setTitle:@"Add Friend" forState:UIControlStateNormal];
            }]];
            
            [self presentViewController:actionSheet animated:YES completion:nil];             // Present action sheet.

        }
        else if ([user.friendRequestsOutgoingKeys indexOfObject:_otherUser.userKey] != NSNotFound){
            [[[[firebaseRef.ref child:@"friendRequestOutbound"] child:user.userKey] child:_otherUser.userKey] removeValue];
            [[[[firebaseRef.ref child:@"friendRequestInbound"] child:_otherUser.userKey] child:user.userKey] removeValue];
            
            NSInteger index = [user.friendRequestsOutgoingKeys indexOfObject:_otherUser.userKey];
            [user.friendRequestsOutgoingKeys removeObjectAtIndex:index];

            [_addFriendButton setBackgroundImage:nil forState:UIControlStateNormal];
            [_addFriendButton setTitleColor:[UIColor colorWithRed:8.0/255.0 green:197.0/255.0 blue:103.0/255.0 alpha:1.0] forState:UIControlStateNormal];
            [_addFriendButton setTitle:@"Add Friend" forState:UIControlStateNormal];
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
    [self performSegueWithIdentifier:@"badgesSegue" sender:self];
}
- (IBAction)tappedFriends:(UITapGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"friendsSegue" sender:self];
}
- (IBAction)tappedMyReviews:(UITapGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"myReviewsSegue" sender:self];
}
- (IBAction)tappedStrainsTried:(UITapGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"strainsTriedSegue" sender:self];
}
- (IBAction)tappedStoresVisited:(UITapGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"storesVisitedSegue" sender:self];
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
    
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    NSArray *buttons = @[buttonOne, space, buttonTwo, space, buttonThree, space, buttonFour, space, buttonFive];
    
    self.navigationController.navigationBar.topItem.leftBarButtonItems = buttons;
}

-(IBAction)newsFeedButtonPressed:(UIButton*)btn {
    user.mainNavigationSelected = 0;
    [user goToNewsFeedViewController:self];
}

-(IBAction)strainButtonPressed:(UIButton*)btn {
    user.mainNavigationSelected = 1;
    [user gotoMapViewViewController:self];
    
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
