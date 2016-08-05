//
//  FirstViewController.h
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICHObjectPrinter.h"
#import "userClass.h"
#import "strainClass.h"
#import "storeClass.h"
#import "objectsArrayClass.h"
#import "FirebaseReferenceClass.h"
@import Firebase;

@interface AnonymousFirebaseSignin : UIViewController
@property (strong, nonatomic) IBOutlet NSDictionary *storeObjectDictionary;
@property (strong, nonatomic) IBOutlet NSDictionary *strainObjectDictionary;

@end

