//
//  BlazedNavigationController.m
//  myProject
//
//  Created by Guy on 8/5/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "listNavigationController.h"

@implementation listNavigationController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.topItem.title = @"Blazed";
    
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self   action:@selector(barButtonCustomPressed:)];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self   action:@selector(leftButtonPressed:)];
    self.navigationBar.topItem.rightBarButtonItem = rightButton;
    self.navigationBar.topItem.leftBarButtonItem = leftButton;
}

-(IBAction) leftButtonPressed:(UIBarButtonItem *)btn{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"News Feed Navigation SB ID"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:NULL];
}

-(IBAction) barButtonCustomPressed:(UIBarButtonItem*)btn
{
    [self performSegueWithIdentifier:@"optionsListSegue" sender:self];
}

@end

