//
//  CreateAccountNavigationController.m
//  myProject
//
//  Created by Guy on 9/26/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "CreateAccountNavigationController.h"

@interface CreateAccountNavigationController ()

@end

@implementation CreateAccountNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UILabel *navLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,320,40)];
//    navLabel.textAlignment = NSTextAlignmentLeft;
//    navLabel.text = @"CREATING CHEEBA ACCOUNT";
//    navLabel.textColor = [UIColor whiteColor];
//    [self.navigationItem.titleView addSubview: navLabel];
    
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
//    self.navigationBar.topItem.title = @"CREATING CHEEBA ACCOUNT";
    
    UILabel *yourLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,0, self.view.bounds.size.width,50)];
    yourLabel.text = @"CREATING BLAZE ACCOUNT";
    yourLabel.font = [UIFont fontWithName:@"NEXA LIGHT" size:14.0];
    yourLabel.textColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1];

    [self.navigationBar addSubview:yourLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [imageView setImage:[UIImage imageNamed:@"HamburgerIcon"]];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:imageView];
    
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Asset 1"] style:UIBarButtonItemStylePlain target:self   action:@selector(leftButtonPressed:)];
    self.navigationBar.topItem.rightBarButtonItem = rightButton;


    
//    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self   action:@selector(leftButtonPressed:)];
//    self.navigationBar.topItem.leftBarButtonItem = leftButton;
    
    
//    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self   action:@selector(barButtonCustomPressed:)];
//    self.navigationBar.topItem.rightBarButtonItem = rightButton;
}

-(IBAction) leftButtonPressed:(UIBarButtonItem *)btn{
    [user goToUserNotFoundViewController:self];
}

//-(IBAction) barButtonCustomPressed:(UIBarButtonItem*)btn
//{
//    [user gotoOptionListViewController:self];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
