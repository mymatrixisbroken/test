//
//  StoreProfileNavigationController.m
//  myProject
//
//  Created by Guy on 9/28/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "StoreProfileNavigationController.h"

@interface StoreProfileNavigationController ()

@end

@implementation StoreProfileNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

    
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
//    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
//    self.navigationBar.topItem.title = store.storeName;
//    
//    
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self   action:@selector(barButtonCustomPressed:)];
//    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self   action:@selector(leftButtonPressed:)];
//    
//    self.navigationBar.topItem.rightBarButtonItem = rightButton;
//    self.navigationBar.topItem.leftBarButtonItem = leftButton;
}

-(IBAction) leftButtonPressed:(UIBarButtonItem *)btn{
    [user goToStrainsStoresViewController:self];
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
