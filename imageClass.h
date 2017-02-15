//
//  imageClass.h
//  myProject
//
//  Created by Guy on 10/21/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface imageClass : NSObject
@property NSString *imageURL;
@property NSMutableArray *imageThumbsUp;
@property NSMutableArray *imageThumbsDown;
@property NSInteger voteScore;
@property NSInteger firebaseIndex;
@property NSData *data;
@property NSString *dataString;

@end
