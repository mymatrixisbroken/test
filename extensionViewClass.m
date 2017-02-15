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
        float rd = 255.00/255.00;
        float gr = 255.00/255.00;
        float bl = 255.00/255.00;

        self.backgroundColor = [UIColor colorWithRed:rd green:gr blue:bl alpha:1.0];
    }
    
    return self;
}

- (id) setView:(CGFloat ) width{
    self.frame = CGRectMake(0, 0, width, 40.f);
    return self;
}

- (id) addButtons:(CGFloat ) width{
//    storeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    storeButton.frame = CGRectMake(0, 0, (width/4), 40.f);
//    [storeButton setImage:[UIImage imageNamed:@"storecopy"] forState:UIControlStateNormal];
//    [storeButton setTintColor:[UIColor lightGrayColor]];
//    
//    strainButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    strainButton.frame = CGRectMake((width/4), 0, (width/4), 40.f);
//    [strainButton setImage:[UIImage imageNamed:@"speciescopy"] forState:UIControlStateNormal];
//    [strainButton setTintColor:[UIColor lightGrayColor]];
//    
//    newsFeedButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    newsFeedButton.frame = CGRectMake((width/4)*2, 0, (width/4), 40.f);
//    [newsFeedButton setImage:[UIImage imageNamed:@"newsfeedcopy"] forState:UIControlStateNormal];
//    [newsFeedButton setTintColor:[UIColor lightGrayColor]];
    
    UILabel *storesLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, -27, 150, 100)];
    [storesLabel setText:@"Stores & Clubs"];
    [storesLabel setFont:[UIFont fontWithName:@"CERVO-THIN" size:25.0]];
//    [storesLabel sizeToFit];
//    [storesLabel setTextColor:[UIColor blueColor]];
    [storesLabel setTextColor:[UIColor colorWithRed:18.0/255.0f green:24.0/255.0f blue:23.0/255.0f alpha:1.0]];
    
    userProfileButton = [UIButton buttonWithType:UIButtonTypeCustom];
    userProfileButton.frame = CGRectMake(self.bounds.size.width-45, (self.bounds.size.height-15)/2, 25.0f, 15.0f);
    [userProfileButton setImage:[UIImage imageNamed:@"FilterSmartObject"] forState:UIControlStateNormal];
    [userProfileButton setTintColor:[UIColor lightGrayColor]];
    
    
    [self addSubview:storeButton];
    [self addSubview:strainButton];
    [self addSubview:storesLabel];
    [self addSubview:userProfileButton];
    
    return self;
}

@end
