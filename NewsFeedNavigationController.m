//
//  BlazedNavigationController.m
//  myProject
//
//  Created by Guy on 8/5/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "NewsFeedNavigationController.h"

@implementation NewsFeedNavigationController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn1 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0,0,25,25);
    [btn1 setBackgroundImage:[UIImage imageNamed:@"selectedNewsFeedIcon"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(newsFeedButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonOne = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    
    
    UIButton *btn2 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0,0,25,25);
    [btn2 setBackgroundImage:[UIImage imageNamed:@"notSelectedStrainIcon"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(strainButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonTwo = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    
    
    UIButton *btn3 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(0,0,25,25);
    [btn3 setBackgroundImage:[UIImage imageNamed:@"notSelectedSearchIcon"] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(userProfileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonThree = [[UIBarButtonItem alloc] initWithCustomView:btn3];
    
    
    UIButton *btn4 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(0,0,25,25);
    [btn4 setBackgroundImage:[UIImage imageNamed:@"notSelectedStoresIcon"] forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(storeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonFour = [[UIBarButtonItem alloc] initWithCustomView:btn4];
    
    
    UIButton *btn5 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn5.frame = CGRectMake(0,0,25,25);
    [btn5 setBackgroundImage:[UIImage imageNamed:@"notSelectedHamburgerIcon"] forState:UIControlStateNormal];
    [btn5 addTarget:self action:@selector(barButtonCustomPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonFive = [[UIBarButtonItem alloc] initWithCustomView:btn5];
    
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    NSArray *buttons = @[buttonOne, space, buttonTwo, space, buttonThree, space, buttonFour, space, buttonFive];
    
    self.navigationBar.topItem.leftBarButtonItems = buttons;
}

-(IBAction)storeButtonPressed:(UIButton*)btn {
    objectsArray.filterSelected = 10;
    objectsArray.strainOrStore = 1;
    [user goToStrainsStoresViewController:self];
}

-(IBAction)strainButtonPressed:(UIButton*)btn {
    objectsArray.filterSelected = 10;
    objectsArray.strainOrStore = 0;
    [user goToStrainsStoresViewController:self];
}

-(IBAction)newsFeedButtonPressed:(UIButton*)btn {
    [user goToNewsFeedViewController:self];
}

-(IBAction)userProfileButtonPressed:(UIButton*)btn {
    FIRUser *youser = [FIRAuth auth].currentUser;
    if(youser.anonymous){
        [user goToUserNotSignedInViewController:self];
    }
    else{
        [user goToCurrentUserProfileViewController:self];
    }
}

-(IBAction)barButtonCustomPressed:(UIBarButtonItem*)btn
{
    [user gotoOptionListViewController:self];
}

@end
