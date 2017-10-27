//
//  bookmarkClass.h
//  myProject
//
//  Created by Guy on 10/23/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface bookmarkClass : NSObject
@property NSString *bookmarkName;
@property NSString *bookmarkRating;
@property (nonatomic, assign) NSInteger bookmarkReviewCount;
@property NSMutableArray *bookmarkImageLink;

@end
