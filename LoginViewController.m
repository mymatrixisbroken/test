//
//  SecondViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "LoginViewController.h"

const static CGFloat frameSizeWidth = 600.0f;


@interface LoginViewController () //<FBSDKLoginButtonDelegate>

@end

@implementation LoginViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNavController];
    _queriesArray = [[NSMutableArray alloc] init];
    _dict = [[NSMutableDictionary alloc] init];
    [self setTextFields];
    
    [_SignInUsername addTarget:self
                        action:@selector(usernameFieldDidChange:)
              forControlEvents:UIControlEventEditingChanged];
    [_SignInPassword addTarget:self
                        action:@selector(passwordFieldDidChange:)
              forControlEvents:UIControlEventEditingChanged];

//    CGFloat myWidth = 20.0f;
//    CGFloat myHeight = 20.0f;
//    UIButton *myButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, -10.0f, myWidth, myHeight)];
//    UIButton *myButton2 = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, -10.0f, myWidth, myHeight)];
//    [myButton setImage:[UIImage imageNamed:@"clearWhiteIcon"] forState:UIControlStateNormal];
//    [myButton2 setImage:[UIImage imageNamed:@"clearWhiteIcon"] forState:UIControlStateNormal];
//    
//    [myButton addTarget:self action:@selector(doClear:) forControlEvents:UIControlEventTouchUpInside];
//    [myButton2 addTarget:self action:@selector(doClear2:) forControlEvents:UIControlEventTouchUpInside];
//    
//    _SignInUsername.rightView = myButton;
//    _SignInUsername.rightViewMode = UITextFieldViewModeWhileEditing;
//    _SignInPassword.rightView = myButton2;
//    _SignInPassword.rightViewMode = UITextFieldViewModeWhileEditing;
    
    
//    CALayer *topBorder = [CALayer layer];
//    topBorder.frame = CGRectMake(20,0,self.view.bounds.size.width-20,1);
//    topBorder.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:57.0/255.0 blue:47.0/255.0 alpha:1].CGColor;
//    
//    [self.view.layer addSublayer:topBorder];
    
    _SignInUsername.floatingLabelFont = [UIFont fontWithName:@"NEXA BOLD" size:14.0];
    UIColor *color = [UIColor whiteColor];
    _SignInUsername.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" USERNAME" attributes:@{NSForegroundColorAttributeName: color}];

    _SignInPassword.floatingLabelFont = [UIFont fontWithName:@"NEXA BOLD" size:14.0];
    _SignInPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" PASSWORD" attributes:@{NSForegroundColorAttributeName: color}];


    _gradientMask = [CAGradientLayer layer];
    _gradientMask.frame = _SignInUsername.bounds;
    _gradientMask.colors = @[(id)[UIColor clearColor].CGColor,
                             (id)[UIColor colorWithRed:0.0/255.0 green:57.0/255.0 blue:47.0/255.0 alpha:1.0].CGColor];
    _gradientMask.startPoint = CGPointMake(0.0, 0.5);   // start at left middle
    _gradientMask.endPoint = CGPointMake(1.0, 0.5);     // end at right middle
    
    //    _gradientMask.colors = @[(id)[UIColor clearColor].CGColor,
    //                             (id)[UIColor whiteColor].CGColor];
    _gradientMask1 = [CAGradientLayer layer];
    _gradientMask1.frame = _SignInPassword.frame;
    _gradientMask1.colors = @[(id)[UIColor clearColor].CGColor,
                              (id)[UIColor colorWithRed:0.0/255.0 green:57.0/255.0 blue:47.0/255.0 alpha:1.0].CGColor];
    _gradientMask1.startPoint = CGPointMake(0.0, 0.5);   // start at left middle
    _gradientMask1.endPoint = CGPointMake(1.0, 0.5);     // end at right middle


}

