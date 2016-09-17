//
//  storeClass.h
//  myProject
//
//  Created by Guy on 7/27/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class storeClass;
extern storeClass *store;


@interface storeClass : NSObject
@property NSString *store_key;
@property NSString *store_name;
@property NSString *address;
@property NSString *city;
@property NSString *state;
@property NSString *latitude;
@property NSString *longitude;
@property NSString *url;
@property NSString *phone_number;
@property NSString *google_place_id;
@property NSMutableArray *imageNames;
@property (nonatomic, assign) double rating_score;
@property (nonatomic, assign) int rating_count;
@property (nonatomic, assign) int total_count;
@property (nonatomic, assign) int monthly_count;
@property (nonatomic, assign) int total_user_count;
@property UIImage *small_image;
@property UIImage *medium_image;
@property NSMutableArray *storeObjectArray;


+ (storeClass *)sharedInstance;
-(id)setClassObject:key Values:(NSDictionary *)dict Image:(NSArray *)array;

@end
