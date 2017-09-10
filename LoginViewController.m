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

    CGFloat myWidth = 20.0f;
    CGFloat myHeight = 20.0f;
    UIButton *myButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, myWidth, myHeight)];
    UIButton *myButton2 = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, myWidth, myHeight)];
    [myButton setImage:[UIImage imageNamed:@"clearWhiteIcon"] forState:UIControlStateNormal];
    [myButton2 setImage:[UIImage imageNamed:@"clearWhiteIcon"] forState:UIControlStateNormal];
    
    [myButton addTarget:self action:@selector(doClear:) forControlEvents:UIControlEventTouchUpInside];
    [myButton2 addTarget:self action:@selector(doClear2:) forControlEvents:UIControlEventTouchUpInside];
    
    _SignInUsername.rightView = myButton;
    _SignInUsername.rightViewMode = UITextFieldViewModeWhileEditing;
    _SignInPassword.rightView = myButton2;
    _SignInPassword.rightViewMode = UITextFieldViewModeWhileEditing;
    
    
    CALayer *topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(20,0,self.view.bounds.size.width-20,1);
    topBorder.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:57.0/255.0 blue:47.0/255.0 alpha:1].CGColor;
    
    [self.view.layer addSublayer:topBorder];
    
    _SignInUsername.floatingLabelFont = [UIFont fontWithName:@"NEXA BOLD" size:14.0];
    UIColor *color = [UIColor whiteColor];
    _SignInUsername.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"EMAIL ADDRESS" attributes:@{NSForegroundColorAttributeName: color}];

    _SignInPassword.floatingLabelFont = [UIFont fontWithName:@"NEXA BOLD" size:14.0];
    _SignInPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"PASSWORD" attributes:@{NSForegroundColorAttributeName: color}];


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
        _SignInUsername.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"EMAIL ADDRESS" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    }
}

- (void) passwordFieldDidChange:(UITextField *) textField{
    if(_SignInPassword.text.length == 0){
        _SignInPassword.font = [UIFont fontWithName:@"NEXA BOLD" size:17.0];
    }
    else{
        _SignInPassword.font = [UIFont fontWithName:@"CERVO-THIN" size:24.0];
        _SignInPassword.floatingLabelFont = [UIFont fontWithName:@"NEXA BOLD" size:14.0];
        _SignInPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"PASSWORD" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
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
    [[FIRAuth auth] signInWithEmail:_SignInUsername.text password:_SignInPassword.text completion:^(FIRUser *youser, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
            [user presentLoginErrorAlert:self];
        }
        else {
            [self loadUserFromFirebaseDatabase];
        }
    }];
}

- (IBAction)cancelButtonTapped:(UIBarButtonItem *)sender {
    [user goToNewsFeedViewController:self];
}

- (void) loadUserFromFirebaseDatabase {
    [firebaseRef.usersRef observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        NSDictionary *usersSnapshot = snapshot.value; //Creates a dictionary of of the JSON node strains
        NSArray *userKeys = [usersSnapshot allKeys]; //Creates an array with only the strain key uID
        
        for(int i=0; i<userKeys.count ; i++){
            NSString *key = userKeys[i];
            NSDictionary *userDict = [usersSnapshot valueForKey:key];
            if ([_SignInUsername.text isEqual:[userDict valueForKey:@"email"]]){
                [self setUserObject:key
                       FromFirebase:userDict];
            }
        }
        [self loadReviewsFromFirebase];
    }];
}

-(void)setUserObject:(NSString *)key FromFirebase:(NSDictionary *)userDict{
    if (!([[userDict valueForKey:@"badges"]  isEqual: @""])) {
        NSMutableDictionary *dict = [userDict valueForKey:@"badges"];
        for (id key in dict) {
            NSString *value = [dict valueForKey:key];
            if ([value isEqualToString:@"true"]) {
                [user.badges addObject:key];
            }
        }
    }
    
    if (!([[userDict valueForKey:@"checkIns"]  isEqual: @""])) {
        user.checkIns = [NSMutableArray arrayWithArray:[[userDict valueForKey:@"checkIns"] allKeys]];
    }
    
    NSMutableArray *array3 = [[NSMutableArray alloc] init];
    if (!([[userDict valueForKey:@"friends"]  isEqual: @""])) {
        NSArray *keys = [[userDict valueForKey:@"friends"] allKeys];
        NSArray *sortedKeys = [keys sortedArrayUsingSelector:@selector(compare:)];
        array3 = [NSMutableArray arrayWithArray:sortedKeys];
        user.friendsKeys = [NSMutableArray arrayWithArray:sortedKeys];
    }
    
    if (!([[userDict valueForKey:@"storesVisited"]  isEqual: @""])) {
        user.storesVisited = [NSMutableArray arrayWithArray:[[userDict valueForKey:@"storesVisited"] allKeys]];
    }
    
    if (!([[userDict valueForKey:@"strainsTried"]  isEqual: @""])) {
        user.strainsTried = [NSMutableArray arrayWithArray:[[userDict valueForKey:@"strainsTried"] allKeys]];
    }
    
    if (!([[userDict valueForKey:@"wishList"]  isEqual: @""])) {
        user.wishList = [NSMutableArray arrayWithArray:[[userDict valueForKey:@"wishList"] allKeys]];
    }
    
    if (!([[userDict valueForKey:@"friendRequestsIncoming"]  isEqual: @""])) {
        user.friendRequestsIncomingKeys = [NSMutableArray arrayWithArray:[[userDict valueForKey:@"friendRequestsIncoming"] allKeys]];
    }
    
    if (!([[userDict valueForKey:@"friendRequestsOutgoing"]  isEqual: @""])) {
        user.friendRequestsOutgoingKeys = [NSMutableArray arrayWithArray:[[userDict valueForKey:@"friendRequestsOutgoing"] allKeys]];
    }
    
    [user setUserObject:key
         fromDictionary:userDict];

}

