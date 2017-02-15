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
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
//    self.navigationBar.tintColor = [UIColor whiteColor];
//    
//    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
//    
//    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self   action:@selector(barButtonCustomPressed:)];
//    
//    self.navigationBar.topItem.leftBarButtonItem = leftButton;
    
    UIImageView *imageViewOne = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [imageViewOne setImage:[UIImage imageNamed:@"NewsFeedIcon"]];
    
    UIBarButtonItem *buttonOne = [[UIBarButtonItem alloc] initWithCustomView:imageViewOne];

    UIImageView *imageViewTwo = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/5, 0, 25, 25)];
    [imageViewTwo setImage:[UIImage imageNamed:@"StrainIcon"]];
    
    UIBarButtonItem *buttonTwo = [[UIBarButtonItem alloc] initWithCustomView:imageViewTwo];

    UIImageView *imageViewThree = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width/5)*2, 0, 25, 25)];
    [imageViewThree setImage:[UIImage imageNamed:@"SearchIcon"]];
    
    UIBarButtonItem *buttonThree = [[UIBarButtonItem alloc] initWithCustomView:imageViewThree];

    UIImageView *imageViewFour = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width/5)*3, 0, 25, 25)];
    [imageViewFour setImage:[UIImage imageNamed:@"StoresIcon"]];
    
    UIBarButtonItem *buttonFour = [[UIBarButtonItem alloc] initWithCustomView:imageViewFour];

    UIImageView *imageViewFive = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [imageViewFive setImage:[UIImage imageNamed:@"HamburgerIcon"]];
    
    UIBarButtonItem *buttonFive = [[UIBarButtonItem alloc] initWithCustomView:imageViewFive];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//    space.width = 30;
    
    NSArray *buttons = @[buttonOne, space, buttonTwo, space, buttonThree, space, buttonFour, space, buttonFive];
    
    self.navigationBar.topItem.leftBarButtonItems = buttons;


//    self.navigationBar.topItem.rightBarButtonItem = rightButton;
//    [self.navigationBar.topItem setLeftBarButtonItems:[NSArray arrayWithObjects:, nil]];


}

-(IBAction)barButtonCustomPressed:(UIBarButtonItem*)btn
{
    [user gotoOptionListViewController:self];
}

@end

