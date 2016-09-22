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
@synthesize happiness;
@synthesize uplifting;
@synthesize euphoric;
@synthesize energetic;
@synthesize relaxed;
@synthesize imageNames;
@synthesize data;
@synthesize availableAt;
@synthesize rating_score;
@synthesize rating_count;
@synthesize total_count;
@synthesize monthly_count;
@synthesize total_user_count;
@synthesize flower;
@synthesize concentrate;
@synthesize topical;
@synthesize edible;

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
        self.happiness = 0;
        self.uplifting = 0;
        self.euphoric = 0;
        self.energetic = 0;
        self.relaxed = 0;
        self.imageNames = [[NSMutableArray alloc] init];
        self.data = [[NSData alloc] init];
        self.availableAt = [[NSMutableArray alloc] init];
        self.rating_count = 0;
        self.rating_score = 0.0;
        self.total_count = 0;
        self.monthly_count = 0;
        self.total_user_count = 0;
        self.flower = 0;
        self.concentrate = 0;
        self.topical = 0;
        self.edible = 0;
    }
    return self;
}

-(id)setClassObject:key Values:(NSDictionary *)dict Image:(NSArray *) array highType:(NSDictionary *)dict2 :(NSInteger)x :(float)y :(NSArray *)array2{
    self.strain_key = key;
    self.strain_name = [dict valueForKey:@"strain_name"];
    self.thc = [dict valueForKey:@"THC"];
    self.cbd = [dict valueForKey:@"CBD"];
    self.species = [dict valueForKey:@"species"];
    self.grower = [dict valueForKey:@"grower"];
    self.flavor = [dict valueForKey:@"flavor"];
    self.aroma = [dict valueForKey:@"aroma"];
    self.happiness = [[dict2 valueForKey:@"happiness"] intValue];
    self.uplifting = [[dict2 valueForKey:@"uplifting"] intValue];
    self.euphoric = [[dict2 valueForKey:@"euphoric"] intValue];
    self.energetic = [[dict2 valueForKey:@"energetic"] intValue];
    self.relaxed = [[dict2 valueForKey:@"relaxed"] intValue];
    self.imageNames = [NSMutableArray arrayWithArray:array];
    self.availableAt = [NSMutableArray arrayWithArray:array2];
    self.rating_score = y;
    self.rating_count = x;
    self.total_count = [[dict valueForKey:@"total_count"] integerValue];
    self.monthly_count = [[dict valueForKey:@"monthly_count"] integerValue];
    self.total_user_count = [[dict valueForKey:@"total_user_count"] integerValue];
    self.flower = [dict valueForKey:@"flower"];
    self.concentrate = [dict valueForKey:@"concentrate"];
    self.topical = [dict valueForKey:@"topical"];
    self.edible = [dict valueForKey:@"edible"];

    return self;
}


@end
