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
@property int happiness;
@property int uplifting;
@property int euphoric;
@property int energetic;
@property int relaxed;
@property NSMutableArray *imageNames;
@property (nonatomic, assign) double rating_score;
@property int rating_count;
@property int total_count;
@property int monthly_count;
@property int total_user_count;
@property BOOL flower;
@property BOOL concentrate;
@property BOOL topical;
@property BOOL edible;


+ (strainClass *)sharedInstance;
-(id)setClassObject:key Values:(NSDictionary *)dict Image:(NSArray *) array highType:(NSDictionary *)dict2;
@end
