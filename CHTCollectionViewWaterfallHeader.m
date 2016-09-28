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

      
      _nearMeButton = [UIButton buttonWithType:UIButtonTypeCustom];
      _nearMeButton.frame = CGRectMake(0, 0, CGRectGetWidth(frame)/3, 40.f);
      [_nearMeButton setImage:[UIImage imageNamed:@"nearme"] forState:UIControlStateNormal];
      [_nearMeButton setTintColor:[UIColor lightGrayColor]];
      [_nearMeButton addTarget:self action:@selector(tappedNearMeButton:) forControlEvents:UIControlEventTouchUpInside];

      _visitedButton = [UIButton buttonWithType:UIButtonTypeCustom];
      _visitedButton.frame = CGRectMake(CGRectGetWidth(frame)/3, 0, CGRectGetWidth(frame)/3, 40.f);
      [_visitedButton setImage:[UIImage imageNamed:@"visited"] forState:UIControlStateNormal];
      [_visitedButton setTintColor:[UIColor lightGrayColor]];
      [_visitedButton addTarget:self action:@selector(tappedVisitedButton:) forControlEvents:UIControlEventTouchUpInside];

      _AtoZButton = [UIButton buttonWithType:UIButtonTypeSystem];
      _AtoZButton.frame = CGRectMake((CGRectGetWidth(frame)/3)*2, 0, CGRectGetWidth(frame)/3, 40.f);
      [_AtoZButton setImage:[UIImage imageNamed:@"A-Z-icon"] forState:UIControlStateNormal];
      [_AtoZButton setTintColor:[UIColor lightGrayColor]];
      [_AtoZButton addTarget:self action:@selector(tappedAtoZButton:) forControlEvents:UIControlEventTouchUpInside];

      
      self.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1];
      [self addSubview:_nearMeButton];
      [self addSubview:_visitedButton];
      [self addSubview:_AtoZButton];
  }
  return self;
}



- (IBAction)tappedAtoZButton:(UIButton *)sender {
    objectsArray.searchType = AtoZ;
    NSLog(@"search type is %u", objectsArray.searchType);
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *vc = [sb instantiateViewControllerWithIdentifier:@"List View Controller  SB ID"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIViewController *rootViewController = window.rootViewController;
    [rootViewController presentViewController:vc animated:YES completion:NULL];
}


- (IBAction)tappedNearMeButton:(UIButton *)sender {
    objectsArray.searchType = nearMe;
    NSLog(@"search type is %u", objectsArray.searchType);
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *vc = [sb instantiateViewControllerWithIdentifier:@"List View Controller  SB ID"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIViewController *rootViewController = window.rootViewController;
    [rootViewController presentViewController:vc animated:YES completion:NULL];
}


@end
