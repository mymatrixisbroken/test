//
//  reviewClassNew.m
//  myProject
//
//  Created by Guy on 9/27/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import "reviewClassNew.h"

@implementation reviewClassNew
@synthesize reviewKey;
@synthesize authoredByUserKey;
@synthesize authoredByUsername;
@synthesize objectType;
@synthesize objectKey;
@synthesize objectName;
@synthesize objectImageLink;
@synthesize objectRating;
@synthesize objectReviewCount;
@synthesize message;
@synthesize rating;
@synthesize userImageLink;

- (id)init {
    self = [super init];
    if (self) {
        self.userImageLink = [[NSMutableArray alloc] init];
        self.objectImageLink = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
