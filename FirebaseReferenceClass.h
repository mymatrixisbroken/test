//
//  FirebaseReferenceClass.h
//  myProject
//
//  Created by Guy on 7/28/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Firebase;

@class FirebaseReferenceClass;
extern FirebaseReferenceClass *firebaseRef;

@interface FirebaseReferenceClass : NSObject
@property(strong, nonatomic) FIRDatabaseReference *ref;
@property(strong, nonatomic) FIRDatabaseReference *usersRef;
@property(strong, nonatomic) FIRDatabaseReference *strainsRef;
@property(strong, nonatomic) FIRDatabaseReference *storesRef;
@property(strong, nonatomic) FIRDatabaseReference *reviewsRef;
@property(strong, nonatomic) FIRDatabaseReference *eventsRef;

+ (FirebaseReferenceClass *)sharedInstance;

@end
