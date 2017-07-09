//
//  SecondViewController.h
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userClass.h"
#import "FirebaseReferenceClass.h"
@import Firebase;
@import JVFloatLabeledTextField;

@interface CreateAccountViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *createAccountButton;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *emailField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *passwordField;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *usernameField;
@property (weak, nonatomic) IBOutlet NSString* todaysDate;
@property (strong, nonatomic) IBOutlet UIView *termsView;
@property (strong, nonatomic) IBOutlet UIView *createAccountView;
@property (strong, nonatomic) IBOutlet UIView *fieldsView;
@property (strong, nonatomic) IBOutlet CAGradientLayer *gradientMask;

@end

