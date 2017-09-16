//
//  SecondViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "CreateAccountViewController.h"

const static CGFloat frameSizeHeight = 50.0f;
const static CGFloat frameSizeWidth = 600.0f;


@interface CreateAccountViewController ()
@end

@implementation CreateAccountViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_usernameField addTarget:self
                        action:@selector(usernameFieldDidChange:)
              forControlEvents:UIControlEventEditingChanged];
    [_emailField addTarget:self
                    action:@selector(emailFieldDidChange:)
          forControlEvents:UIControlEventEditingChanged];
    [_passwordField addTarget:self
                    action:@selector(passwordFieldDidChange:)
          forControlEvents:UIControlEventEditingChanged];

//    CGFloat myWidth = 10.0f;
//    CGFloat myHeight = 10.0f;
//    UIButton *myButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, -10.0f, myWidth, myHeight)];
//    UIButton *myButton2 = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, -10.0f, myWidth, myHeight)];
//    UIButton *myButton3 = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, -10.0f, myWidth, myHeight)];
//    [myButton setImage:[UIImage imageNamed:@"clearWhiteIcon"] forState:UIControlStateNormal];
//    [myButton2 setImage:[UIImage imageNamed:@"clearWhiteIcon"] forState:UIControlStateNormal];
//    [myButton3 setImage:[UIImage imageNamed:@"clearWhiteIcon"] forState:UIControlStateNormal];
//
//    [myButton addTarget:self action:@selector(doClear:) forControlEvents:UIControlEventTouchUpInside];
//    [myButton2 addTarget:self action:@selector(doClear2:) forControlEvents:UIControlEventTouchUpInside];
//    [myButton3 addTarget:self action:@selector(doClear3:) forControlEvents:UIControlEventTouchUpInside];
//
//    _usernameField.rightView = myButton;
//    _usernameField.rightViewMode = UITextFieldViewModeWhileEditing;
//    _emailField.rightView = myButton2;
//    _emailField.rightViewMode = UITextFieldViewModeWhileEditing;
//    _passwordField.rightView = myButton3;
//    _passwordField.rightViewMode = UITextFieldViewModeWhileEditing;

    
//    CALayer *topBorder = [CALayer layer];
//    topBorder.frame = CGRectMake(20,0,_usernameField.bounds.size.width,1);
//    topBorder.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:57.0/255.0 blue:47.0/255.0 alpha:1].CGColor;
//    
//    CALayer *topBorder1 = [CALayer layer];
//    topBorder1.frame = CGRectMake(20,0,_usernameField.bounds.size.width,1);
//    topBorder1.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:57.0/255.0 blue:47.0/255.0 alpha:1].CGColor;
//    
//    CALayer *topBorder2 = [CALayer layer];
//    topBorder2.frame = CGRectMake(20,0,_usernameField.bounds.size.width,1);
//    topBorder2.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:57.0/255.0 blue:47.0/255.0 alpha:1].CGColor;
//
//    [_createAccountView.layer addSublayer:topBorder];
//    [_fieldsView.layer addSublayer:topBorder1];
//    [_termsView.layer addSublayer:topBorder2];

    
    
    _usernameField.floatingLabelFont = [UIFont fontWithName:@"NEXA BOLD" size:14.0];
    _emailField.floatingLabelFont = [UIFont fontWithName:@"NEXA BOLD" size:14.0];
    _passwordField.floatingLabelFont = [UIFont fontWithName:@"NEXA BOLD" size:14.0];

    UIColor *color = [UIColor whiteColor];
    _usernameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" USERNAME" attributes:@{NSForegroundColorAttributeName: color}];
    _emailField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" EMAIL ADDRESS" attributes:@{NSForegroundColorAttributeName: color}];
    _passwordField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" PASSWORD" attributes:@{NSForegroundColorAttributeName: color}];

    _gradientMask = [CAGradientLayer layer];
    _gradientMask.frame = _usernameField.bounds;
    _gradientMask.colors = @[(id)[UIColor clearColor].CGColor,
                             (id)[UIColor colorWithRed:0.0/255.0 green:57.0/255.0 blue:47.0/255.0 alpha:1.0].CGColor];
    _gradientMask.startPoint = CGPointMake(0.0, 0.5);   // start at left middle
    _gradientMask.endPoint = CGPointMake(1.0, 0.5);     // end at right middle

}

- (void) usernameFieldDidChange:(UITextField *) textField{
    if(_usernameField.text.length == 0){
        _usernameField.font = [UIFont fontWithName:@"NEXA BOLD" size:17.0];
    }
    else{
        _usernameField.font = [UIFont fontWithName:@"CERVO-THIN" size:24.0];
        _usernameField.floatingLabelFont = [UIFont fontWithName:@"NEXA BOLD" size:14.0];
        _usernameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" USERNAME" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    }
}

