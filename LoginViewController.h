//
//  SecondViewController.h
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userClass.h"
#import "strainClass.h"
#import "FirebaseReferenceClass.h"
@import Firebase;
@import JVFloatLabeledTextField;

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *SignInUsername;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *SignInPassword;
@property (strong, nonatomic) IBOutlet UIView *viewForButtonCreateAccount;
@property (strong, nonatomic) IBOutlet UIView *signInVIew;
@property (strong, nonatomic) IBOutlet UIButton *tappedSignUpButton;
@property (weak, nonatomic) IBOutlet UIButton *SignInButton;
@property (strong, nonatomic) IBOutlet NSMutableArray *queriesArray;
@property (strong, nonatomic) IBOutlet NSMutableDictionary *dict;


@end

