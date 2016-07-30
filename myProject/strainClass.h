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
@property NSString *strain_key;
@property NSString *strain_name;
@property NSString *thc;
@property NSString *cbd;
@property NSString *species;
@property NSString *grower;
@property NSString *flavor;
@property NSString *aroma;
@property NSString *high_type;
@property (nonatomic, assign) double rating_score;
@property (nonatomic, assign) int rating_count;
@property (nonatomic, assign) int total_count;
@property (nonatomic, assign) int monthly_count;
@property (nonatomic, assign) int total_user_count;
@property BOOL flower;
@property BOOL concentrate;
@property BOOL topical;
@property BOOL edible;
@property UIImage *small_image;
@property UIImage *medium_image;
@property NSMutableArray *strainObjectArray;


+ (strainClass *)sharedInstance;
-(id) createEmptyStrainObject;
-(id)setClassObject:key Values:(NSDictionary *)dict;

@end
