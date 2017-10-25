//
//  bookmarkClass.m
//  myProject
//
//  Created by Guy on 10/23/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import "bookmarkClass.h"

@implementation bookmarkClass
@synthesize bookmarkName;
@synthesize bookmarkRating;
@synthesize bookmarkReviewCount;
@synthesize bookmarkImageLink;

- (id)init {
    self = [super init];
    if (self) {
        self.bookmarkImageLink = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
