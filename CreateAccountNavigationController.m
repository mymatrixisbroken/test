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
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationBar.topItem.title = @"Create Accout";
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self   action:@selector(leftButtonPressed:)];
    self.navigationBar.topItem.leftBarButtonItem = leftButton;
    
    
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
