//
//  SecondViewController.h
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TLYShyNavBar/TLYShyNavBarManager.h>
#import "extensionViewClass.h"
#import "userClass.h"
#import "newsFeedCell.h"
#import "FirebaseReferenceClass.h"
#import "ViewController.h"
#import "objectsArrayClass.h"
@import Firebase;

@interface NewsFeedViewController : UIViewController <UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

