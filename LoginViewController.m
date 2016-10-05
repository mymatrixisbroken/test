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
    _queriesArray = [[NSMutableArray alloc] init];
    _dict = [[NSMutableDictionary alloc] init];
    [self setTextFields];
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
                
                NSMutableArray *array1 = [[NSMutableArray alloc] init];
                if (!([[userDict valueForKey:@"badges"]  isEqual: @""])) {
                    NSMutableDictionary *dict = [userDict valueForKey:@"badges"];
                    for (id key in dict) {
                        NSString *value = [dict valueForKey:key];
                        if ([value isEqualToString:@"true"]) {
                            [array1 addObject:key];
                        }
                    }
                }

                NSMutableArray *array2 = [[NSMutableArray alloc] init];
                if (!([[userDict valueForKey:@"checkIns"]  isEqual: @""])) {
                    array2 = [NSMutableArray arrayWithArray:[[userDict valueForKey:@"checkIns"] allKeys]];
                }
                
                NSMutableArray *array3 = [[NSMutableArray alloc] init];
                if (!([[userDict valueForKey:@"friends"]  isEqual: @""])) {
                    NSArray *keys = [[userDict valueForKey:@"friends"] allKeys];
                    NSArray *sortedKeys = [keys sortedArrayUsingSelector:@selector(compare:)];
                    array3 = [NSMutableArray arrayWithArray:sortedKeys];
                }

                NSMutableArray *array4 = [[NSMutableArray alloc] init];
                if (!([[userDict valueForKey:@"reviews"]  isEqual: @""])) {
                    array4 = [NSMutableArray arrayWithArray:[[userDict valueForKey:@"reviews"] allKeys]];
                }

                NSMutableArray *array5 = [[NSMutableArray alloc] init];
                if (!([[userDict valueForKey:@"storesVisited"]  isEqual: @""])) {
                    array5 = [NSMutableArray arrayWithArray:[[userDict valueForKey:@"storesVisited"] allKeys]];
                }

                NSMutableArray *array6 = [[NSMutableArray alloc] init];
                if (!([[userDict valueForKey:@"strainsTried"]  isEqual: @""])) {
                    array6 = [NSMutableArray arrayWithArray:[[userDict valueForKey:@"strainsTried"] allKeys]];
                }

                NSMutableArray *array7 = [[NSMutableArray alloc] init];
                if (!([[userDict valueForKey:@"wishList"]  isEqual: @""])) {
                    array7 = [NSMutableArray arrayWithArray:[[userDict valueForKey:@"wishList"] allKeys]];
                }
                
                [user setUserObject:key
                     fromDictionary:userDict
                             badges:array1
                           checkIns:array2
                            friends:array3
                            reviews:array4
                      storesVisited:array5
                       strainsTried:array6
                           wishList:array7];
                
                [self getAvatarURLData];
            }
        }
    }];
}

-(void) getAvatarURLData{
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:user.avatarURL]];
        if( data == nil ){
            NSLog(@"image is nil");
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            user.data = data;
            [user goToCurrentUserProfileViewController:self];

        });
    });
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







