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
@synthesize image_name;
@synthesize wish_list ;
@synthesize friends;
@synthesize reviews;
@synthesize badges;
@synthesize strains_tried;
@synthesize stores_visited;
@synthesize events;


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
        self.image_name = @"";
        self.wish_list = [[NSArray alloc] init];
        self.friends = [[NSArray alloc] init];
        self.reviews = [[NSArray alloc] init];
        self.badges = [[NSArray alloc] init];
        self.strains_tried = [[NSArray alloc] init];
        self.stores_visited = [[NSArray alloc] init];
        self.events = [[NSMutableArray alloc] init];
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
    self.image_name = @"";
    self.wish_list = [[NSArray alloc] init];
    self.friends = [[NSArray alloc] init];
    self.reviews = [[NSArray alloc] init];
    self.badges = [[NSArray alloc] init];
    self.strains_tried = [[NSArray alloc] init];
    self.stores_visited = [[NSArray alloc] init];
    self.events = [[NSMutableArray alloc] init];

    
    return self;
}

-(id)setClassObject:key Values:(NSDictionary *)dict :(NSArray *)array1 :(NSArray *)array2 :(NSArray *)array3 :(NSArray *)array4 :(NSArray *)array5 :(NSArray *)array6{
    self.user_key = key;
    self.email = [dict valueForKey:@"email"];
    self.username = [dict valueForKey:@"username"];
    self.date_joined = [dict valueForKey:@"date_joined"];
    self.last_signed_in = [dict valueForKey:@"last_signed_in"];
    self.account_type = [dict valueForKey:@"account_type"];
    self.image_name = [dict valueForKey:@"image_name"];
    self.wish_list = array1;
    self.friends = array2;
    self.reviews = array3;
    self.badges = array4;
    self.strains_tried = array5;
    self.stores_visited = array6;
    
    return self;
}

@end
