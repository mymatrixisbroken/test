//
//  SecondViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "ListViewController.h"
@interface ListViewController ()
@end

@implementation ListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)tappedCancelButton:(UIBarButtonItem *)sender {
    
    [self performSegueWithIdentifier:@"listToHomepageSegue" sender:self];
}


@end
