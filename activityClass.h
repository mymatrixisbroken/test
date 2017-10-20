//
//  eventClass.h
//  myProject
//
//  Created by Guy on 10/3/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class activityClass;
extern activityClass *activity;

@interface activityClass : NSObject
@property NSString *activityKey;
@property NSString *objectKey;
@property NSString *objectName;
@property NSMutableArray *userImageKey;
@property NSMutableArray *userImageLink;
@property NSMutableArray *objectImagesArray;
@property (nonatomic, assign) float objectRating;
@property NSString *userKey;
@property NSString *instantiationMessage;
@property NSString *instantiationRating;
@property NSString *username;
@property NSString *userID;
@property NSString *message;
@property NSInteger objectReviewCount;
//@property NSString *userAvatarURL;
@property NSString *userAvatarData;
@property NSString *activityType;
//@property NSString *objectURL;
@property NSString *reviewRating;
@property NSString *reviewMessage;
@property NSData *objectData;
@property NSMutableArray *likes;
@property NSMutableArray *comments;
@property NSData *userImageData;

+ (activityClass *)sharedInstance;


@end
