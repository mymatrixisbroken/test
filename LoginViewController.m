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
    _array = [[NSMutableArray alloc] init];
    _dict = [[NSMutableDictionary alloc] init];
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
                NSArray *arr1 = [[NSMutableArray alloc] init];
                if (!([[userDict valueForKey:@"reviews"]  isEqual: @""])) {
                    arr1 = [[userDict valueForKey:@"wishlist"] allKeys];
                }
                __block NSMutableArray *arr2 = [[NSMutableArray alloc] init];
                
                NSArray *arr3 = [[NSMutableArray alloc] init];
                if (!([[userDict valueForKey:@"reviews"]  isEqual: @""])) {
                    arr3 = [[userDict valueForKey:@"reviews"] allKeys];
                }
                
                NSArray *arr4 = [[NSMutableArray alloc] init];
                if (!([[userDict valueForKey:@"badges"]  isEqual: @""])) {
                    arr4 = [[userDict valueForKey:@"badges"] allKeys];
                }
                
                NSArray *arr5 = [[NSMutableArray alloc] init];
                if (!([[userDict valueForKey:@"strains_tried"]  isEqual: @""])) {
                    arr5 = [[userDict valueForKey:@"strains_tried"] allKeys];
                }
                
                NSArray *arr6 = [[NSMutableArray alloc] init];
                if (!([[userDict valueForKey:@"stores_visited"]  isEqual: @""])) {
                    arr6 = [[userDict valueForKey:@"stores_visited"] allKeys];
                }
                [user setClassObject:key Values:userDict :arr1 :arr2 :arr3 :arr4 :arr5 :arr6];
                user.user_key = key;
                user.email = [userDict valueForKey:@"email"];
                
                FIRDatabaseQuery *friendsQuery = [[[firebaseRef.usersRef child:key] child:@"friends"] queryOrderedByKey];
                [friendsQuery observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
                    if (![snapshot.value isEqual:@""]) {
                        NSArray *keys = [snapshot.value allKeys];
                        NSArray *sortedKeys = [keys sortedArrayUsingSelector:@selector(compare:)];
                        
                        for (id key in sortedKeys) {
                            [arr2 addObject:key];
                        }
                        [self newLoadEventsFromFirebaseDatabse];
                    }
                    else{
                        [self performSegueWithIdentifier:@"loginToProfileSegue" sender:self];
                    }
                }];
            }
        }
    }];
}

-(void) newLoadEventsFromFirebaseDatabse{
    for (int i = 0; i<[user.friends count]; i++) {
        FIRDatabaseQuery *eventQuery = [[firebaseRef.eventsRef queryOrderedByChild:@"uid"] queryEqualToValue:[user.friends objectAtIndex:i]];
        [_array addObject:eventQuery];
    }
    
    for (int i = 0; i<_array.count; i++) {
        [[_array objectAtIndex:i] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            if (snapshot.value == [NSNull null]) {}
            else{
                [user.events removeAllObjects];
                [_dict addEntriesFromDictionary:snapshot.value];
                
                NSArray *keys = [_dict allKeys];
                NSArray *sortedKeys = [keys sortedArrayUsingSelector:@selector(compare:)];
                
                for (id key in sortedKeys) {
                    NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
                    NSMutableDictionary *value = [[NSMutableDictionary alloc] init];
                    value = [_dict valueForKey:key];
                    [tempDict setObject:value forKey:key ];
                    [user.events addObject:tempDict];
                }
                [self performSegueWithIdentifier:@"loginToProfileSegue" sender:self];
            }
        }];
    }
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

- (IBAction)SignInButtonTapped:(UIButton *)sender{
    [[FIRAuth auth] signInWithEmail:_SignInUsername.text password:_SignInPassword.text completion:^(FIRUser *user, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
            [self alertCouldNotSignInToFirebaseAuthorization];
        }
        else {
            [self loadUserFromFirebaseDatabase];
        }
     }];
}

- (IBAction)cancelButtonTapped:(UIBarButtonItem *)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"News Feed Navigation SB ID"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:NULL];
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







