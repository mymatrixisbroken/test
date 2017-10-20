//
//  promoClass.m
//  myProject
//
//  Created by Guy on 9/20/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import "promoClass.h"

@implementation promoClass
@synthesize promoLikes;
@synthesize promoKey;
@synthesize promoText;
@synthesize promoDate;

- (id)init {
    self = [super init];
    if (self) {
        self.promoLikes = [[NSArray alloc] init];
    }
    return self;
}

@end
