//
//  reviewClass.m
//  myProject
//
//  Created by Guy on 10/17/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "reviewClass.h"

@implementation reviewClass
@synthesize reviewKey;
@synthesize message;
@synthesize objectImageURL;
@synthesize objectKey;
@synthesize objectName;
@synthesize objectType;
@synthesize userKey;
@synthesize username;
@synthesize rating;
@synthesize objectDataString;
@synthesize objectData;


- (id)init {
    self = [super init];
    if (self) {
        self.reviewKey = @"";
        self.message = @"";
        self.objectImageURL = @"";
        self.objectKey = @"";
        self.objectName = @"";
        self.objectType = @"";
        self.userKey = @"";
        self.username = @"";
        self.rating = @"";
        self.objectDataString = @"";
        self.objectData = [[NSData alloc] init];
    }
    return self;
}


@end
