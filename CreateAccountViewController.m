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
            user.user_key = [firebaseRef.usersRef childByAutoId].key;
            [user createUser:_emailField.text SignedUp:_usernameField.text];
            [self updateAnonymousUserToSignedUp:_passwordField.text];
            [self updateFirebaseDatabaseValues];
            
            if (user.user_key != nil) {
                [self performSegueWithIdentifier:@"createAccountToUserProfileSegue" sender:self];
            }
            else {
                NSLog(@"Failed to create account.");
            }
        }
        else if ([[snapshot.value allKeys] count] > 0) {
            NSLog(@"username already taken");
            [self usernameAlreadyTaken];
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
        [self alertInvalidUsername];
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
        [self alertInvalideEmail];
        return NO;
    }
}

-(BOOL)isValidPassword
{
    if( (_passwordField.text.length > 4)){
        return YES;
    }
    else{
        [self alertInvalidPassword];
        return NO;
    }
}

- (void) getTodaysDate {
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    _todays_date = [dateFormat stringFromDate:today];
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
    
    _CreateAccountNext.enabled = NO;
    _CreateAccountNext.alpha = 0.5;
    _CreateAccountNext.contentEdgeInsets = UIEdgeInsetsMake(5, 22, 5, 0);
}

- (IBAction)CreatePasswordChanged:(id)sender {
    if (_passwordField.text.length > 0) {
        _CreateAccountNext.enabled = YES;
        _CreateAccountNext.alpha = 1.0;
    }
    else{
        _CreateAccountNext.enabled = NO;
        _CreateAccountNext.alpha = 0.5;
    }
}

- (void) updateAnonymousUserToSignedUp:password{
    FIRUser *userAuth = [FIRAuth auth].currentUser;
    [userAuth updateEmail:user.email completion:^(NSError *_Nullable error) { }];
    [userAuth updatePassword:password completion:^(NSError *_Nullable error) { }];
}

-(void) updateFirebaseDatabaseValues {
    [self getTodaysDate];
    [[[firebaseRef.usersRef child:user.user_key] child:@"email"] setValue:user.email];
    [[[firebaseRef.usersRef child:user.user_key] child:@"username"] setValue:user.username];
    [[[firebaseRef.usersRef child:user.user_key] child:@"date_joined"] setValue:_todays_date];
    [[[firebaseRef.usersRef child:user.user_key] child:@"last_signed_in"] setValue:@""];
    [[[firebaseRef.usersRef child:user.user_key] child:@"account_type"] setValue:@"user"];
    [[[firebaseRef.usersRef child:user.user_key] child:@"wish_list"] setValue:@""];
    [[[firebaseRef.usersRef child:user.user_key] child:@"friends"] setValue:@""];
    [[[firebaseRef.usersRef child:user.user_key] child:@"reviews"] setValue:@""];
    [[[firebaseRef.usersRef child:user.user_key] child:@"badges"] setValue:@""];
    [[[firebaseRef.usersRef child:user.user_key] child:@"strains_tried"] setValue:@""];
    [[[firebaseRef.usersRef child:user.user_key] child:@"stores_visited"] setValue:@""];
    
}

- (IBAction)tappedCancelButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void) alertInvalidUsername {
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
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void) usernameAlreadyTaken {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Username taken"
                                          message:nil
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {}];
    
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void) alertInvalidPassword {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Invalid password"
                                          message:@"Please use minimum 5 characters"
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {}];
    
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void) alertInvalideEmail {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Invalid email"
                                          message:@"Please use format email@domain.com"
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {}];
    
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end







