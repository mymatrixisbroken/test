//
//  CHTCollectionViewWaterfallHeader.m
//  Demo
//
//  Created by Neil Kimmett on 21/10/2013.
//  Copyright (c) 2013 Nelson. All rights reserved.
//

#import "CHTCollectionViewWaterfallHeader.h"

@implementation CHTCollectionViewWaterfallHeader

#pragma mark - Accessors
- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {

      if (objectsArray.selection == 1){
          _nearMeButton = [UIButton buttonWithType:UIButtonTypeCustom];
          _nearMeButton.frame = CGRectMake(0, 0, CGRectGetWidth(frame)/3, 40.f);
          [_nearMeButton setImage:[UIImage imageNamed:@"nearme"] forState:UIControlStateNormal];
          [_nearMeButton setTintColor:[UIColor lightGrayColor]];
          [_nearMeButton addTarget:self action:@selector(tappednearMeRecommendedButton:) forControlEvents:UIControlEventTouchUpInside];
          
          _AtoZButton = [UIButton buttonWithType:UIButtonTypeSystem];
          _AtoZButton.frame = CGRectMake((CGRectGetWidth(frame)/3), 0, CGRectGetWidth(frame)/3, 40.f);
          [_AtoZButton setImage:[UIImage imageNamed:@"A-Z-icon"] forState:UIControlStateNormal];
          [_AtoZButton setTintColor:[UIColor lightGrayColor]];
          [_AtoZButton addTarget:self action:@selector(tappedAtoZButton:) forControlEvents:UIControlEventTouchUpInside];

          _visitedButton = [UIButton buttonWithType:UIButtonTypeCustom];
          _visitedButton.frame = CGRectMake(CGRectGetWidth(frame)/3*2, 0, CGRectGetWidth(frame)/3, 40.f);
          [_visitedButton setImage:[UIImage imageNamed:@"visited"] forState:UIControlStateNormal];
          [_visitedButton setTintColor:[UIColor lightGrayColor]];
          [_visitedButton addTarget:self action:@selector(tappedVisitedSmokedButton:) forControlEvents:UIControlEventTouchUpInside];
          
          
          self.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1];
          [self addSubview:_nearMeButton];
          [self addSubview:_visitedButton];
          [self addSubview:_AtoZButton];
      }
      else if (objectsArray.selection == 0){
          _recommendedButton = [UIButton buttonWithType:UIButtonTypeCustom];
          _recommendedButton.frame = CGRectMake(0, 0, CGRectGetWidth(frame)/3, 40.f);
          [_recommendedButton setImage:[UIImage imageNamed:@"recommended"] forState:UIControlStateNormal];
          [_recommendedButton setTintColor:[UIColor lightGrayColor]];
          [_recommendedButton addTarget:self action:@selector(tappednearMeRecommendedButton:) forControlEvents:UIControlEventTouchUpInside];
          
          _AtoZButton = [UIButton buttonWithType:UIButtonTypeSystem];
          _AtoZButton.frame = CGRectMake((CGRectGetWidth(frame)/4), 0, CGRectGetWidth(frame)/4, 40.f);
          [_AtoZButton setImage:[UIImage imageNamed:@"A-Z-icon"] forState:UIControlStateNormal];
          [_AtoZButton setTintColor:[UIColor lightGrayColor]];
          [_AtoZButton addTarget:self action:@selector(tappedAtoZButton:) forControlEvents:UIControlEventTouchUpInside];

          _smokedButton = [UIButton buttonWithType:UIButtonTypeCustom];
          _smokedButton.frame = CGRectMake(CGRectGetWidth(frame)/4*2, 0, CGRectGetWidth(frame)/4, 40.f);
          [_smokedButton setImage:[UIImage imageNamed:@"smoked"] forState:UIControlStateNormal];
          [_smokedButton setTintColor:[UIColor lightGrayColor]];
          [_smokedButton addTarget:self action:@selector(tappedVisitedSmokedButton:) forControlEvents:UIControlEventTouchUpInside];
          
          _wishListButton = [UIButton buttonWithType:UIButtonTypeSystem];
          _wishListButton.frame = CGRectMake((CGRectGetWidth(frame)/4)*3, 0, CGRectGetWidth(frame)/4, 40.f);
          [_wishListButton setImage:[UIImage imageNamed:@"wishlist"] forState:UIControlStateNormal];
          [_wishListButton setTintColor:[UIColor lightGrayColor]];
          [_wishListButton addTarget:self action:@selector(tappedWishListButton:) forControlEvents:UIControlEventTouchUpInside];


          self.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1];
          [self addSubview:_recommendedButton];
          [self addSubview:_smokedButton];
          [self addSubview:_wishListButton];
          [self addSubview:_AtoZButton];
      }

  }
  return self;
}

- (IBAction)tappednearMeRecommendedButton:(UIButton *)sender {
    objectsArray.searchType = nearMeRecommended;
    NSLog(@"search type is %u", objectsArray.searchType);
    
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            [(UIViewController*)nextResponder viewDidLoad];
        }
    }
}

- (IBAction)tappedAtoZButton:(UIButton *)sender {
    objectsArray.searchType = AtoZ;
    NSLog(@"search type is %u", objectsArray.searchType);
    
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            [(UIViewController*)nextResponder viewDidLoad];
        }
    }
}

- (IBAction)tappedVisitedSmokedButton:(UIButton *)sender {
    objectsArray.searchType = visitedSmoked;
    NSLog(@"search type is %u", objectsArray.searchType);
    
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            [(UIViewController*)nextResponder viewDidLoad];
        }
    }
}

- (IBAction)tappedWishListButton:(UIButton *)sender {
    objectsArray.searchType = wishList;
    NSLog(@"search type is %u", objectsArray.searchType);
    
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            [(UIViewController*)nextResponder viewDidLoad];
        }
    }
}




@end
