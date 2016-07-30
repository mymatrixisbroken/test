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
@synthesize wish_list ;
@synthesize friends;
@synthesize reviews;
@synthesize badges;
@synthesize strains_tried;
@synthesize stores_visited;
@synthesize avatar;


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
        self.wish_list = [[NSMutableArray alloc] init];
        self.friends = [[NSMutableArray alloc] init];
        self.reviews = [[NSMutableArray alloc] init];
        self.badges = [[NSMutableArray alloc] init];
        self.strains_tried = [[NSMutableArray alloc] init];
        self.stores_visited = [[NSMutableArray alloc] init];
        self.avatar = nil;
    }
    return self;
}


-(id)createEmptyUserObject{
    self.user_key = @"";
    self.email = @"";
    self.username = @"";
    self.date_joined = @"";
    self.last_signed_in = @"";
    self.account_type = @"user";
    self.wish_list = [[NSMutableArray alloc] init];
    self.friends = [[NSMutableArray alloc] init];
    self.reviews = [[NSMutableArray alloc] init];
    self.badges = [[NSMutableArray alloc] init];
    self.strains_tried = [[NSMutableArray alloc] init];
    self.stores_visited = [[NSMutableArray alloc] init];
    self.avatar = nil;
    
    return self;
}

-(id)setClassObject:key Values:(NSDictionary *)dict :(NSMutableArray *)array1 :(NSMutableArray *)array2 :(NSMutableArray *)array3 :(NSMutableArray *)array4 :(NSMutableArray *)array5 :(NSMutableArray *)array6{
    self.user_key = key;
    self.email = [dict valueForKey:@"email"];
    self.username = [dict valueForKey:@"username"];
    self.date_joined = [dict valueForKey:@"date_joined"];
    self.last_signed_in = [dict valueForKey:@"last_signed_in"];
    self.account_type = [dict valueForKey:@"account_type"];
    self.wish_list = array1;
    self.friends = array2;
    self.reviews = array3;
    self.badges = array4;
    self.strains_tried = array5;
    self.stores_visited = array6;
    self.avatar = nil;
    
    return self;
}

@end
