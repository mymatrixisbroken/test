//
//  eventClass.m
//  myProject
//
//  Created by Guy on 10/3/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "activityClass.h"

activityClass *activity;

@implementation activityClass
@synthesize activityKey;
@synthesize objectKey;
@synthesize objectName;
@synthesize userImageKey;
@synthesize userImageLink;
@synthesize objectImagesArray;
@synthesize objectRating;
@synthesize objectReviewCount;
@synthesize userKey;
@synthesize userID;
@synthesize username;
@synthesize instantiationMessage;
@synthesize instantiationRating;
@synthesize message;
//@synthesize userAvatarURL;
@synthesize userAvatarData;
@synthesize activityType;
//@synthesize objectURL;
@synthesize objectData;
@synthesize reviewRating;
@synthesize reviewMessage;
@synthesize likes;
@synthesize comments;
@synthesize userImageData;

+ (activityClass *)sharedInstance {
    static dispatch_once_t onceToken;
    static activityClass *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[activityClass alloc] init];
    });
    return instance;
}


- (id)init {
    self = [super init];
    if (self) {
        self.activityKey = @"";
        self.userID = @"";
        self.username = @"";
        self.message = @"";
//        self.userAvatarURL = @"";
        self.activityType = @"";
        self.objectName = @"";
//        self.objectRating = @"";
//        self.objectURL = @"";
        self.objectData = [[NSData alloc] init];
        self.reviewRating = @"";
        self.reviewMessage = @"";
        self.userImageLink = [[NSMutableArray alloc] init];
        self.userImageKey = [[NSMutableArray alloc] init];
        self.objectImagesArray = [[NSMutableArray alloc] init];
        self.likes = [[NSMutableArray alloc] init];
        self.comments = [[NSMutableArray alloc] init];
        self.userImageData = [[NSData alloc] init];
    }
    return self;
}


@end
