//
//  userClass.h
//  myProject
//
//  Created by Guy on 7/27/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class userClass;
extern userClass *user;

@interface userClass : NSObject
@property NSString *user_key;
@property NSString *email;
@property NSString *username;
@property NSString *date_joined;
@property NSString *last_signed_in;
@property NSString *account_type;
@property NSString *image_name;
@property NSArray *wish_list;
@property NSMutableArray *friends;
@property NSArray *reviews;
@property NSArray *badges;
@property NSArray *strains_tried;
@property NSArray *stores_visited;
@property NSMutableArray *events;

+ (userClass *)sharedInstance;
-(id)createUser:(NSString *)createAccountEmail SignedUp:(NSString *)createAccountUsername;
-(id)setClassObject:key Values:(NSDictionary *)dict :(NSArray *) array1 :(NSArray *) array2 :(NSArray *) array3 :(NSArray *) array4 :(NSArray *) array5 :(NSArray *) array6;


@end
