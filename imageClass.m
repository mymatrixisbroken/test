//
//  imageClass.m
//  myProject
//
//  Created by Guy on 10/21/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "imageClass.h"

@implementation imageClass
@synthesize imageURL;
@synthesize imageThumbsUp;
@synthesize imageThumbsDown;
@synthesize voteScore;
@synthesize firebaseIndex;
@synthesize data;
@synthesize dataString;

- (id)init {
    self = [super init];
    if (self) {
        self.imageURL = @"";
        self.imageThumbsUp = [[NSMutableArray alloc] init];
        self.imageThumbsDown = [[NSMutableArray alloc] init];
        self.voteScore = 0;
        self.firebaseIndex = 0;
        self.data = [[NSData alloc] init];
        self.dataString = @"";
    }
    return self;
}

@end
