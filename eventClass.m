//
//  eventClass.m
//  myProject
//
//  Created by Guy on 10/3/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "eventClass.h"

eventClass *event;

@implementation eventClass
@synthesize eventKey;
@synthesize userID;
@synthesize username;
@synthesize message;
@synthesize userAvatarURL;
@synthesize likes;
@synthesize comments;
@synthesize imageData;

+ (eventClass *)sharedInstance {
    static dispatch_once_t onceToken;
    static eventClass *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[eventClass alloc] init];
    });
    return instance;
}


- (id)init {
    self = [super init];
    if (self) {
        self.eventKey = @"";
        self.userID = @"";
        self.username = @"";
        self.message = @"";
        self.userAvatarURL = @"";
        self.likes = @"user";
        self.comments = @"";
        self.imageData = [[NSData alloc] init];
    }
    return self;
}


@end
