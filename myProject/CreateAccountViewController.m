//
//  SecondViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "SignUpViewController.h"
@import Firebase;

@interface SignUpViewController ()

@end

@implementation SignUpViewController
@synthesize Username, Password;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)isValidEmail:(NSString *)string
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:string];
}

-(BOOL)isValidPassword:(NSString *)string
{
    NSInteger characterCount = 4;
    return (string.length > characterCount);
}

- (IBAction)SignUpButtonTapped:(UIButton *)sender
{
    //variables
    NSString *errorMessage = nil;
    UITextField *errorField;
    NSString *storeUsername;
    NSString *storePassword;
    
    
    //Log Sign Up button tapped
    NSLog(@"Sign Up button tapped..");
    
    
    //Validate email@domain.com
    if([self isValidEmail:Username.text]){
        storeUsername = Username.text;
    }
    //Pop-up alert email is invalid
    else {
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"Oops!"
                                    message:@"Please use email@domain.com"
                                    preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"Dismiss"
                             style:UIAlertActionStyleCancel
                             handler:^(UIAlertAction * action){
                                 NSLog(@"User hit ok");
                             }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        NSLog(@"Username is not valid");
        return;
    }
    
    
    //Validate password is at least five characters
    if([self isValidPassword:Password.text]){
        storePassword = Password.text;
    }
    //Pop-up alert password is invalid
    else{
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"Oops!"
                                    message:@"Min 5 chars"
                                    preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"Dismiss"
                             style:UIAlertActionStyleCancel
                             handler:^(UIAlertAction * action){
                                 NSLog(@"User hit ok");
                             }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        NSLog(@"Password is not valid");
        return;
    }
    
    
    /////////////////////
    //Need to check if username signup is already listed in Firebase
    /////////////////////
    
    
    //Creates username and password in Firebase
    [[FIRAuth auth]
     createUserWithEmail:storeUsername
     password:storePassword
     completion:^(FIRUser *_Nullable user,
                  NSError *_Nullable error) {
         [self performSegueWithIdentifier:@"successfulLogin" sender:self];
     }];
    
}


@end
