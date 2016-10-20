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
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationBar.tintColor = [UIColor whiteColor];

    
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mapview"] style:UIBarButtonItemStylePlain target:self   action:@selector(barButtonCustomPressed:)];
//    UIBarButtonItem *rightButton1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self   action:@selector(barButtonMenuPressed:)];

//    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Strains" style:UIBarButtonItemStylePlain target:self action:nil];
//
//    UIBarButtonItem *leftButton1 = [[UIBarButtonItem alloc] initWithTitle:@"Stores" style:UIBarButtonItemStylePlain target:self action:nil];
    
//    if (objectsArray.selection == 0){
//        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
//            self.navigationBar.topItem.leftBarButtonItem = leftButton;
//                self.navigationBar.topItem.rightBarButtonItem = rightButton1;
//    }
//    else if(objectsArray.selection == 1){
//        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
//            self.navigationBar.topItem.leftBarButtonItem = leftButton1;
////        self.navigationBar.topItem.rightBarButtonItem = rightButton;
//        [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:rightButton, rightButton1, nil]];
//
//    }


//    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self   action:@selector(leftButtonPressed:)];
//    self.navigationBar.topItem.rightBarButtonItem = rightButton;
}

//-(IBAction) leftButtonPressed:(UIBarButtonItem *)btn{
//    objectsArray.searchType = 0;
//    [user goToNewsFeedViewController:self];
//}

//-(IBAction) barButtonMenuPressed:(UIBarButtonItem*)btn
//{
//    objectsArray.flag = !objectsArray.flag;
//}
//
//
//-(IBAction) barButtonCustomPressed:(UIBarButtonItem*)btn
//{
//    [user gotoMapViewViewController:self];
//}

@end

