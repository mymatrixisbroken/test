//
//  eventClass.h
//  myProject
//
//  Created by Guy on 10/3/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class eventClass;
extern eventClass *event;

@interface eventClass : NSObject
@property NSString *eventKey;
@property NSString *userID;
@property NSString *username;
@property NSString *message;
@property NSString *userAvatarURL;
@property NSString *eventType;
@property NSString *objectName;
@property NSString *objectRating;
@property NSString *objectURL;
@property NSString *reviewRating;
@property NSString *reviewMessage;
@property NSData *objectData;
@property NSMutableArray *likes;
@property NSMutableArray *comments;
@property NSData *userImageData;

+ (eventClass *)sharedInstance;


@end
