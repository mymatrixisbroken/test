//
//  userClass.m
//  myProject
//
//  Created by Guy on 7/27/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "userClass.h"

userClass *user;

@implementation userClass
@synthesize user_key;
@synthesize email;
@synthesize username;
@synthesize date_joined;
@synthesize last_signed_in;
@synthesize account_type;
@synthesize avatarURL;
@synthesize wish_list ;
@synthesize friends;
@synthesize reviews;
@synthesize badges;
@synthesize strains_tried;
@synthesize stores_visited;
@synthesize checkIns;
@synthesize events;
@synthesize badgeCount;
@synthesize checkInCount;
@synthesize friendsCount;
@synthesize reviewsCount;
@synthesize storesVisitedCount;
@synthesize strainsTriedCount;
@synthesize wishListCount;



+ (userClass *)sharedInstance {
    static dispatch_once_t onceToken;
    static userClass *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[userClass alloc] init];
    });
    return instance;
}


- (id)init {
    self = [super init];
    if (self) {
        self.user_key = @"";
        self.email = @"";
        self.username = @"";
        self.date_joined = @"";
        self.last_signed_in = @"";
        self.account_type = @"user";
        self.avatarURL = @"";
        self.wish_list = [[NSArray alloc] init];
        self.friends = [[NSMutableArray alloc] init];
        self.reviews = [[NSArray alloc] init];
        self.badges = [[NSMutableArray alloc] init];
        self.strains_tried = [[NSArray alloc] init];
        self.stores_visited = [[NSArray alloc] init];
        self.events = [[NSMutableArray alloc] init];
        self.checkIns = [[NSMutableArray alloc] init];
        self.badgeCount = 0;
        self.checkInCount = 0;
        self.friendsCount = 0;
        self.reviewsCount = 0;
        self.storesVisitedCount = 0;
        self.strainsTriedCount = 0;
        self.wishListCount = 0;

    }
    return self;
}

-(id)createUser:(NSString *)createAccountEmail SignedUp:(NSString *)createAccountUsername{
    self.email = createAccountEmail;
    self.username = createAccountUsername;
    
    return self;
}

-(id)setClassObject:key Values:(NSDictionary *)dict :(NSArray *)array1 :(NSMutableArray *)array2 :(NSArray *)array3 :(NSArray *)array4 :(NSArray *)array5 :(NSArray *)array6{
    self.user_key = key;
    self.email = [dict valueForKey:@"email"];
    self.username = [dict valueForKey:@"username"];
    self.date_joined = [dict valueForKey:@"date_joined"];
    self.last_signed_in = [dict valueForKey:@"last_signed_in"];
    self.account_type = [dict valueForKey:@"account_type"];
    self.avatarURL = [dict valueForKey:@"avatar"];
    self.wish_list = array1;
    self.friends = array2;
    self.reviews = array3;
    self.strains_tried = array5;
    self.stores_visited = array6;
    self.badgeCount = array4.count;
    //self.checkInCount = array6.count;
    self.friendsCount = array2.count;
    self.reviewsCount = array3.count;
    self.storesVisitedCount = array6.count;
    self.strainsTriedCount = array5.count;
    self.wishListCount = array1.count;
    
    return self;
}

@end
