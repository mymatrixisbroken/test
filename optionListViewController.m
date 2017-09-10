//
//  FirstViewController.m
//  myProject
//
//  Created by Guy on 6/15/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "optionListViewController.h"
@interface optionListViewController ()

@end

@implementation optionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentUser = [FIRAuth auth].currentUser;
    [self getRowCount];
    
//    CALayer *topBorder = [CALayer layer];
//    topBorder.frame = CGRectMake(0,0,_menuView.bounds.size.width,1);
//    topBorder.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:57.0/255.0 blue:47.0/255.0 alpha:1].CGColor;
//    [_menuView.layer addSublayer:topBorder];
// Do any additional setup after loading the view, typically from a nib.
}

- (void) getRowCount{
    if (_currentUser.anonymous) {
        _rowCount = 3;
    } else {
        _rowCount = 5;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
