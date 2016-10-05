//
//  BlazedNavigationController.m
//  myProject
//
//  Created by Guy on 8/5/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "ListNavigationController.h"

@implementation ListNavigationController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationBar.tintColor = [UIColor whiteColor];

    
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self   action:@selector(barButtonCustomPressed:)];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self   action:@selector(leftButtonPressed:)];
//    self.navigationBar.topItem.rightBarButtonItem = rightButton;
    self.navigationBar.topItem.leftBarButtonItem = leftButton;
}

-(IBAction) leftButtonPressed:(UIBarButtonItem *)btn{
    objectsArray.searchType = 0;
    [user goToNewsFeedViewController:self];
}

-(IBAction) barButtonCustomPressed:(UIBarButtonItem*)btn
{
    [user gotoOptionListViewController:self];
}

@end