- (void) emailFieldDidChange:(UITextField *) textField{
    if(_emailField.text.length == 0){
        _emailField.font = [UIFont fontWithName:@"NEXA BOLD" size:17.0];
    }
    else{
        _emailField.font = [UIFont fontWithName:@"CERVO-THIN" size:24.0];
        _emailField.floatingLabelFont = [UIFont fontWithName:@"NEXA BOLD" size:14.0];
        _emailField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" EMAIL ADDRESS" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    }
}

- (void) passwordFieldDidChange:(UITextField *) textField{
    if(_passwordField.text.length == 0){
        _passwordField.font = [UIFont fontWithName:@"NEXA BOLD" size:17.0];
    }
    else{
        _passwordField.font = [UIFont fontWithName:@"CERVO-THIN" size:24.0];
        _passwordField.floatingLabelFont = [UIFont fontWithName:@"NEXA BOLD" size:14.0];
        _passwordField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" PASSWORD" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    }
}

- (void) doClear:(UIButton *) btn{
    _usernameField.text = nil;
    _usernameField.font = [UIFont fontWithName:@"NEXA BOLD" size:17.0];
}

- (void) doClear2:(UIButton *) btn{
    _emailField.text = nil;
    _emailField.font = [UIFont fontWithName:@"NEXA BOLD" size:17.0];
}

- (void) doClear3:(UIButton *) btn{
    _passwordField.text = nil;
    _passwordField.font = [UIFont fontWithName:@"NEXA BOLD" size:17.0];
}

- (IBAction)usernameDidBeginEditing:(JVFloatLabeledTextField *)sender {
    [_usernameField.layer addSublayer:_gradientMask];
}

- (IBAction)usernameDidEndEditing:(JVFloatLabeledTextField *)sender {
    [_gradientMask removeFromSuperlayer];
}

- (IBAction)emailDidBeginEditing:(JVFloatLabeledTextField *)sender {
    [_emailField.layer addSublayer:_gradientMask];
}

- (IBAction)emailDidEndEditing:(JVFloatLabeledTextField *)sender {
//    [_gradientMask1 removeFromSuperlayer];
}

- (IBAction)passwordDidBeginEditing:(JVFloatLabeledTextField *)sender {
    [_passwordField.layer addSublayer:_gradientMask];
}

- (IBAction)passwordDidEndEditing:(JVFloatLabeledTextField *)sender {
//    [_gradientMask2 removeFromSuperlayer];
}

- (IBAction)tappedSignUp:(UIButton *)sender {
    if([self isValidUsername]){}
        else return;
    
    if([self isValidEmail]){}
        else return;
    
    if([self isValidPassword]){}
    else return;

    if([self isTermsAccepted]){}
    else return;

    
    
    NSString *lowerString = [_usernameField.text lowercaseString];
    
    NSLog(@"lowerString is %@", lowerString);
    
    
    FIRDatabaseQuery *myTopPostsQuery = [[[firebaseRef.ref  child:@"usernames"] queryOrderedByChild:@"lowerUsername"] queryEqualToValue:lowerString];
    
    [myTopPostsQuery observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] == snapshot.value){
            user.userKey = [[firebaseRef.ref  child:@"usernames"] childByAutoId].key;
            [user createUser:_emailField.text SignedUp:_usernameField.text];
            [self updateAnonymousUserToSignedUp:_passwordField.text];
            [self updateFirebaseDatabaseValues];
            
            if (user.userKey != nil) {
                [user goToCurrentUserProfileViewController:self];
            }
            else {
                NSLog(@"Failed to create account.");
            }
        }
        else if ([[snapshot.value allKeys] count] > 0) {
            NSLog(@"Username already taken");
            [user presentUsernameTakenAlert:self];
        }
    }];
}

-(BOOL) isValidUsername{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSRange range = [_usernameField.text rangeOfCharacterFromSet:whitespace];
    if (range.location == NSNotFound) {
        return YES;
    }
    else {
        [user presentUsernameInvalidAlert:self];
        return NO;
    }
}

-(BOOL)isValidEmail
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if ([emailTest evaluateWithObject:_emailField.text])
    {
        return YES;
    }
    else{
        [user presentEmailInvalidAlert:self];
        return NO;
    }
}

-(BOOL)isValidPassword
{
    if( (_passwordField.text.length > 4)){
        return YES;
    }
    else{
        [user presentPasswordInvalidAlert:self];
        return NO;
    }
}

-(BOOL)isTermsAccepted
{
    if([_termsSwitch isOn]){
        return YES;
    }
    else{
        [user presentTermsNotAgreedAlert:self];
        return NO;
    }
}


