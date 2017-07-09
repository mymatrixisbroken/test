//
//  photosNavigationController.m
//  myProject
//
//  Created by Guy on 9/26/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "PhotosNavigationController.h"

@interface PhotosNavigationController ()

@end

@implementation PhotosNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationBar.topItem.title = @"Photos";
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self   action:@selector(leftButtonPressed:)];
    self.navigationBar.topItem.leftBarButtonItem = leftButton;

    
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self   action:@selector(barButtonCustomPressed:)];
    self.navigationBar.topItem.rightBarButtonItem = rightButton;
}

-(IBAction) leftButtonPressed:(UIBarButtonItem *)btn{
    if (objectsArray.strainOrStore == 0){
        [user goToStrainProfileViewController:self];}
    else if (objectsArray.strainOrStore == 1){
        [user goToStoreProfileViewController:self];}
}

-(IBAction) barButtonCustomPressed:(UIBarButtonItem*)btn
{
    [user gotoOptionListViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
