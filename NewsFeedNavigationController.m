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

    //    self.navigationBar.topItem.title = @"Blazed";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self   action:@selector(barButtonCustomPressed:)];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"News Feed" style:UIBarButtonItemStylePlain target:self action:nil];
    
//    self.navigationBar.topItem.rightBarButtonItem = rightButton;
    self.navigationBar.topItem.title = @"News Feed";
    self.navigationBar.topItem.leftBarButtonItem = leftButton;
}

-(IBAction)barButtonCustomPressed:(UIBarButtonItem*)btn
{
    [user gotoOptionListViewController:self];
}

@end