-(void)loadReviewsFromFirebase{
    FIRDatabaseQuery *reviewQuery = [[firebaseRef.reviewsRef queryOrderedByChild:@"userKey"] queryEqualToValue:user.userKey];
    
    [reviewQuery observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if (snapshot.value == [NSNull null]) {}
        else{
            for (NSInteger i = 0; i < [snapshot.value allKeys].count; i++) {
                reviewClass *tempReview = [[reviewClass alloc] init];
                tempReview.reviewKey = [[snapshot.value allKeys] objectAtIndex:i];
                
                NSDictionary *dictionary = [[NSDictionary alloc] init];
                dictionary = [snapshot.value valueForKey:tempReview.reviewKey];
                tempReview.message = [dictionary valueForKey:@"message"];
                tempReview.objectImageURL = [dictionary valueForKey:@"objectImage"];
                tempReview.objectKey = [dictionary valueForKey:@"objectKey"];
                tempReview.objectName = [dictionary valueForKey:@"objectName"];
                tempReview.objectType = [dictionary valueForKey:@"objectType"];
                tempReview.userKey = [dictionary valueForKey:@"userKey"];
                tempReview.rating = [dictionary valueForKey:@"rating"];
                tempReview.objectDataString = [dictionary valueForKey:@"objectData"];
                tempReview.objectData = [[NSData alloc] initWithBase64EncodedString:tempReview.objectDataString options:0];

                [user.reviews addObject:tempReview];
            }
            
            [self getAvatarURLData];
        }}];
    
}

-(void) getAvatarURLData{
    user.data =  [[NSData alloc] initWithBase64EncodedString:user.avatarDataString options:0];
    [user goToCurrentUserProfileViewController:self];
}

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
    if (user.mainNavigationSelected == 0) {
        [btn1 setBackgroundImage:[UIImage imageNamed:@"newsFeedGreenIcon"] forState:UIControlStateNormal];
    } else {
        [btn1 setBackgroundImage:[UIImage imageNamed:@"newsFeedWhiteIcon"] forState:UIControlStateNormal];
    }
    [btn1 addTarget:self action:@selector(newsFeedButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonOne = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    
    
    UIButton *btn2 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0,0,25,25);
    if (user.mainNavigationSelected == 1) {
        [btn2 setBackgroundImage:[UIImage imageNamed:@"mapWhiteIcon"] forState:UIControlStateNormal];
    } else {
        [btn2 setBackgroundImage:[UIImage imageNamed:@"mapWhiteIcon"] forState:UIControlStateNormal];
    }
    [btn2 addTarget:self action:@selector(strainButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonTwo = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    
    
    UIButton *btn3 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(0,0,25,25);
    if (user.mainNavigationSelected == 2) {
        [btn3 setBackgroundImage:[UIImage imageNamed:@"searchGreenIcon"] forState:UIControlStateNormal];
    } else {
        [btn3 setBackgroundImage:[UIImage imageNamed:@"searchWhiteIcon"] forState:UIControlStateNormal];
    }
    [btn3 addTarget:self action:@selector(searchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonThree = [[UIBarButtonItem alloc] initWithCustomView:btn3];
    
    
    UIButton *btn4 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(0,0,25,25);
    if (user.mainNavigationSelected == 3) {
        [btn4 setBackgroundImage:[UIImage imageNamed:@"storesGreenIcon"] forState:UIControlStateNormal];
    } else {
        [btn4 setBackgroundImage:[UIImage imageNamed:@"storesWhiteIcon"] forState:UIControlStateNormal];
    }
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







