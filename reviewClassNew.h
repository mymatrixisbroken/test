//
//  reviewClassNew.h
//  myProject
//
//  Created by Guy on 9/27/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface reviewClassNew : NSObject
@property NSString *reviewKey;
@property NSString *authoredByUserKey;
@property NSString *authoredByUsername;
@property NSString *objectType;
@property NSString *objectKey;
@property NSString *objectName;
@property NSString *objectRating;
@property (nonatomic, assign) NSInteger objectReviewCount;
@property NSString *message;
@property NSString *rating;
@property NSMutableArray *userImageLink;
@property NSMutableArray *objectImageLink;

@end
