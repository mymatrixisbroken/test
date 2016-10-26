//
//  CurrentUserNavigationController.m
//  myProject
//
//  Created by Guy on 9/26/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "CurrentUserNavigationController.h"

@interface CurrentUserNavigationController ()

@end

@implementation CurrentUserNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.navigationBar.topItem.title = @"Blazed";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self   action:@selector(barButtonCustomPressed:)];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"About me" style:UIBarButtonItemStylePlain target:self action:nil];
    
//    self.navigationBar.topItem.rightBarButtonItem = rightButton;
    self.navigationBar.topItem.title = @"About Me";
    self.navigationBar.topItem.leftBarButtonItem = leftButton;
}

-(IBAction)barButtonCustomPressed:(UIBarButtonItem*)btn
{
    [user gotoOptionListViewController:self];
}

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
