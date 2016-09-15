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
    [self setTextFields];
}

- (void) loadUserFromFirebaseDatabase {
    [firebaseRef.usersRef observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        NSDictionary *usersSnapshot = snapshot.value; //Creates a dictionary of of the JSON node strains
        NSArray *userKeys = [usersSnapshot allKeys]; //Creates an array with only the strain key uID
        
        for(int i=0; i<userKeys.count ; i++){
            NSString *key = userKeys[i];
            NSDictionary *userDict = [usersSnapshot valueForKey:key];
            if ([_SignInUsername.text isEqual:[userDict valueForKey:@"email"]]){
                NSArray *arr1 = [[userDict valueForKey:@"wishlist"] allKeys];
                NSArray *arr2 = [[userDict valueForKey:@"friends"] allKeys];
                NSArray *arr3 = [[userDict valueForKey:@"reviews"] allKeys];
                NSArray *arr4 = [[userDict valueForKey:@"badges"] allKeys];
                NSArray *arr5 = [[userDict valueForKey:@"strains_tried"] allKeys];
                NSArray *arr6 = [[userDict valueForKey:@"stores_visited"] allKeys];
                [user setClassObject:key Values:userDict :arr1 :arr2 :arr3 :arr4 :arr5 :arr6];
                user.user_key = key;
                user.email = [userDict valueForKey:@"email"];
                

                    
                [firebaseRef.eventsRef observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
                    NSLog(@"snapshot is %@",snapshot.value);
                    
                    NSArray *keys = [[snapshot.value allKeys] sortedArrayUsingSelector:@selector(compare:)];
                    for (NSString *key in keys) {
                        id value = [snapshot.value objectForKey:key];
                        NSString *strValue = value;
                        //NSLog(@"key is %@ => value is %@",key, value);
                        
                        NSString *firebasefriendkey = [value substringWithRange:NSMakeRange(0, 20)];
                        NSString *message = [value substringWithRange:NSMakeRange(20, (strValue.length-20))];
                        
                        for(int i=0; i<user.friends.count ; i++){
                            NSString *classfriendkey = [user.friends objectAtIndex:i];
                            
                            if ([classfriendkey isEqualToString:firebasefriendkey]) {
                                NSMutableDictionary *keyMessageDict = [[NSMutableDictionary alloc] init];
                                [keyMessageDict setValue:message forKey:firebasefriendkey];
                                
                                NSMutableDictionary *eventDict = [[NSMutableDictionary alloc] init];
                                [eventDict setObject:keyMessageDict forKey:key];
                                
                                [user.events addObject:eventDict];
                            }
                        }
                    }
                    
                    NSLog(@"user events is %@", user.events);
                }];
                break; //break out of userKeys loop
            }
        }
    }];
}



- (void) setTextFields {
    [_SignInUsername.layer addSublayer:[self customUITextField:70]];
    _SignInUsername.layer.masksToBounds = YES;
    [_SignInUsername becomeFirstResponder];
    
    //Custom format uiTextField
    [_SignInPassword.layer addSublayer:[self customUITextField:70]];
    _SignInPassword.layer.masksToBounds = YES;
    
    _SignInButton.enabled = NO;
    _SignInButton.alpha = 0.5;
    _SignInButton.contentEdgeInsets = UIEdgeInsetsMake(5, 22, 5, 0);

    [_signInVIew.layer addSublayer:[self customUITextField:75]];
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
    [self performSegueWithIdentifier:@"CreateAccountSegue" sender:self];
}

- (IBAction)SignInButtonTapped:(UIButton *)sender
{
    [[FIRAuth auth] signInWithEmail:_SignInUsername.text password:_SignInPassword.text completion:^(FIRUser *user, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
        }
        else {}
     }];
    
    [self loadUserFromFirebaseDatabase];
    
    
    FIRUser *userAuth = [FIRAuth auth].currentUser;
    if (userAuth.email != nil) {
        NSString *email = user.email;
        NSLog(@"Firebase User is signed in.");
        NSLog(@"Email:%@.",email);
        NSLog(@"key user description is %@ ",user.user_key);
        NSLog(@"key user description is %@ ",user.user_key);
        [self performSegueWithIdentifier:@"loginToProfileSegue" sender:self];
    }
    else {
        [self alertCouldNotSignInToFirebaseAuthorization];}
}
         
 -(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
     if([segue.identifier isEqualToString:@"loginToProfileSegue"]){
         //StrainProfileViewController *controller = (StrainProfileViewController *)segue.destinationViewController;
         //controller.user = _user;
         //controller.strain = _strain;
         
     }
 }
- (IBAction)cancelButtonTapped:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
    //[self.parentViewController.parentViewController dismissViewControllerAnimated:YES completion:^{}];
}

- (void) alertCouldNotSignInToFirebaseAuthorization {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Error Login"
                                          message:@"Username or password is incorrect."
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   NSLog(@"OK action");
                               }];
    
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end







