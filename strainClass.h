//
//  strainClass.h
//  
//
//  Created by Guy on 7/25/16.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class strainClass;
extern strainClass *strain;

@interface strainClass : NSObject
@property NSString *strainKey;
@property NSString *strainName;
@property NSString *thc;
@property NSString *cbd;
@property NSString *species;
@property NSString *grower;
@property NSString *flavor;
@property NSString *aroma;
@property NSData *data;
@property NSMutableArray *imageNames;
@property NSMutableArray *availableAt;
@property NSInteger happiness;
@property NSInteger uplifting;
@property NSInteger euphoric;
@property NSInteger energetic;
@property NSInteger relaxed;
@property float ratingScore;
@property NSInteger ratingCount;
@property NSInteger totalCount;
@property NSInteger monthlyCount;
@property NSInteger totalUserCount;
@property BOOL flower;
@property BOOL concentrate;
@property BOOL topical;
@property BOOL edible;


+ (strainClass *)sharedInstance;
-(id)setStrainObject:key
      fromDictionary:(NSDictionary *)dict
            highType:(NSDictionary *)dict2
              images:(NSArray *)array
         availableAt:(NSArray *)array2
         ratingCount:(NSInteger)count
         ratingScore:(float) score;
@end
