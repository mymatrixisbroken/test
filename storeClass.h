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
@property NSString *storeKey;
@property NSString *storeName;
@property NSString *address;
@property NSString *city;
@property NSString *state;
@property NSString *latitude;
@property NSString *longitude;
@property NSString *url;
@property NSString *phone_number;
@property NSString *googlePlaceID;
@property NSMutableArray *imageNames;
@property NSData *data;
@property (nonatomic, assign) float ratingScore;
@property (nonatomic, assign) NSInteger ratingCount;
@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, assign) NSInteger monthlyCount;
@property (nonatomic, assign) NSInteger totalUserCount;


+ (storeClass *)sharedInstance;
-(id)setStoreObject:key
     fromDictionary:(NSDictionary *)dict
             images:(NSArray *)array;
@end
