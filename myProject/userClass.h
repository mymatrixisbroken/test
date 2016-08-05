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
@property NSMutableArray *wish_list;
@property NSMutableArray *friends;
@property NSMutableArray *reviews;
@property NSMutableArray *badges;
@property NSMutableArray *strains_tried;
@property NSMutableArray *stores_visited;

+ (userClass *)sharedInstance;
-(id)createEmptyUserObject;
-(id)setClassObject:key Values:(NSDictionary *)dict :(NSMutableArray *) array1 :(NSMutableArray *) array2 :(NSMutableArray *) array3 :(NSMutableArray *) array4 :(NSMutableArray *) array5 :(NSMutableArray *) array6;


@end
