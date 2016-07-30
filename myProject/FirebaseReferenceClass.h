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

@property(strong, nonatomic) FIRStorage *storage;
@property(strong, nonatomic) FIRStorageReference *storageRef;
@property(strong, nonatomic) FIRStorageReference *stores_small_images_ref;
@property(strong, nonatomic) FIRStorageReference *stores_medium_images_ref;
@property(strong, nonatomic) FIRStorageReference *strains_small_images_ref;
@property(strong, nonatomic) FIRStorageReference *strains_medium_images_ref;

+ (FirebaseReferenceClass *)sharedInstance;

@end
