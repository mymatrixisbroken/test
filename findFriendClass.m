//
//  findFriendClass.m
//  myProject
//
//  Created by Guy on 9/16/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "findFriendClass.h"

findFriendClass *tempFriend;

@implementation findFriendClass
@synthesize key;
@synthesize username;
@synthesize avatarDataString;
@synthesize avatarData;

+ (findFriendClass *)sharedInstance {
    static dispatch_once_t onceToken;
    static findFriendClass *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[findFriendClass alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        self.key = @"";
        self.username = @"";
        self.avatarDataString = @"";
        self.avatarData = [[NSData alloc] init];
    }
    return self;
}

-(id)set:(NSString *)uid
    user:(NSString *)name
   image:(NSString *)dataString{
    self.key = uid;
    self.username = name;
    self.avatarDataString = dataString;
    
    return self;
}

@end
