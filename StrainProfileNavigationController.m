//
//  StrainProfileNavigationController.m
//  myProject
//
//  Created by Guy on 9/26/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "StrainProfileNavigationController.h"

@interface StrainProfileNavigationController ()

@end

@implementation StrainProfileNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    self.navigationBar.topItem.title = strain.strainName;

    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self   action:@selector(barButtonCustomPressed:)];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self   action:@selector(leftButtonPressed:)];
    
    self.navigationBar.topItem.rightBarButtonItem = rightButton;
    self.navigationBar.topItem.leftBarButtonItem = leftButton;
}

-(IBAction) leftButtonPressed:(UIBarButtonItem *)btn{
    [user goToStrainsStoresViewController:self];
}


-(IBAction)barButtonCustomPressed:(UIBarButtonItem*)btn
{
    FIRUser *currentUser = [FIRAuth auth].currentUser;
    if(currentUser.anonymous){
        [user gotoOptionListViewController:self];
        
    } else {
        [user gotoOptionListSignedInViewController:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
