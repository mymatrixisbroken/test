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
    [self setTextFields];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)tappedSignUp:(UIButton *)sender {
    if([self isValidUsername]){}
        else return;
    
    if([self isValidEmail]){}
        else return;
    
    if([self isValidPassword]){}
        else return;
    
    FIRDatabaseQuery *myTopPostsQuery = [[firebaseRef.usersRef queryOrderedByChild:@"username"] queryEqualToValue:_usernameField.text];
    
    [myTopPostsQuery observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        if ([NSNull null] == snapshot.value){
            user.userKey = [firebaseRef.usersRef childByAutoId].key;
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
            NSLog(@"username already taken");
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

- (void) getTodaysDate {
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    _todaysDate = [dateFormat stringFromDate:today];
}

- (CALayer *) customUITextField{
    CALayer *border = [CALayer layer];
    UIColor *selectedColor = [UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:205.0/255.0 alpha:1];
    CGFloat borderWidth = 2;
    border.borderColor = selectedColor.CGColor;
    border.frame = CGRectMake(0, frameSizeHeight - borderWidth, frameSizeWidth, frameSizeHeight);
    border.borderWidth = borderWidth;
    return border;
}

- (void) setTextFields {
    [_usernameField.layer addSublayer:[self customUITextField]];
    _usernameField.layer.masksToBounds = YES;
    [_usernameField becomeFirstResponder];
    
    [_emailField.layer addSublayer:[self customUITextField]];
    _emailField.layer.masksToBounds = YES;
    
    [_passwordField.layer addSublayer:[self customUITextField]];
    _passwordField.layer.masksToBounds = YES;
    
    _createAccountButton.enabled = NO;
    _createAccountButton.alpha = 0.5;
    _createAccountButton.contentEdgeInsets = UIEdgeInsetsMake(5, 22, 5, 0);
}

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

-(void) updateFirebaseDatabaseValues {
    [self getTodaysDate];
    [[[firebaseRef.usersRef child:user.userKey] child:@"email"] setValue:user.email];
    [[[firebaseRef.usersRef child:user.userKey] child:@"username"] setValue:user.username];
    [[[firebaseRef.usersRef child:user.userKey] child:@"dateJoined"] setValue:_todaysDate];
    [[[firebaseRef.usersRef child:user.userKey] child:@"lastSignedIn"] setValue:@""];
    [[[firebaseRef.usersRef child:user.userKey] child:@"accountType"] setValue:@"user"];
    [[[firebaseRef.usersRef child:user.userKey] child:@"wishList"] setValue:@""];
    [[[firebaseRef.usersRef child:user.userKey] child:@"friends"] setValue:@""];
    [[[firebaseRef.usersRef child:user.userKey] child:@"reviews"] setValue:@""];
    [[[firebaseRef.usersRef child:user.userKey] child:@"strainsTried"] setValue:@""];
    [[[firebaseRef.usersRef child:user.userKey] child:@"storesVisited"] setValue:@""];
    
    [[[[firebaseRef.usersRef child:user.userKey] child:@"badges"] child:@"fiveStevias"] setValue:@"false"];
    [[[[firebaseRef.usersRef child:user.userKey] child:@"badges"] child:@"fiveIndicas"] setValue:@"false"];
    [[[[firebaseRef.usersRef child:user.userKey] child:@"badges"] child:@"fiveCheckIns"] setValue:@"false"];
    [[[[firebaseRef.usersRef child:user.userKey] child:@"badges"] child:@"fiveStoresVisited"] setValue:@"false"];
    [[[[firebaseRef.usersRef child:user.userKey] child:@"badges"] child:@"fiveStrainsTried"] setValue:@"false"];
    [[[[firebaseRef.usersRef child:user.userKey] child:@"badges"] child:@"fiveFriends"] setValue:@"false"];
    [[[[firebaseRef.usersRef child:user.userKey] child:@"badges"] child:@"fiveReviews"] setValue:@"false"];
    [[[[firebaseRef.usersRef child:user.userKey] child:@"badges"] child:@"fiveWishList"] setValue:@"false"];
    
    [[[firebaseRef.usersRef child:user.userKey] child:@"badgeCount"] setValue:@""];
    [[[firebaseRef.usersRef child:user.userKey] child:@"checkInCount"] setValue:@""];
    [[[firebaseRef.usersRef child:user.userKey] child:@"friendsCount"] setValue:@""];
    [[[firebaseRef.usersRef child:user.userKey] child:@"reviewsCount"] setValue:@""];
    [[[firebaseRef.usersRef child:user.userKey] child:@"storesVisitedCount"] setValue:@""];
    [[[firebaseRef.usersRef child:user.userKey] child:@"strainsTriedCount"] setValue:@""];
    [[[firebaseRef.usersRef child:user.userKey] child:@"wishListCount"] setValue:@""];

}

- (IBAction)tappedCancelButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end