- (void) doClear:(UIButton *) btn{
    _SignInUsername.text = nil;
    _SignInUsername.font = [UIFont fontWithName:@"NEXA BOLD" size:17.0];
}
- (void) doClear2:(UIButton *) btn{
    _SignInPassword.text = nil;
    _SignInPassword.font = [UIFont fontWithName:@"NEXA BOLD" size:17.0];
}

//- (void) textFieldDidChange:(JVFloatLabeledTextField *) textField{
//    if(textField.text.length == 0){
//        textField.font = [UIFont fontWithName:@"NEXA BOLD" size:17.0];
//    }
//    else{
//        textField.font = [UIFont fontWithName:@"CERVO-THIN" size:24.0];
//        textField.floatingLabelFont = [UIFont fontWithName:@"NEXA BOLD" size:14.0];
//        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"EMAIL ADDRESS" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
//    }
//}


- (void) usernameFieldDidChange:(UITextField *) textField{
    if(_SignInUsername.text.length == 0){
        _SignInUsername.font = [UIFont fontWithName:@"NEXA BOLD" size:17.0];
    }
    else{
        _SignInUsername.font = [UIFont fontWithName:@"CERVO-THIN" size:24.0];
        _SignInUsername.floatingLabelFont = [UIFont fontWithName:@"NEXA BOLD" size:14.0];
        _SignInUsername.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" USERNAME" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    }
}

- (void) passwordFieldDidChange:(UITextField *) textField{
    if(_SignInPassword.text.length == 0){
        _SignInPassword.font = [UIFont fontWithName:@"NEXA BOLD" size:17.0];
    }
    else{
        _SignInPassword.font = [UIFont fontWithName:@"CERVO-THIN" size:24.0];
        _SignInPassword.floatingLabelFont = [UIFont fontWithName:@"NEXA BOLD" size:14.0];
        _SignInPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" PASSWORD" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    }
}

- (IBAction)emailDidBeginEditing:(JVFloatLabeledTextField *)sender {
    [_SignInUsername.layer addSublayer:_gradientMask];
}

- (IBAction)emailDidEndEditing:(JVFloatLabeledTextField *)sender {
    [_gradientMask removeFromSuperlayer];
}

- (IBAction)passwordDidBeginEditing:(JVFloatLabeledTextField *)sender {
    [_SignInPassword.layer addSublayer:_gradientMask];
}

- (IBAction)passwordDidEndEditing:(JVFloatLabeledTextField *)sender {
    [_gradientMask1 removeFromSuperlayer];
}


- (void) setTextFields {
//    [_SignInUsername.layer addSublayer:[self customUITextField:70]];
    _SignInUsername.layer.masksToBounds = YES;
//    [_SignInUsername becomeFirstResponder];
    
    //Custom format uiTextField
//    [_SignInPassword.layer addSublayer:[self customUITextField:70]];
    _SignInPassword.layer.masksToBounds = YES;
    
    _SignInButton.enabled = NO;
    _SignInButton.alpha = 0.5;
    _SignInButton.contentEdgeInsets = UIEdgeInsetsMake(5, 22, 5, 0);
    
//    [_signInVIew.layer addSublayer:[self customUITextField:75]];
    _signInVIew.layer.masksToBounds = YES;
}

- (IBAction)PasswordTextFieldChanged:(id)sender {
    if (_SignInPassword.text.length > 0) {
        _SignInButton.enabled = YES;
        _SignInButton.alpha = 1.0;
    }
    else{
        _SignInButton.enabled = NO;
        _SignInButton.alpha = 0.5;
    }
}

- (IBAction)SignUpButtonTapped:(id)sender {
    [user gotoCreateAccountViewController:self];
}

