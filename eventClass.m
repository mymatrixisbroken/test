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
//@synthesize userAvatarURL;
@synthesize userAvatarData;
@synthesize eventType;
@synthesize objectName;
@synthesize objectRating;
//@synthesize objectURL;
@synthesize objectData;
@synthesize reviewRating;
@synthesize reviewMessage;
@synthesize likes;
@synthesize comments;
@synthesize userImageData;

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
//        self.userAvatarURL = @"";
        self.eventType = @"";
        self.objectName = @"";
        self.objectRating = @"";
//        self.objectURL = @"";
        self.objectData = [[NSData alloc] init];
        self.reviewRating = @"";
        self.reviewMessage = @"";
        self.likes = [[NSMutableArray alloc] init];
        self.comments = [[NSMutableArray alloc] init];
        self.userImageData = [[NSData alloc] init];
    }
    return self;
}


@end
