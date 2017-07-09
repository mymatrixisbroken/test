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
@property UIButton *firstButton;
@property UIButton *secondButton;
@property UIButton *thirdButton;
@property UIButton *fourthButton;
@property UILabel *extensionViewLabel;

@end
