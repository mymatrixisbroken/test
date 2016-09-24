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

@synthesize strainKey;
@synthesize strainName;
@synthesize thc;
@synthesize cbd;
@synthesize species;
@synthesize grower;
@synthesize flavor;
@synthesize aroma;
@synthesize data;
@synthesize imageNames;
@synthesize availableAt;
@synthesize happiness;
@synthesize uplifting;
@synthesize euphoric;
@synthesize energetic;
@synthesize relaxed;
@synthesize ratingScore;
@synthesize ratingCount;
@synthesize totalCount;
@synthesize monthlyCount;
@synthesize totalUserCount;
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
        self.strainName = @"";
        self.thc = @"";
        self.cbd = @"";
        self.species = @"";
        self.grower = @"";
        self.flavor = @"";
        self.aroma = @"";
        self.data = [[NSData alloc] init];
        self.imageNames = [[NSMutableArray alloc] init];
        self.availableAt = [[NSMutableArray alloc] init];
        self.happiness = 0;
        self.uplifting = 0;
        self.euphoric = 0;
        self.energetic = 0;
        self.relaxed = 0;
        self.ratingCount = 0;
        self.ratingScore = 0.0;
        self.totalCount = 0;
        self.monthlyCount = 0;
        self.totalUserCount = 0;
        self.flower = 0;
        self.concentrate = 0;
        self.topical = 0;
        self.edible = 0;
    }
    return self;
}

-(id)setStrainObject:key
      fromDictionary:(NSDictionary *)dict
            highType:(NSDictionary *)dict2
              images:(NSArray *)array
         availableAt:(NSArray *)array2
         ratingCount:(NSInteger)count
         ratingScore:(float) score{
    self.strainKey = key;
    self.strainName = [dict valueForKey:@"strainName"];
    self.thc = [dict valueForKey:@"thc"];
    self.cbd = [dict valueForKey:@"cbd"];
    self.species = [dict valueForKey:@"species"];
    self.grower = [dict valueForKey:@"grower"];
    self.flavor = [dict valueForKey:@"flavor"];
    self.aroma = [dict valueForKey:@"aroma"];
    self.imageNames = [NSMutableArray arrayWithArray:array];
    self.availableAt = [NSMutableArray arrayWithArray:array2];
    self.happiness = [[dict2 valueForKey:@"happiness"] integerValue];
    self.uplifting = [[dict2 valueForKey:@"uplifting"] integerValue];
    self.euphoric = [[dict2 valueForKey:@"euphoric"] integerValue];
    self.energetic = [[dict2 valueForKey:@"energetic"] integerValue];
    self.relaxed = [[dict2 valueForKey:@"relaxed"] integerValue];
    self.ratingCount = count;
    self.ratingScore = score;
    self.totalCount = [[dict valueForKey:@"totalCount"] integerValue];
    self.monthlyCount = [[dict valueForKey:@"monthlyCount"] integerValue];
    self.totalUserCount = [[dict valueForKey:@"totalUserCount"] integerValue];
    self.flower = [[dict valueForKey:@"flower"] boolValue];
    self.concentrate = [[dict valueForKey:@"concentrate"] boolValue];
    self.topical = [[dict valueForKey:@"topical"] boolValue];
    self.edible = [[dict valueForKey:@"edible"] boolValue];

    return self;
}


@end
