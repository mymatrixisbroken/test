//
//  StoreReviewTableViewController.m
//  myProject
//
//  Created by Guy on 10/24/16.
//  Copyright © 2016 Joaquin. All rights reserved.
//

#import "StoreReviewTableViewController.h"

@interface StoreReviewTableViewController ()

@end

@implementation StoreReviewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"store reviews count %lu", store.reviews.count);
    return [store.reviews count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"StoreReviewCell";
    StoreReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    reviewClass *tempReview = [[reviewClass alloc] init];
    tempReview = [store.reviews objectAtIndex:indexPath.row];
    
    [cell uploadCellWithReview:tempReview];
    
    return cell;
}

@end
