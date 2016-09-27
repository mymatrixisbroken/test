//
//  extensionViewClass.m
//  myProject
//
//  Created by Guy on 8/5/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "extensionViewClass.h"

@implementation extensionViewClass
@synthesize storeButton;
@synthesize strainButton;
@synthesize newsFeedButton;
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
    storeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    storeButton.frame = CGRectMake(0, 0, (width/4), 40.f);
    [storeButton setImage:[UIImage imageNamed:@"store"] forState:UIControlStateNormal];
    [storeButton setTintColor:[UIColor lightGrayColor]];
    
    strainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    strainButton.frame = CGRectMake((width/4), 0, (width/4), 40.f);
    [strainButton setImage:[UIImage imageNamed:@"species"] forState:UIControlStateNormal];
    [strainButton setTintColor:[UIColor lightGrayColor]];
    
    newsFeedButton = [UIButton buttonWithType:UIButtonTypeSystem];
    newsFeedButton.frame = CGRectMake((width/4)*2, 0, (width/4), 40.f);
    [newsFeedButton setImage:[UIImage imageNamed:@"newsFeed"] forState:UIControlStateNormal];
    [newsFeedButton setTintColor:[UIColor lightGrayColor]];
    
    userProfileButton = [UIButton buttonWithType:UIButtonTypeCustom];
    userProfileButton.frame = CGRectMake((width/4)*3, 0, (width/4), 40.f);
    [userProfileButton setImage:[UIImage imageNamed:@"user"] forState:UIControlStateNormal];
    [userProfileButton setTintColor:[UIColor lightGrayColor]];
    
    
    [self addSubview:storeButton];
    [self addSubview:strainButton];
    [self addSubview:newsFeedButton];
    [self addSubview:userProfileButton];

    return self;
}
@end