//- (CALayer *) customUITextField{
//    CALayer *border = [CALayer layer];
//    UIColor *selectedColor = [UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:205.0/255.0 alpha:1];
//    CGFloat borderWidth = 2;
//    border.borderColor = selectedColor.CGColor;
//    border.frame = CGRectMake(0, frameSizeHeight - borderWidth, frameSizeWidth, frameSizeHeight);
//    border.borderWidth = borderWidth;
//    return border;
//}
//
//- (void) setTextFields {
//    [_usernameField.layer addSublayer:[self customUITextField]];
//    _usernameField.layer.masksToBounds = YES;
//    [_usernameField becomeFirstResponder];
//    
//    [_emailField.layer addSublayer:[self customUITextField]];
//    _emailField.layer.masksToBounds = YES;
//    
//    [_passwordField.layer addSublayer:[self customUITextField]];
//    _passwordField.layer.masksToBounds = YES;
//    
//    _createAccountButton.enabled = NO;
//    _createAccountButton.alpha = 0.5;
//    _createAccountButton.contentEdgeInsets = UIEdgeInsetsMake(5, 22, 5, 0);
//}

- (IBAction)passwordFieldChanged
:(id)sender {
    if (_passwordField.text.length > 0) {
        _createAccountButton.enabled = YES;
        _createAccountButton.alpha = 1.0;
    }
    else{
        _createAccountButton.enabled = NO;
        _createAccountButton.alpha = 0.5;
    }
}

- (void) updateAnonymousUserToSignedUp:password{
    FIRUser *userAuth = [FIRAuth auth].currentUser;
    [userAuth updateEmail:user.email completion:^(NSError *_Nullable error) { }];
    [userAuth updatePassword:password completion:^(NSError *_Nullable error) { }];
}

- (void) getTodaysDate {
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    _todaysDate = [dateFormat stringFromDate:today];
}

-(void) updateFirebaseDatabaseValues {
    [self getTodaysDate];
    NSString *lowerString = [user.username lowercaseString];
    NSString *lowerString2 = [user.email lowercaseString];

    [[[[firebaseRef.ref  child:@"emailAddress"]  child:user.userKey] child:@"lowerEmailAddress"] setValue:lowerString2];
    [[[[firebaseRef.ref  child:@"emailAddress"]  child:user.userKey] child:@"emailAddress"] setValue:user.email];
    [[[[firebaseRef.ref  child:@"usernames"]  child:user.userKey] child:@"lowerUsername"] setValue:lowerString];
    [[[[firebaseRef.ref  child:@"usernames"]  child:user.userKey] child:@"username"] setValue:user.username];
    [[[[firebaseRef.ref  child:@"dateJoined"] child:user.userKey] child:@"dateJoined"] setValue:_todaysDate];
    [[[[firebaseRef.ref  child:@"dateLastSignedIn"] child:user.userKey] child:@"dateLastSignedIn"] setValue:_todaysDate];
    [[[[firebaseRef.ref  child:@"accountType"] child:user.userKey] child:@"accountType"] setValue:@"user"];
    
    [[[[firebaseRef.ref  child:@"badges"] child:user.userKey]  child:@"fiveStevias"] setValue:@"false"];
    [[[[firebaseRef.ref  child:@"badges"] child:user.userKey]  child:@"fiveIndicas"] setValue:@"false"];
    [[[[firebaseRef.ref  child:@"badges"] child:user.userKey]  child:@"fiveCheckIns"] setValue:@"false"];
    [[[[firebaseRef.ref  child:@"badges"] child:user.userKey]  child:@"fiveStoresVisited"] setValue:@"false"];
    [[[[firebaseRef.ref  child:@"badges"] child:user.userKey]  child:@"fiveStrainsTried"] setValue:@"false"];
    [[[[firebaseRef.ref  child:@"badges"] child:user.userKey]  child:@"fiveFriends"] setValue:@"false"];
    [[[[firebaseRef.ref  child:@"badges"] child:user.userKey]  child:@"fiveReviews"] setValue:@"false"];
    [[[[firebaseRef.ref  child:@"badges"] child:user.userKey]  child:@"fiveWishList"] setValue:@"false"];
    
//    [[[[firebaseRef.ref  child:@"checkIns"] child:user.userKey] child:@"checkInKey"] setValue:@"storeKey"];
//    [[[[[firebaseRef.ref  child:@"bookmarks"] child:user.userKey] child:@"stores"] child:@"storeKey"] setValue:@"true"];
//    [[[[[firebaseRef.ref  child:@"bookmarks"] child:user.userKey] child:@"strains"] child:@"strainKey"] setValue:@"true"];
//    [[[[firebaseRef.ref  child:@"friends"] child:user.userKey] child:@"friendKey"] setValue:@"true"];
//    [[[[firebaseRef.ref  child:@"strainsTried"] child:user.userKey] child:@"strainKey"] setValue:@"true"];
//    [[[[firebaseRef.ref  child:@"storesVisited"] child:user.userKey] child:@"storeKey"] setValue:@"true"];

}

- (IBAction)tappedCancelButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end







