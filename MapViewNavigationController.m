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
    
    self.navigationBar.topItem.title = @"Near me";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self   action:@selector(barButtonCustomPressed:)];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"News Feed" style:UIBarButtonItemStylePlain target:self action:nil];
    
//    self.navigationBar.topItem.rightBarButtonItem = rightButton;
    self.navigationBar.topItem.leftBarButtonItem = leftButton;
}

-(IBAction)barButtonCustomPressed:(UIBarButtonItem*)btn
{
    objectsArray.filterSelected = 10;
    [user goToStrainsStoresViewController:self];
}

@end
