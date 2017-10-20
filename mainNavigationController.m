//
//  mainNavigationController.m
//  myProject
//
//  Created by Guy on 8/26/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import "mainNavigationController.h"

@interface mainNavigationController ()

@end

@implementation mainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, self.view.frame.size.width,49.0)];

    
    UIButton *btn1 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0,0,25,25);
    btn1.imageView.frame = CGRectMake(0,0,25,25);
    if (user.mainNavigationSelected == 0) {
        [btn1 setBackgroundImage:[UIImage imageNamed:@"newsFeedGreenIcon"] forState:UIControlStateNormal];
    } else {
        [btn1 setBackgroundImage:[UIImage imageNamed:@"newsFeedWhiteIcon"] forState:UIControlStateNormal];
    }
    [btn1 addTarget:self action:@selector(newsFeedButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonOne = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    
    
    UIButton *btn2 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0,0,25,25);
    btn2.imageView.frame = CGRectMake(0,0,25,25);
    if (user.mainNavigationSelected == 1) {
        [btn2 setBackgroundImage:[UIImage imageNamed:@"mapGreenIcon"] forState:UIControlStateNormal];
    } else {
        [btn2 setBackgroundImage:[UIImage imageNamed:@"mapWhiteIcon"] forState:UIControlStateNormal];
    }
    [btn2 addTarget:self action:@selector(strainButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonTwo = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    
    
    UIButton *btn3 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(0,0,25,25);
    btn3.imageView.frame = CGRectMake(0,0,25,25);
    if (user.mainNavigationSelected == 2) {
        [btn3 setBackgroundImage:[UIImage imageNamed:@"searchGreenIcon"] forState:UIControlStateNormal];
    } else {
        [btn3 setBackgroundImage:[UIImage imageNamed:@"searchWhiteIcon"] forState:UIControlStateNormal];
    }
    [btn3 addTarget:self action:@selector(searchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonThree = [[UIBarButtonItem alloc] initWithCustomView:btn3];
    
    
    UIButton *btn4 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(0,0,25,25);
    btn4.imageView.frame = CGRectMake(0,0,25,25);
    if (user.mainNavigationSelected == 3) {
        [btn4 setBackgroundImage:[UIImage imageNamed:@"storesGreenIcon"] forState:UIControlStateNormal];
    } else {
        [btn4 setBackgroundImage:[UIImage imageNamed:@"storesWhiteIcon"] forState:UIControlStateNormal];
    }
    [btn4 addTarget:self action:@selector(storeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonFour = [[UIBarButtonItem alloc] initWithCustomView:btn4];
    
    
    UIButton *btn5 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn5.frame = CGRectMake(0,0,25,25);
    btn5.imageView.frame = CGRectMake(0,0,25,25);
    [btn5 setBackgroundImage:[UIImage imageNamed:@"hamburgerWhiteIcon"] forState:UIControlStateNormal];
    [btn5 addTarget:self action:@selector(barButtonCustomPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonFive = [[UIBarButtonItem alloc] initWithCustomView:btn5];
    
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    space.width = 55;
    
    NSArray *buttons = @[buttonOne, space, buttonTwo, space, buttonThree, space, buttonFour, space, buttonFive];
    
    self.navigationBar.topItem.leftBarButtonItems = buttons;
}

-(IBAction)newsFeedButtonPressed:(UIButton*)btn {
    user.mainNavigationSelected = 0;
    [user goToNewsFeedViewController:self];
}

-(IBAction)strainButtonPressed:(UIButton*)btn {
    [user gotoMapViewViewController:self];

//    user.mainNavigationSelected = 1;
//    objectsArray.filterSelected = 10;
//    objectsArray.strainOrStore = 0;
//    [user goToStrainsViewController:self];
}

-(IBAction)searchButtonPressed:(UIButton*)btn {
    user.mainNavigationSelected = 2;
    [user goToSearchViewController:self];
}


-(IBAction)userProfileButtonPressed:(UIButton*)btn {
    user.mainNavigationSelected = 2;
    FIRUser *youser = [FIRAuth auth].currentUser;
    if(youser.anonymous){
        [user goToUserNotSignedInViewController:self];
    }
    else{
        [user goToCurrentUserProfileViewController:self];
    }
}

-(IBAction)storeButtonPressed:(UIButton*)btn {
    user.mainNavigationSelected = 3;
    objectsArray.filterSelected = 10;
    objectsArray.strainOrStore = 1;
    [user goToStrainsStoresViewController:self];
}


-(IBAction)barButtonCustomPressed:(UIBarButtonItem*)btn
{
    FIRUser *currentUser = [FIRAuth auth].currentUser;
    if(currentUser.anonymous){
        [user gotoOptionListViewController:self];
        
    } else {
        [user gotoOptionListSignedInViewController:self];
    }
}

@end
