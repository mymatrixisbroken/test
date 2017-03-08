//
//  TableViewController.m
//  myProject
//
//  Created by Guy on 3/6/17.
//  Copyright © 2017 Joaquin. All rights reserved.
//

#import "FilterMenuTableViewController.h"

@interface FilterMenuTableViewController ()

@end

@implementation FilterMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    objectsArray.searchType = indexPath.row;
    
    [user goToStrainsStoresViewController:self];
}

@end
