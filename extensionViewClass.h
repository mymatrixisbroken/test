//
//  extensionViewClass.h
//  myProject
//
//  Created by Guy on 8/5/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface extensionViewClass : UIView
- (id) setView:(CGFloat ) width;
- (id) addButtons:(CGFloat ) width;
@property UIButton *storeButton;
@property UIButton *strainButton;
@property UIButton *newsFeedButton;
@property UIButton *userProfileButton;

@end
