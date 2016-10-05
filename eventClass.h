//
//  eventClass.h
//  myProject
//
//  Created by Guy on 10/3/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface eventClass : NSObject
@property NSString *eventKey;
@property NSString *userID;
@property NSString *username;
@property NSString *message;
@property NSString *userAvatarURL;
@property NSString *likes;
@property NSString *comments;
@property NSData *imageData;

@end
