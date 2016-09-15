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
    [self loadObjectInstance];
    [self signinFirebaseAnonymously];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) loadObjectInstance {
    strain = [strainClass sharedInstance];
    user = [userClass sharedInstance];
    store = [storeClass sharedInstance];
    objectsArray = [objectsArrayClass sharedInstance];
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
            [self loadStrains];
            [self loadStores];
        }
    }];
}

- (void) loadStrains {
    NSLog(@"Strain object dict");
    [firebaseRef.strainsRef observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        _strainObjectDictionary = snapshot.value; //Creates a dictionary of of the JSON node strains
        NSArray *keys = [_strainObjectDictionary allKeys]; //Creates an array with only the strain key uID
        
        for(int i=0; i<keys.count ; i++){
            NSString *key = keys[i];
            NSDictionary *dict = [_strainObjectDictionary valueForKey:key];
            
            //you have to delcare a new object instance to load table cells!!!!!!!!!!!!!!!!!!!
            strainClass *strainLoop = [[strainClass alloc] init];
            [strainLoop setClassObject:key Values:dict];
            [objectsArray.strainObjectArray addObject:strainLoop];
        }
    }];
}

- (void) loadStores {
    [firebaseRef.storesRef observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        NSLog(@"Store object dict");
        _storeObjectDictionary = snapshot.value; //Creates a dictionary of of the JSON node strains
        NSArray *keys = [_storeObjectDictionary allKeys]; //Creates an array with only the strain key uID
        
        for(int i=0; i<keys.count ; i++){
            NSString *key = keys[i];
            NSDictionary *dict = [_storeObjectDictionary valueForKey:key];
            
            //you have to delcare a new object instance to load table cells!!!!!!!!!!!!!!!!!!!
            storeClass *storeloop = [[storeClass alloc] init];
            [storeloop setClassObject:key Values:dict];
            [objectsArray.storeObjectArray addObject:storeloop];
        }
        [self performSegueWithIdentifier:@"successfulAnonymousLoginSegue" sender:self];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