- (IBAction)SignInButtonTapped:(UIButton *)sender{
    NSString *lowerString = [_SignInUsername.text lowercaseString];
    NSLog(@"lowerstring  is %@", lowerString);
    
    
    FIRDatabaseQuery *queryLowerUsername = [[[firebaseRef.ref child:@"usernames"] queryOrderedByChild:@"lowerUsername"] queryEqualToValue:lowerString];
    
    [queryLowerUsername observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            NSLog(@"snapshot is %@", snapshot.value);
            if ([[snapshot.value allKeys] count]== 1) {                         //check one email found
                user.userKey = [[snapshot.value allKeys]objectAtIndex:0];
                [self getUserEmail];
            }
        }
        else
            [user presentLoginErrorAlert:self];
    }];

    
}

- (void) getUserEmail{
//    FIRDatabaseQuery *queryLowerEmailAddress = [[[firebaseRef.ref child:@"emailAddress"] queryOrderedByChild:@"lowerEmailAddress"] queryEqualToValue:lowerString];

    [[[firebaseRef.ref child:@"emailAddress"] child:user.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
            NSLog(@"snapshot is %@", snapshot.value);
                user.email  = [snapshot.value valueForKey:@"emailAddress"];
                
                [[FIRAuth auth] signInWithEmail:user.email password:_SignInPassword.text completion:^(FIRUser *youser, NSError *error) {
                    if (error != nil) {
                        NSLog(@"%@", error.localizedDescription);
                        [user presentLoginErrorAlert:self];
                    }
                    else {
                        [user goToCurrentUserProfileViewController:self];
//                        [self loadUserFromFirebaseDatabase];
                    }
                }];
            }
    }];
}
//
//- (IBAction)cancelButtonTapped:(UIBarButtonItem *)sender {
//    [user goToNewsFeedViewController:self];
//}

