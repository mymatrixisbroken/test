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

@end

