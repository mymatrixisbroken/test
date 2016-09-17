//
//  storeClass.m
//
//
//  Created by Guy on 7/25/16.
//
//

#import "storeClass.h"

storeClass *store;

@implementation storeClass
@synthesize store_key;
@synthesize store_name;
@synthesize address;
@synthesize city;
@synthesize state;
@synthesize latitude;
@synthesize longitude;
@synthesize url;
@synthesize phone_number;
@synthesize google_place_id;
@synthesize imageNames;
@synthesize rating_count;
@synthesize rating_score;
@synthesize total_count;
@synthesize monthly_count;
@synthesize total_user_count;
@synthesize small_image;
@synthesize medium_image;
@synthesize storeObjectArray;


+ (storeClass *)sharedInstance {
    static dispatch_once_t onceToken;
    static storeClass *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[storeClass alloc] init];
    });
    return instance;
}


- (id)init {
    self = [super init];
    if (self) {
        self.store_key = store_key;
        self.store_name = @"";
        self.address = @"";
        self.city = @"";
        self.state = @"";
        self.latitude = @"";
        self.longitude = @"";
        self.url = @"";
        self.phone_number = @"";
        self.google_place_id = @"";
        self.rating_count = 0;
        self.rating_score = 0;
        self.total_count = 0;
        self.monthly_count = 0;
        self.total_user_count = 0;
        self.small_image = nil;
        self.medium_image = nil;
        self.imageNames = [[NSMutableArray alloc] init];
        self.storeObjectArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(id)setClassObject:key Values:(NSDictionary *)dict Image:(NSArray *)array{
    self.store_key = key;
    self.store_name = [dict valueForKey:@"store_name"];
    self.address = [[dict valueForKey:@"location"]valueForKey:@"address"];
    self.city = [[dict valueForKey:@"location"] valueForKey:@"city"];
    self.state = [[dict valueForKey:@"location"]valueForKey:@"state"];
    self.latitude = [dict valueForKey:@"latitude"];
    self.longitude = [dict valueForKey:@"longitude"];
    self.url = [dict valueForKey:@"url"];
    self.phone_number = [dict valueForKey:@"phone_number"];
    self.imageNames = [NSMutableArray arrayWithArray:array];
    self.longitude = [dict valueForKey:@"google_place_id"];
    self.rating_score = [[dict valueForKey:@"rating_score"] doubleValue];
    self.rating_count = [[dict valueForKey:@"rating_count"] integerValue];
    self.total_count = [[dict valueForKey:@"total_count"] integerValue];
    self.monthly_count = [[dict valueForKey:@"monthly_count"] integerValue];
    self.total_user_count = [[dict valueForKey:@"total_user_count"] integerValue];
    self.small_image = nil;
    
    return self;
}


@end