//- (void) loadUserFromFirebaseDatabase {
//    
////    [self getUsername];
//    [self getDateJoined];
//    [self getLastSignedIn];
//    [self getAccountType];
//    [self getUserImages];
//    [self getUserBadges];
//    [self getCheckIns];
//    [self getFriends];
//    [self getStoresVisited];
//    [self getStrainsTried];
//    [self getStoreBookMarks];
//    [self getStrainBookMarks];
//    [self getFriendRequestInbound];
//    [self getFriendRequestOutbound];
//    [self loadReviewsFromFirebase];
//
////    NSString *lowerString = [_SignInUsername.text lowercaseString];
////    NSLog(@"lowerstring  is %@", lowerString);
////
////    
////    FIRDatabaseQuery *queryLowerEmailAddress = [[[firebaseRef.ref child:@"emailAddress"] queryOrderedByChild:@"lowerEmailAddress"] queryEqualToValue:lowerString];
////    
////    [queryLowerEmailAddress observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
////        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
////            NSLog(@"snapshot is %@", snapshot.value);
////            if ([[snapshot.value allKeys] count]== 1) {                         //check one email found
////                user.userKey = [[snapshot.value allKeys]objectAtIndex:0];
////                NSDictionary *dictionary = [snapshot.value valueForKey:user.userKey];
////                user.email  = [dictionary valueForKey:@"emailAddress"];
////                
////                [self getUsername];
////                [self getDateJoined];
////                [self getLastSignedIn];
////                [self getAccountType];
////                [self getUserImages];
////                [self getUserBadges];
////                [self getCheckIns];
////                [self getFriends];
////                [self getStoresVisited];
////                [self getStrainsTried];
////                [self getStoreBookMarks];
////                [self getStrainBookMarks];
////                [self getFriendRequestInbound];
////                [self getFriendRequestOutbound];
////                [self loadReviewsFromFirebase];
////            }
////        }
////    }];
//
//    
//    
//    //    [firebaseRef.usersRef observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
////        NSDictionary *usersSnapshot = snapshot.value; //Creates a dictionary of of the JSON node strains
////        NSArray *userKeys = [usersSnapshot allKeys]; //Creates an array with only the strain key uID
////        
////        for(int i=0; i<userKeys.count ; i++){
////            NSString *key = userKeys[i];
////            NSDictionary *userDict = [usersSnapshot valueForKey:key];
////            if ([_SignInUsername.text isEqual:[userDict valueForKey:@"email"]]){
////                [self setUserObject:key
////                       FromFirebase:userDict];
////            }
////        }
////        [self loadReviewsFromFirebase];
////    }];
//}
//
//- (void) getUsername{
//    [[[firebaseRef.ref child:@"usernames"] child:user.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
//        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
//            user.username = [snapshot.value valueForKey:@"username"];
//        }
//    }];
//}
//
//- (void) getDateJoined{
//    [[[firebaseRef.ref child:@"dateJoined"] child:user.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
//        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
//            user.dateJoined = [snapshot.value valueForKey:@"dateJoined"];
//        }
//    }];
//}
//
//- (void) getLastSignedIn{
//    [[[firebaseRef.ref child:@"dateLastSignedIn"] child:user.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
//        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
//            user.lastSignedIn = [snapshot.value valueForKey:@"dateLastSignedIn"];
//        }
//    }];
//}
//
//- (void) getAccountType{
//    [[[firebaseRef.ref child:@"accountType"] child:user.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
//        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
//            user.accountType = [snapshot.value valueForKey:@"accountType"];
//        }
//    }];
//}
//
//- (void) getUserImages{
//    [[[[firebaseRef.ref child:@"images"] child:@"users"] child:user.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
//        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
//            for (id key in snapshot.value) {
//                [user.imageKeys addObject:key];
//                [user.imageLinks addObject:[snapshot.value valueForKey:key]];
//            }
//        }
//    }];
//}
//
//- (void) getUserBadges{
//    [[[firebaseRef.ref child:@"badges"] child:user.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
//        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
//            for (id key in snapshot.value) {
//                NSString *value = [snapshot.value valueForKey:key];
//                if ([value isEqualToString:@"true"]) {
//                    [user.badges addObject:key];
//                }
//            }
//        }
//    }];
//}
//
//- (void) getCheckIns{
//    [[[firebaseRef.ref child:@"checkIns"] child:user.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
//        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
//            for (id key in snapshot.value) {
//                [user.checkIns addObject:key];
//            }
//        }
//    }];
//}
//
//- (void) getFriends{
//    [[[firebaseRef.ref child:@"friends"] child:user.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
//        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
//            for (id key in snapshot.value) {
//                [user.friendsKeys addObject:key];
//            }
//        }
//    }];
//}
//
//- (void) getStoresVisited{
//    [[[firebaseRef.ref child:@"storesVisited"] child:user.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
//        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
//            for (id key in snapshot.value) {
//                [user.storesVisited addObject:key];
//            }
//        }
//    }];
//}
//
//- (void) getStrainsTried{
//    [[[firebaseRef.ref child:@"strainsTried"] child:user.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
//        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
//            for (id key in snapshot.value) {
//                [user.strainsTried addObject:key];
//            }
//        }
//    }];
//}
//
//- (void) getStoreBookMarks{
//    [[[[firebaseRef.ref  child:@"bookmarks"] child:user.userKey] child:@"stores"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
//        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
//            for (id key in snapshot.value) {
//                [user.storeBookmarks addObject:key];
//            }
//        }
//    }];
//}
//
//- (void) getStrainBookMarks{
//    [[[[firebaseRef.ref  child:@"bookmarks"] child:user.userKey] child:@"strains"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
//        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
//            for (id key in snapshot.value) {
//                [user.strainBookmarks addObject:key];
//            }
//        }
//    }];
//}
//
//- (void) getFriendRequestInbound{
//    [[[firebaseRef.ref  child:@"friendRequestInbound"] child:user.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
//        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
//            for (id key in snapshot.value) {
//                [user.friendRequestsIncomingKeys addObject:key];
//            }
//        }
//    }];
//}
//
//- (void) getFriendRequestOutbound{
//    [[[firebaseRef.ref  child:@"friendRequestOutbound"] child:user.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
//        if ([NSNull null] != snapshot.value){                                   //check snapshot is null
//            for (id key in snapshot.value) {
//                [user.friendRequestsOutgoingKeys addObject:key];
//            }
//        }
//    }];
//}
//
//
//-(void)setUserObject:(NSString *)key FromFirebase:(NSDictionary *)userDict{
//    
////    if (!([[userDict valueForKey:@"badges"]  isEqual: @""])) {
////        NSMutableDictionary *dict = [userDict valueForKey:@"badges"];
////        for (id key in dict) {
////            NSString *value = [dict valueForKey:key];
////            if ([value isEqualToString:@"true"]) {
////                [user.badges addObject:key];
////            }
////        }
////    }
//    
////    if (!([[userDict valueForKey:@"checkIns"]  isEqual: @""])) {
////        user.checkIns = [NSMutableArray arrayWithArray:[[userDict valueForKey:@"checkIns"] allKeys]];
////    }
//    
////    NSMutableArray *array3 = [[NSMutableArray alloc] init];
////    if (!([[userDict valueForKey:@"friends"]  isEqual: @""])) {
////        NSArray *keys = [[userDict valueForKey:@"friends"] allKeys];
////        NSArray *sortedKeys = [keys sortedArrayUsingSelector:@selector(compare:)];
////        array3 = [NSMutableArray arrayWithArray:sortedKeys];
////        user.friendsKeys = [NSMutableArray arrayWithArray:sortedKeys];
////    }
//    
////    if (!([[userDict valueForKey:@"storesVisited"]  isEqual: @""])) {
////        user.storesVisited = [NSMutableArray arrayWithArray:[[userDict valueForKey:@"storesVisited"] allKeys]];
////    }
////    
////    if (!([[userDict valueForKey:@"strainsTried"]  isEqual: @""])) {
////        user.strainsTried = [NSMutableArray arrayWithArray:[[userDict valueForKey:@"strainsTried"] allKeys]];
////    }
//    
//////    if (!([[userDict valueForKey:@"wishList"]  isEqual: @""])) {
//////        user.wishList = [NSMutableArray arrayWithArray:[[userDict valueForKey:@"wishList"] allKeys]];
//////    }
////    
////    if (!([[userDict valueForKey:@"friendRequestsIncoming"]  isEqual: @""])) {
////        user.friendRequestsIncomingKeys = [NSMutableArray arrayWithArray:[[userDict valueForKey:@"friendRequestsIncoming"] allKeys]];
////    }
////    
////    if (!([[userDict valueForKey:@"friendRequestsOutgoing"]  isEqual: @""])) {
////        user.friendRequestsOutgoingKeys = [NSMutableArray arrayWithArray:[[userDict valueForKey:@"friendRequestsOutgoing"] allKeys]];
////    }
//    
////    [user setUserObject:key
////         fromDictionary:userDict];
//
//}
//
//-(void)loadReviewsFromFirebase{
////    FIRDatabaseQuery *reviewQuery = [[ queryOrderedByChild:@"reviewData"] queryEqualToValue:user.userKey];
//    
//    [[[firebaseRef.ref child:@"reviewData"] child:user.userKey] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
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
//                [user.reviews addObject:tempReview];
//            }
//        }
//        [user goToCurrentUserProfileViewController:self];
//    }];
//    
//}

//-(void) getAvatarURLData{
//    user.data =  [[NSData alloc] initWithBase64EncodedString:user.avatarDataString options:0];
//}

- (CALayer *) customUITextField:(CGFloat) frameHeight{
    CALayer *border = [CALayer layer];
    UIColor *selectedColor = [UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:205.0/255.0 alpha:1];
    CGFloat borderWidth = 2;
    border.borderColor = selectedColor.CGColor;
    border.frame = CGRectMake(0, frameHeight - borderWidth, frameSizeWidth, frameHeight);
    border.borderWidth = borderWidth;
    return border;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end







