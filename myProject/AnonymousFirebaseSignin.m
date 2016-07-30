//
//  FirstViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "AnonymousFirebaseSignin.h"

@interface AnonymousFirebaseSignin ()

@end

@implementation AnonymousFirebaseSignin

- (void)viewDidLoad {
    [super viewDidLoad];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [self signinFirebaseAnonymously];
        [self loadObjectInstance];

        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSegueWithIdentifier:@"successfulAnonymousLoginSegue" sender:self];
        });
    });
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) loadObjectInstance {
    strain = [strainClass sharedInstance];
    user = [userClass sharedInstance];
    store = [storeClass sharedInstance];
}

- (void) signinFirebaseAnonymously {
    [[FIRAuth auth] signInAnonymouslyWithCompletion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        if (error != nil) {
            // Uh-oh, an error occurred!
            NSLog(@"Anonymous Firebase User is NOT signed in..");
            NSLog(@"%@", error.localizedDescription);
        }
        else {
            //Assign current Firebase user to a variable called user
            FIRUser *user = [FIRAuth auth].currentUser;
            BOOL isAnonymous = user.anonymous;  // YES
            NSLog(@"Anonymous Firebase User is signed in.. ");
            NSLog(isAnonymous ? @"Yes" : @"No");
            NSLog(@"UID:%@.",user.uid);
            firebaseRef = [FirebaseReferenceClass sharedInstance];
            //NSLog(@"ref %@ strains %@ stores %@ users %@", firebaseRef.ref, firebaseRef.strainsRef, firebaseRef.storesRef, firebaseRef.usersRef);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
