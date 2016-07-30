//
//  FirebaseReferenceClass.m
//  myProject
//
//  Created by Guy on 7/28/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "FirebaseReferenceClass.h"

FirebaseReferenceClass *firebaseRef;

@implementation FirebaseReferenceClass
@synthesize ref;
@synthesize usersRef;
@synthesize strainsRef;
@synthesize storesRef;
@synthesize reviewsRef;
@synthesize storage;
@synthesize storageRef;
@synthesize stores_small_images_ref;
@synthesize stores_medium_images_ref;
@synthesize strains_small_images_ref;
@synthesize strains_medium_images_ref;

+ (FirebaseReferenceClass *)sharedInstance {
    static dispatch_once_t onceToken;
    static FirebaseReferenceClass *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[FirebaseReferenceClass alloc] init];
    });
    return instance;
}


- (id)init {
    self = [super init];
    if (self) {
         self.ref = [[FIRDatabase database] reference];
         self.usersRef = [self.ref child:@"users"];
         self.strainsRef= [self.ref child:@"strains"];
         self.storesRef= [self.ref child:@"stores"];
         self.reviewsRef = [self.ref child:@"reviews"];

         self.storage = [FIRStorage storage];
         self.storageRef = [storage referenceForURL:@"gs://test-ba43e.appspot.com"];
         self.stores_small_images_ref = [[[storageRef child:@"images" ] child:@"stores" ] child:@"small_images"];
         self.stores_medium_images_ref = [[[storageRef child:@"images" ] child:@"stores" ] child:@"medium_images"];
         self.strains_small_images_ref = [[[storageRef child:@"images" ] child:@"strains" ] child:@"small_images"];
         self.strains_medium_images_ref = [[[storageRef child:@"images" ] child:@"strains" ] child:@"medium_images"];
    }
    return self;
}

@end
