//
//  MapViewNavigationController.m
//  myProject
//
//  Created by Guy on 10/12/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "MapViewNavigationController.h"

@interface MapViewNavigationController ()

@end

@implementation MapViewNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.navigationBar.topItem.title = @"Blazed";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self   action:@selector(barButtonCustomPressed:)];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"News Feed" style:UIBarButtonItemStylePlain target:self action:nil];
    
    self.navigationBar.topItem.rightBarButtonItem = rightButton;
    self.navigationBar.topItem.leftBarButtonItem = leftButton;
}

-(IBAction)barButtonCustomPressed:(UIBarButtonItem*)btn
{
    [user gotoOptionListViewController:self];
}

@end
