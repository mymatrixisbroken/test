//
//  extensionViewClass.m
//  myProject
//
//  Created by Guy on 8/5/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "extensionViewClass.h"

@implementation extensionViewClass
@synthesize newsFeedButton;
@synthesize friendsButton;
@synthesize searchButton;
@synthesize userProfileButton;

- (id)init {
    self = [super init];
    if (self) {
        float rd = 19.0/255.00;
        float gr = 128.00/255.00;
        float bl = 0.0/255.00;

        self.backgroundColor = [UIColor colorWithRed:rd green:gr blue:bl alpha:1.0];
    }
    return self;
}

- (id) setView:(CGFloat ) width{
    self.frame = CGRectMake(0, 0, width, 40.f);
    return self;
}

- (id) addButtons:(CGFloat ) width{
    newsFeedButton = [UIButton buttonWithType:UIButtonTypeSystem];
    newsFeedButton.frame = CGRectMake(0, 0, width/4, 40.f);
    [newsFeedButton setImage:[UIImage imageNamed:@"newsFeed"] forState:UIControlStateNormal];
    [newsFeedButton setTintColor:[UIColor lightGrayColor]];
    
    friendsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    friendsButton.frame = CGRectMake(width/4, 0, width/4, 40.f);
    [friendsButton setImage:[UIImage imageNamed:@"friends"] forState:UIControlStateNormal];
    [friendsButton setTintColor:[UIColor lightGrayColor]];
    
    searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake((width/4)*2, 0, (width/4), 40.f);
    [searchButton setImage:[UIImage imageNamed:@"Search"] forState:UIControlStateNormal];
    [searchButton setTintColor:[UIColor lightGrayColor]];
    
    userProfileButton = [UIButton buttonWithType:UIButtonTypeCustom];
    userProfileButton.frame = CGRectMake((width/4)*3, 0, (width/4), 40.f);
    [userProfileButton setImage:[UIImage imageNamed:@"user"] forState:UIControlStateNormal];
    [userProfileButton setTintColor:[UIColor lightGrayColor]];
    
    
    [self addSubview:newsFeedButton];
    [self addSubview:friendsButton];
    [self addSubview:searchButton];
    [self addSubview:userProfileButton];

    return self;
}
@end
