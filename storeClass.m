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
@synthesize storeKey;
@synthesize storeName;
@synthesize address;
@synthesize city;
@synthesize state;
@synthesize latitude;
@synthesize longitude;
@synthesize distanceToMe;
@synthesize distanceValue;
@synthesize url;
@synthesize phone_number;
@synthesize googlePlaceID;
@synthesize imageNames;
@synthesize data;
@synthesize ratingCount;
@synthesize ratingScore;
@synthesize totalCount;
@synthesize monthlyCount;
@synthesize totalUserCount;


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
        self.storeKey = @"";
        self.storeName = @"";
        self.address = @"";
        self.city = @"";
        self.state = @"";
        self.latitude = @"";
        self.longitude = @"";
        self.url = @"";
        self.phone_number = @"";
        self.googlePlaceID = @"";
        self.ratingCount = 0;
        self.ratingScore = 0;
        self.totalCount = 0;
        self.monthlyCount = 0;
        self.totalUserCount = 0;
        self.data = [[NSData alloc] init];
        self.imageNames = [[NSMutableArray alloc] init];
    }
    return self;
}

-(id)setStoreObject:key
     fromDictionary:(NSDictionary *)dict
             images:(NSArray *)array{
    self.storeKey = key;
    self.storeName = [dict valueForKey:@"storeName"];
    self.address = [[dict valueForKey:@"location"]valueForKey:@"address"];
    self.city = [[dict valueForKey:@"location"] valueForKey:@"city"];
    self.state = [[dict valueForKey:@"location"]valueForKey:@"state"];
    self.latitude = [[dict valueForKey:@"location"] valueForKey:@"latitude"];
    self.longitude = [[dict valueForKey:@"location"]valueForKey:@"longitude"];
    self.url = [dict valueForKey:@"url"];
    self.phone_number = [dict valueForKey:@"phoneNumber"];
    self.imageNames = [NSMutableArray arrayWithArray:array];
    self.googlePlaceID = [dict valueForKey:@"googlePlaceID"];
    self.ratingScore = [[dict valueForKey:@"ratingScore"] doubleValue];
    if(![[dict valueForKey:@"ratingCount"] isEqual:@""]){
        self.ratingCount = [[[dict valueForKey:@"ratingCount"] allValues] count];
    }
    self.totalCount = [[dict valueForKey:@"totalCount"] integerValue];
    self.monthlyCount = [[dict valueForKey:@"monthlyCount"] integerValue];
    self.totalUserCount = [[dict valueForKey:@"totalUserCount"] integerValue];

    
    return self;
}


@end
