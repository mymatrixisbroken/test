//
//  strainClass.m
//  
//
//  Created by Guy on 7/25/16.
//
//

#import "strainClass.h"

strainClass *strain;

@implementation strainClass

@synthesize strain_key;
@synthesize strain_name;
@synthesize thc;
@synthesize cbd;
@synthesize species;
@synthesize grower;
@synthesize flavor;
@synthesize aroma;
@synthesize high_type;
@synthesize rating_score;
@synthesize rating_count;
@synthesize total_count;
@synthesize monthly_count;
@synthesize total_user_count;
@synthesize flower;
@synthesize concentrate;
@synthesize topical;
@synthesize edible;
@synthesize small_image;
@synthesize medium_image;
@synthesize strainObjectArray;

+ (strainClass *)sharedInstance {
    static dispatch_once_t onceToken;
    static strainClass *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[strainClass alloc] init];
    });
    return instance;
}


- (id)init {
    self = [super init];
    if (self) {
        self.strain_name = @"";
        self.thc = @"";
        self.cbd = @"";
        self.species = @"";
        self.grower = @"";
        self.flavor = @"";
        self.aroma = @"";
        self.high_type = @"";
        self.rating_count = 0;
        self.rating_score = 0;
        self.total_count = 0;
        self.monthly_count = 0;
        self.total_user_count = 0;
        self.flower = nil;
        self.concentrate = nil;
        self.topical = nil;
        self.edible = nil;
        self.small_image = nil;
        self.medium_image = nil;
        self.strainObjectArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(id)createEmptyStrainObject{
    self.strain_name = @"";
    self.thc = @"";
    self.cbd = @"";
    self.species = @"";
    self.grower = @"";
    self.flavor = @"";
    self.aroma = @"";
    self.high_type = @"";
    self.rating_count = 0;
    self.rating_score = 0;
    self.total_count = 0;
    self.monthly_count = 0;
    self.total_user_count = 0;
    self.flower = nil;
    self.concentrate = nil;
    self.topical = nil;
    self.edible = nil;
    self.small_image = nil;
    self.medium_image = nil;

    return self;
}


-(id)setClassObject:key Values:(NSDictionary *)dict {
    self.strain_key = key;
    self.strain_name = [dict valueForKey:@"strain_name"];
    self.thc = [dict valueForKey:@"THC"];
    self.cbd = [dict valueForKey:@"CBD"];
    self.species = [dict valueForKey:@"species"];
    self.grower = [dict valueForKey:@"grower"];
    self.flavor = [dict valueForKey:@"flavor"];
    self.aroma = [dict valueForKey:@"aroma"];
    self.high_type = [dict valueForKey:@"high_type"];
    self.rating_score = [[dict valueForKey:@"rating_score"] doubleValue];
    self.rating_count = [[dict valueForKey:@"rating_count"] integerValue];
    self.total_count = [[dict valueForKey:@"total_count"] integerValue];
    self.monthly_count = [[dict valueForKey:@"monthly_count"] integerValue];
    self.total_user_count = [[dict valueForKey:@"total_user_count"] integerValue];
    self.flower = [dict valueForKey:@"flower"];
    self.concentrate = [dict valueForKey:@"concentrate"];
    self.topical = [dict valueForKey:@"topical"];
    self.edible = [dict valueForKey:@"edible"];
    self.small_image = nil;

    return self;
}


@end
