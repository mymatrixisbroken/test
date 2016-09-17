//
//  BlazedNavigationController.m
//  myProject
//
//  Created by Guy on 8/5/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "BlazedNavigationController.h"

@implementation BlazedNavigationController
- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationBar.topItem.title = @"Blazed";
    
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self   action:@selector(barButtonCustomPressed:)];
    self.navigationBar.topItem.rightBarButtonItem = rightButton;
}

-(IBAction)barButtonCustomPressed:(UIBarButtonItem*)btn
{
    [self performSegueWithIdentifier:@"optionsListSegue" sender:self];
}

@end
