//
//  SearchFriendsNavigationController.m
//  myProject
//
//  Created by Guy on 9/26/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "SearchFriendsNavigationController.h"

@interface SearchFriendsNavigationController ()

@end

@implementation SearchFriendsNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];

    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self   action:@selector(barButtonCustomPressed:)];

    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Search Ents" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationBar.topItem.rightBarButtonItem = rightButton;

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
