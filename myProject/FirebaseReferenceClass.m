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
    }
    return self;
}

@end
